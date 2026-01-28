import Foundation
import CloudKit
import Combine

// MARK: - CloudKit Manager

/// Manages iCloud sync for user preferences, saved articles, and reading stats.
/// Falls back to UserDefaults when offline.
@Observable
final class CloudKitManager {
    static let shared = CloudKitManager()

    // MARK: - State

    private(set) var userPreferences: UserPreferences
    private(set) var readingStats: ReadingStats
    private(set) var savedStoryIDs: Set<UUID>
    private(set) var isSyncing: Bool = false
    private(set) var lastSyncError: Error?

    // MARK: - CloudKit

    private let container: CKContainer
    private let privateDatabase: CKDatabase
    private let recordType = "UserData"
    private let recordID = CKRecord.ID(recordName: "UserDataRecord")

    // MARK: - Local Cache Keys

    private enum CacheKeys {
        static let preferences = "cachedUserPreferences"
        static let stats = "cachedReadingStats"
        static let savedIDs = "cachedSavedStoryIDs"
        static let pendingSync = "pendingSyncChanges"
        static let homepageFeed = "cachedHomepageFeed"
        static let feedTimestamp = "feedTimestamp"
        static let featuredId = "cachedFeaturedId"
    }

    // MARK: - Feed Cache

    private(set) var cachedFeedIds: [UUID] = []
    private(set) var feedTimestamp: Date = .distantPast
    private(set) var cachedFeaturedId: UUID?

    // MARK: - Debounce

    private var saveTask: Task<Void, Never>?
    private let saveDebounceInterval: TimeInterval = 0.5

    // MARK: - Init

    private init() {
        self.container = CKContainer(identifier: "iCloud.com.magazinescroll.app")
        self.privateDatabase = container.privateCloudDatabase

        // Load from local cache first
        self.userPreferences = Self.loadFromCache(key: CacheKeys.preferences) ?? UserPreferences()
        self.readingStats = Self.loadFromCache(key: CacheKeys.stats) ?? ReadingStats()
        self.savedStoryIDs = Self.loadFromCache(key: CacheKeys.savedIDs) ?? []

        // Load feed cache
        self.cachedFeedIds = Self.loadFromCache(key: CacheKeys.homepageFeed) ?? []
        self.feedTimestamp = Self.loadFromCache(key: CacheKeys.feedTimestamp) ?? .distantPast
        self.cachedFeaturedId = Self.loadFromCache(key: CacheKeys.featuredId)
    }

    // MARK: - Public API

    /// Fetch latest data from iCloud and merge with local cache
    func syncFromCloud() async {
        guard !isSyncing else { return }
        isSyncing = true
        lastSyncError = nil

        do {
            let record = try await privateDatabase.record(for: recordID)
            await mergeCloudRecord(record)
        } catch let error as CKError where error.code == .unknownItem {
            // No record exists yet - this is fine for new users
        } catch {
            lastSyncError = error
            print("CloudKit sync error: \(error)")
        }

        isSyncing = false
    }

