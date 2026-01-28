import Foundation

// MARK: - Personalization Engine

/// Scores and ranks stories based on user preferences
struct PersonalizationEngine {

    /// Score a story based on user preferences
    /// Formula: (categoryMatch × 22) + (tagMatch × 13) + (eraMatch × 12) + (engagement × 15) + (tone × 8) + (recency × 10) + (variety × 5) + (likes × 15)
    static func score(
        story: Story,
        preferences: UserPreferences,
        stats: ReadingStats,
        allStories: [Story]
    ) -> Double {
        var score: Double = 0

        // Category Match (22%) - reduced from 25%
        let categoryWeight = preferences.categoryWeight(for: story.category ?? "")
        score += categoryWeight * 22

        // Tag Match (13%) - reduced from 15%
        let tagScore = tagMatchScore(story: story, preferences: preferences)
        score += tagScore * 13

        // Era Match (12%) - reduced from 15%
        let eraScore = eraMatchScore(story: story, preference: preferences.eraPreference)
        score += eraScore * 12

        // Engagement factor (15%) - NEW: boost categories user engages with deeply
        let engagementFactor = engagementScore(category: story.category, stats: stats)
        score += engagementFactor * 15

        // Tone Match (8%) - reduced from 10%, neutral for now (stories don't have tone metadata)
        score += 0.7 * 8

        // Recency (10%) - newer stories get a small boost
        let recencyScore = recencyBoost(story: story, allStories: allStories)
        score += recencyScore * 10

        // Variety (5%) - reduced from 10%, boost underexplored categories
        let varietyScore = varietyBoost(story: story, stats: stats, preferences: preferences)
        score += varietyScore * 5

        // Like-based boost (15%) - boost categories user has liked
        let likeScore = likeBoost(story: story, stats: stats)
        score += likeScore * 15

        // Penalty for already read articles
        if stats.hasRead(story.id) {
            score *= 0.3  // Significant penalty but not zero
        }

        return score
    }

    /// Get personalized story feed using slot-based category distribution
    /// Guarantees equal representation of each selected category
    static func personalizedFeed(
        stories: [Story],
        preferences: UserPreferences,
        stats: ReadingStats,
        limit: Int = 50,
        excludeRead: Bool = false
    ) -> [Story] {
        // Filter out read articles if requested
        let filteredStories = excludeRead
            ? stories.filter { !stats.hasRead($0.id) }
            : stories

        let selectedCategories = preferences.selectedCategories

        // Debug: Log what categories are selected
        print("[PersonalizationEngine] Selected categories: \(selectedCategories)")
        print("[PersonalizationEngine] Era preference: \(preferences.eraPreference.rawValue)")
        print("[PersonalizationEngine] Discovery mode: \(preferences.discoveryMode.rawValue)")
        print("[PersonalizationEngine] Selected tags: \(preferences.selectedTags)")
        print("[PersonalizationEngine] Reading goal: \(preferences.readingGoal.rawValue)")
        print("[PersonalizationEngine] Total stories: \(stories.count), Filtered: \(filteredStories.count)")

        // Fallback to score-based if no categories selected
        guard !selectedCategories.isEmpty else {
            print("[PersonalizationEngine] No categories selected, using fallback scoring")
            return fallbackScoredFeed(
                stories: filteredStories,
                preferences: preferences,
                stats: stats,
                limit: limit
            )
        }

        // Group stories by selected category, sorted by score within each bucket
        var categoryBuckets: [String: [Story]] = [:]
        for category in selectedCategories {
            categoryBuckets[category] = filteredStories
                .filter { $0.category == category }
                .sorted {
                    score(story: $0, preferences: preferences, stats: stats, allStories: filteredStories) >
                    score(story: $1, preferences: preferences, stats: stats, allStories: filteredStories)
                }
        }

        // Calculate slots per category (reserve 1 for discovery)
        let categoryCount = selectedCategories.count
        let slotsPerCategory = max(1, (limit - 1) / categoryCount)

        // Round-robin fill slots to interleave categories
        var result: [Story] = []
        var usedStoryIds: Set<UUID> = []

        for round in 0..<slotsPerCategory {
            for category in selectedCategories {
                guard result.count < limit - 1 else { break }

                if let bucket = categoryBuckets[category], round < bucket.count {
                    let story = bucket[round]
                    if !usedStoryIds.contains(story.id) {
                        result.append(story)
                        usedStoryIds.insert(story.id)
                    }
                }
            }
        }

        // Add 1 discovery article from non-selected categories
        let selectedSet = Set(selectedCategories)
        let discoveryStories = filteredStories.filter { story in
            guard let category = story.category else { return false }
            return !selectedSet.contains(category) && !usedStoryIds.contains(story.id)
        }

        if let discoveryStory = discoveryStories.randomElement() {
            result.append(discoveryStory)
        }

        // Debug: Log final feed composition
        let feedCategories = result.map { $0.category ?? "Unknown" }
        print("[PersonalizationEngine] Final feed categories: \(feedCategories)")

        // Debug: Check if stories have tags
        let storiesWithTags = result.filter { ($0.tags ?? []).count > 0 }.count
        print("[PersonalizationEngine] Stories with tags: \(storiesWithTags)/\(result.count)")
        if let firstWithTags = result.first(where: { ($0.tags ?? []).count > 0 }) {
            print("[PersonalizationEngine] Example tags: \(firstWithTags.title) -> \(firstWithTags.tags ?? [])")
        }

        return result
    }

