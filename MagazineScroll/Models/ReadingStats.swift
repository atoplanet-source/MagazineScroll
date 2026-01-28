import Foundation

// MARK: - Article Engagement

/// Tracks engagement for a single article read session
struct ArticleEngagement: Codable, Equatable {
    let storyId: UUID
    let category: String?
    let enterTime: Date
    var exitTime: Date?
    var pagesViewed: Int
    var totalPages: Int
    var wasLiked: Bool

    var completionRate: Double {
        guard totalPages > 0 else { return 0 }
        return Double(pagesViewed) / Double(totalPages)
    }

    var readingDuration: TimeInterval {
        guard let exit = exitTime else { return 0 }
        return exit.timeIntervalSince(enterTime)
    }

    /// Weighted score: 50% time (capped at 2min) + 50% completion
    var engagementScore: Double {
        let timeScore = min(1.0, readingDuration / 120.0)
        return (timeScore * 0.5) + (completionRate * 0.5)
    }
}

// MARK: - Category Engagement

/// Aggregate engagement metrics per category
struct CategoryEngagement: Codable, Equatable {
    var totalReads: Int
    var totalLikes: Int
    var averageCompletionRate: Double
    var averageReadingTime: TimeInterval
    var lastUpdated: Date

    var engagementScore: Double {
        let timeScore = min(1.0, averageReadingTime / 90.0)
        let likeRate = totalReads > 0 ? Double(totalLikes) / Double(totalReads) : 0
        return (averageCompletionRate * 0.4) + (timeScore * 0.3) + (likeRate * 0.3)
    }

    init(totalReads: Int = 0, totalLikes: Int = 0, averageCompletionRate: Double = 0, averageReadingTime: TimeInterval = 0, lastUpdated: Date = Date()) {
        self.totalReads = totalReads
        self.totalLikes = totalLikes
        self.averageCompletionRate = averageCompletionRate
        self.averageReadingTime = averageReadingTime
        self.lastUpdated = lastUpdated
    }
}

// MARK: - Reading Stats Model

/// Tracks user's reading activity and statistics
struct ReadingStats: Codable, Equatable {
    var articlesRead: [UUID]              // IDs of completed articles
    var categoryReadCounts: [String: Int] // Category -> read count
    var lastReadDate: Date?
    var currentStreak: Int                // Days in a row with reading
    var longestStreak: Int
    var totalReadingDays: Int

    // Like-based tracking
    var likedArticles: [UUID] = []        // IDs of liked/saved articles
    var categoryLikeCounts: [String: Int] = [:] // Category -> like count

    // Engagement tracking
    var articleEngagements: [UUID: ArticleEngagement] = [:]
    var categoryEngagement: [String: CategoryEngagement] = [:]

    init() {
        self.articlesRead = []
        self.categoryReadCounts = [:]
        self.lastReadDate = nil
        self.currentStreak = 0
        self.longestStreak = 0
        self.totalReadingDays = 0
        self.likedArticles = []
        self.categoryLikeCounts = [:]
        self.articleEngagements = [:]
        self.categoryEngagement = [:]
    }

    // MARK: - Computed Properties

    var totalArticlesRead: Int {
        articlesRead.count
    }

    /// Most read category
    var favoriteCategory: String? {
        categoryReadCounts.max(by: { $0.value < $1.value })?.key
    }

    /// Top 3 categories by read count
    var topCategories: [String] {
        categoryReadCounts
            .sorted { $0.value > $1.value }
            .prefix(3)
            .map { $0.key }
    }

    /// Categories the user hasn't read much from
    var underexploredCategories: [String] {
        let allCategories = ["Economics", "Ancient World", "Medieval", "20th Century",
                            "19th Century", "Science", "Art", "Crime", "Exploration", "War"]
        let avgCount = Double(totalArticlesRead) / Double(allCategories.count)
        return allCategories.filter { (categoryReadCounts[$0] ?? 0) < Int(avgCount * 0.5) }
    }

    /// Top 3 categories by like count (for personalization boost)
    var topLikedCategories: [String] {
        categoryLikeCounts
            .sorted { $0.value > $1.value }
            .prefix(3)
            .map { $0.key }
    }

    /// Check if an article has been liked
    func hasLiked(_ storyId: UUID) -> Bool {
        likedArticles.contains(storyId)
    }

    // MARK: - Mutations

    mutating func markArticleRead(_ storyId: UUID, category: String?) {
        guard !articlesRead.contains(storyId) else { return }

        articlesRead.append(storyId)

        if let cat = category {
            categoryReadCounts[cat, default: 0] += 1
        }

        updateStreak()
    }

    mutating func updateStreak() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let lastDate = lastReadDate {
            let lastDay = calendar.startOfDay(for: lastDate)
            let daysDiff = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0

            if daysDiff == 0 {
                // Same day, no change
            } else if daysDiff == 1 {
                // Consecutive day
                currentStreak += 1
                if currentStreak > longestStreak {
                    longestStreak = currentStreak
                }
                totalReadingDays += 1
            } else {
                // Streak broken
                currentStreak = 1
                totalReadingDays += 1
            }
        } else {
            // First time reading
            currentStreak = 1
            longestStreak = 1
            totalReadingDays = 1
        }

        lastReadDate = Date()
    }

    func hasRead(_ storyId: UUID) -> Bool {
        articlesRead.contains(storyId)
    }

    // MARK: - Like Mutations

    mutating func markArticleLiked(_ storyId: UUID, category: String?) {
        guard !likedArticles.contains(storyId) else { return }

        likedArticles.append(storyId)

        if let cat = category {
            categoryLikeCounts[cat, default: 0] += 1
        }
    }
}