    /// Save changes to iCloud (debounced)
    func saveToCloud() {
        saveTask?.cancel()
        saveTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(saveDebounceInterval * 1_000_000_000))
            guard !Task.isCancelled else { return }
            await performSave()
        }
    }

    // MARK: - User Preferences

    func updatePreferences(_ preferences: UserPreferences) {
        var updated = preferences
        updated.lastUpdated = Date()
        self.userPreferences = updated
        Self.saveToCache(updated, key: CacheKeys.preferences)

        // Invalidate feed cache when preferences change to force regeneration
        invalidateFeedCache()

        saveToCloud()
    }

    func setOnboardingCompleted() {
        var preferences = userPreferences
        preferences.hasCompletedOnboarding = true
        preferences.lastUpdated = Date()
        self.userPreferences = preferences
        Self.saveToCache(preferences, key: CacheKeys.preferences)
        saveToCloud()
    }

    var hasCompletedOnboarding: Bool {
        userPreferences.hasCompletedOnboarding
    }

    // MARK: - Saved Stories

    func saveStory(_ id: UUID) {
        savedStoryIDs.insert(id)
        Self.saveToCache(savedStoryIDs, key: CacheKeys.savedIDs)
        saveToCloud()
    }

    func unsaveStory(_ id: UUID) {
        savedStoryIDs.remove(id)
        Self.saveToCache(savedStoryIDs, key: CacheKeys.savedIDs)
        saveToCloud()
    }

    func toggleSave(_ id: UUID) {
        if savedStoryIDs.contains(id) {
            unsaveStory(id)
        } else {
            saveStory(id)
        }
    }

    func isSaved(_ id: UUID) -> Bool {
        savedStoryIDs.contains(id)
    }

    // MARK: - Reading Stats

    func markArticleRead(_ storyId: UUID, category: String?) {
        var stats = readingStats
        stats.markArticleRead(storyId, category: category)
        self.readingStats = stats
        Self.saveToCache(stats, key: CacheKeys.stats)
        saveToCloud()
    }

    func hasReadArticle(_ storyId: UUID) -> Bool {
        readingStats.hasRead(storyId)
    }

    func likeArticle(_ storyId: UUID, category: String?) {
        var stats = readingStats
        stats.markArticleLiked(storyId, category: category)
        self.readingStats = stats
        Self.saveToCache(stats, key: CacheKeys.stats)
        saveToCloud()
    }

    func hasLikedArticle(_ storyId: UUID) -> Bool {
        readingStats.hasLiked(storyId)
    }

    // MARK: - Engagement Tracking

    func recordEngagement(_ engagement: ArticleEngagement) {
        print("[Engagement] Recording: \(engagement.pagesViewed)/\(engagement.totalPages) pages, \(Int(engagement.readingDuration))s, liked: \(engagement.wasLiked), category: \(engagement.category ?? "none")")

        // Store individual engagement
        var stats = readingStats
        stats.articleEngagements[engagement.storyId] = engagement

        // Update category aggregate
        if let category = engagement.category {
            var catEngagement = stats.categoryEngagement[category] ?? CategoryEngagement()

            // Rolling average update
            let n = Double(catEngagement.totalReads)
            catEngagement.averageCompletionRate = (catEngagement.averageCompletionRate * n + engagement.completionRate) / (n + 1)
            catEngagement.averageReadingTime = (catEngagement.averageReadingTime * n + engagement.readingDuration) / (n + 1)
            catEngagement.totalReads += 1
            if engagement.wasLiked { catEngagement.totalLikes += 1 }
            catEngagement.lastUpdated = Date()

            stats.categoryEngagement[category] = catEngagement
        }

        // Prune old engagements (keep last 100)
        if stats.articleEngagements.count > 100 {
            let sorted = stats.articleEngagements.sorted {
                $0.value.enterTime < $1.value.enterTime
            }
            let toRemove = sorted.prefix(stats.articleEngagements.count - 100)
            for (id, _) in toRemove {
                stats.articleEngagements.removeValue(forKey: id)
            }
        }

        self.readingStats = stats
        Self.saveToCache(stats, key: CacheKeys.stats)
        saveToCloud()
    }

    /// Record when a user likes a story from the exploration tab (conversion)
    func recordExplorationConversion(category: String) {
        print("[Exploration] Conversion recorded for category: \(category)")
        var prefs = userPreferences
        prefs.explorationConversions[category, default: 0] += 1
        prefs.lastUpdated = Date()
        self.userPreferences = prefs
        Self.saveToCache(prefs, key: CacheKeys.preferences)
        saveToCloud()
    }

    // MARK: - Homepage Feed Cache

    /// Cache the homepage feed for persistence across tab switches
    func cacheFeed(storyIds: [UUID], featuredId: UUID?) {
        cachedFeedIds = storyIds
        cachedFeaturedId = featuredId
        feedTimestamp = Date()

        Self.saveToCache(cachedFeedIds, key: CacheKeys.homepageFeed)
        Self.saveToCache(feedTimestamp, key: CacheKeys.feedTimestamp)
        if let featuredId = featuredId {
            Self.saveToCache(featuredId, key: CacheKeys.featuredId)
        }
    }

    /// Check if feed cache is valid (less than 30 minutes old)
    var isFeedCacheValid: Bool {
        let timeSinceCache = Date().timeIntervalSince(feedTimestamp)
        return timeSinceCache < 1800 && !cachedFeedIds.isEmpty  // 30 minutes = 1800 seconds
    }

    /// Invalidate feed cache (force regeneration on next load)
    func invalidateFeedCache() {
        cachedFeedIds = []
        cachedFeaturedId = nil
        feedTimestamp = .distantPast

        UserDefaults.standard.removeObject(forKey: CacheKeys.homepageFeed)
        UserDefaults.standard.removeObject(forKey: CacheKeys.featuredId)
        UserDefaults.standard.removeObject(forKey: CacheKeys.feedTimestamp)
    }

    // MARK: - Private: CloudKit Operations

    private func performSave() async {
        do {
            let record: CKRecord
            do {
                record = try await privateDatabase.record(for: recordID)
            } catch let error as CKError where error.code == .unknownItem {
                record = CKRecord(recordType: recordType, recordID: recordID)
            }

            // Encode preferences
            if let prefsData = try? JSONEncoder().encode(userPreferences) {
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("prefs.json")
                try? prefsData.write(to: tempURL)
                record["quizAnswers"] = CKAsset(fileURL: tempURL)
            }

            // Encode stats
            if let statsData = try? JSONEncoder().encode(readingStats) {
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("stats.json")
                try? statsData.write(to: tempURL)
                record["readingStats"] = CKAsset(fileURL: tempURL)
            }

            // Save story IDs
            record["savedStoryIDs"] = savedStoryIDs.map { $0.uuidString } as [String]
            record["articlesRead"] = readingStats.articlesRead.map { $0.uuidString } as [String]
            record["hasCompletedOnboarding"] = userPreferences.hasCompletedOnboarding
            record["lastUpdated"] = Date()

            try await privateDatabase.save(record)
        } catch {
            print("CloudKit save error: \(error)")
            lastSyncError = error
        }
    }

    @MainActor
    private func mergeCloudRecord(_ record: CKRecord) {
        // Merge preferences (cloud wins if newer)
        if let asset = record["quizAnswers"] as? CKAsset,
           let url = asset.fileURL,
           let data = try? Data(contentsOf: url),
           let cloudPrefs = try? JSONDecoder().decode(UserPreferences.self, from: data) {
            if cloudPrefs.lastUpdated > userPreferences.lastUpdated {
                userPreferences = cloudPrefs
                Self.saveToCache(cloudPrefs, key: CacheKeys.preferences)
            }
        }

        // Merge stats (combine read articles and liked articles)
        if let asset = record["readingStats"] as? CKAsset,
           let url = asset.fileURL,
           let data = try? Data(contentsOf: url),
           let cloudStats = try? JSONDecoder().decode(ReadingStats.self, from: data) {
            var mergedStats = readingStats
            for articleId in cloudStats.articlesRead where !mergedStats.articlesRead.contains(articleId) {
                mergedStats.articlesRead.append(articleId)
            }
            for (category, count) in cloudStats.categoryReadCounts {
                mergedStats.categoryReadCounts[category] = max(
                    mergedStats.categoryReadCounts[category] ?? 0,
                    count
                )
            }
            // Merge liked articles
            for articleId in cloudStats.likedArticles where !mergedStats.likedArticles.contains(articleId) {
                mergedStats.likedArticles.append(articleId)
            }
            for (category, count) in cloudStats.categoryLikeCounts {
                mergedStats.categoryLikeCounts[category] = max(
                    mergedStats.categoryLikeCounts[category] ?? 0,
                    count
                )
            }
            mergedStats.longestStreak = max(mergedStats.longestStreak, cloudStats.longestStreak)
            mergedStats.totalReadingDays = max(mergedStats.totalReadingDays, cloudStats.totalReadingDays)
            readingStats = mergedStats
            Self.saveToCache(mergedStats, key: CacheKeys.stats)
        }

        // Merge saved story IDs (union)
        if let cloudIDs = record["savedStoryIDs"] as? [String] {
            let cloudUUIDs = Set(cloudIDs.compactMap { UUID(uuidString: $0) })
            savedStoryIDs = savedStoryIDs.union(cloudUUIDs)
            Self.saveToCache(savedStoryIDs, key: CacheKeys.savedIDs)
        }
    }

    // MARK: - Local Cache

    private static func saveToCache<T: Encodable>(_ value: T, key: String) {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private static func loadFromCache<T: Decodable>(key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: - Set Extension for Codable

extension Set: @retroactive RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Set<Element>.self, from: data) else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8) else {
            return "[]"
        }
        return result
    }
}