    /// Fallback to score-based feed when no categories are selected
    private static func fallbackScoredFeed(
        stories: [Story],
        preferences: UserPreferences,
        stats: ReadingStats,
        limit: Int
    ) -> [Story] {
        let scored = stories.map { story in
            (story: story, score: score(story: story, preferences: preferences, stats: stats, allStories: stories))
        }

        let sorted = scored.sorted { $0.score > $1.score }

        var result: [Story] = []
        var remaining = sorted

        while result.count < limit && !remaining.isEmpty {
            let randomThreshold = Double.random(in: 0...1)
            if randomThreshold < preferences.varietyFactor && remaining.count > 1 {
                let poolSize = min(10, remaining.count)
                let randomIndex = Int.random(in: 0..<poolSize)
                result.append(remaining[randomIndex].story)
                remaining.remove(at: randomIndex)
            } else {
                result.append(remaining[0].story)
                remaining.removeFirst()
            }
        }

        return interleaveByCategory(result)
    }

    /// Interleave stories to prevent more than 2 consecutive same-category articles
    private static func interleaveByCategory(_ stories: [Story]) -> [Story] {
        guard stories.count > 2 else { return stories }

        var result = stories
        var i = 2

        while i < result.count {
            let currentCategory = result[i].category
            let prev1Category = result[i - 1].category
            let prev2Category = result[i - 2].category

            // Check if this would be 3rd consecutive of same category
            if currentCategory == prev1Category && currentCategory == prev2Category {
                // Find next story with different category to swap
                var swapIndex: Int? = nil
                for j in (i + 1)..<result.count {
                    if result[j].category != currentCategory {
                        swapIndex = j
                        break
                    }
                }

                // Swap if we found a different category
                if let swapIdx = swapIndex {
                    result.swapAt(i, swapIdx)
                }
                // If no different category found, move on (can't fix)
            }
            i += 1
        }

        return result
    }

    /// Get a "surprise" story from categories the user doesn't usually read
    static func surpriseStory(
        stories: [Story],
        preferences: UserPreferences,
        stats: ReadingStats
    ) -> Story? {
        let topCategories = Set(preferences.selectedCategories.prefix(3))
        let candidates = stories.filter { story in
            guard let category = story.category else { return false }
            return !topCategories.contains(category) && !stats.hasRead(story.id)
        }

        return candidates.randomElement() ?? stories.filter { !stats.hasRead($0.id) }.randomElement()
    }

    // MARK: - Private Helpers

    /// Calculate tag match score based on user's selected tags from follow-up questions
    private static func tagMatchScore(story: Story, preferences: UserPreferences) -> Double {
        guard !preferences.selectedTags.isEmpty else { return 0.5 }  // Neutral if no tags selected

        let storyTags = story.tags ?? []
        guard !storyTags.isEmpty else { return 0.5 }  // Neutral if story has no tags

        let matchCount = storyTags.filter { preferences.selectedTags.contains($0) }.count

        if matchCount == 0 { return 0.3 }  // No matches - lower score
        if matchCount == 1 { return 0.7 }  // One match - good
        return 1.0  // 2+ matches - excellent
    }

    private static func eraMatchScore(story: Story, preference: EraPreference) -> Double {
        guard let category = story.category else { return 0.5 }

        let ancientCategories = ["Ancient World", "Medieval"]
        let modernCategories = ["19th Century", "20th Century", "Science"]

        switch preference {
        case .ancient:
            return ancientCategories.contains(category) ? 1.0 : 0.3
        case .modern:
            return modernCategories.contains(category) ? 1.0 : 0.3
        case .both:
            return 0.7  // Neutral bonus
        }
    }

    private static func recencyBoost(story: Story, allStories: [Story]) -> Double {
        // Simple boost based on position in the array (assuming newer stories are first)
        guard let index = allStories.firstIndex(where: { $0.id == story.id }) else { return 0.5 }
        let position = Double(index) / Double(max(1, allStories.count - 1))
        return 1.0 - (position * 0.5)  // 1.0 for first, 0.5 for last
    }

    private static func varietyBoost(story: Story, stats: ReadingStats, preferences: UserPreferences) -> Double {
        guard let category = story.category else { return 0.5 }

        // If this category is underexplored, boost it
        if stats.underexploredCategories.contains(category) {
            return 1.0
        }

        // If user wants variety, give a small boost to non-favorite categories
        if preferences.discoveryMode == .surpriseMe {
            let isFavorite = preferences.selectedCategories.contains(category)
            return isFavorite ? 0.5 : 0.8
        }

        return 0.5
    }

    /// Engagement-based score: boost categories user engages with deeply
    private static func engagementScore(category: String?, stats: ReadingStats) -> Double {
        guard let category = category,
              let engagement = stats.categoryEngagement[category] else {
            return 0.5  // Neutral for unknown categories
        }
        return engagement.engagementScore
    }

    /// Like-based boost: articles from top liked categories get boosted
    private static func likeBoost(story: Story, stats: ReadingStats) -> Double {
        guard let category = story.category else { return 0.5 }

        let topLiked = stats.topLikedCategories

        if let rank = topLiked.firstIndex(of: category) {
            // Top liked category = 1.0, second = 0.8, third = 0.6
            switch rank {
            case 0: return 1.0
            case 1: return 0.8
            case 2: return 0.6
            default: return 0.5
            }
        }

        return 0.5  // Not in top liked categories
    }
}
