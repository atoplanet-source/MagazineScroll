import Foundation

// MARK: - Exploration Engine

/// Generates personalized exploration feeds from non-preferred categories
struct ExplorationEngine {

    /// Generate a feed of stories from non-preferred categories
    /// - Parameters:
    ///   - stories: All available stories
    ///   - preferences: User's quiz answers and preferences
    ///   - stats: User's reading history
    ///   - limit: Maximum number of stories to return
    /// - Returns: Curated list of exploration stories
    static func generateFeed(
        stories: [Story],
        preferences: UserPreferences,
        stats: ReadingStats,
        limit: Int = 15
    ) -> [Story] {
        let preferredCategories = Set(preferences.selectedCategories)
        let readIds = Set(stats.articlesRead)

        // Get unread stories from non-preferred categories
        let candidates = stories.filter { story in
            guard let category = story.category else { return false }
            return !preferredCategories.contains(category) && !readIds.contains(story.id)
        }

        guard !candidates.isEmpty else { return [] }

        // Score each candidate
        let scored = candidates.map { story in
            (story: story, score: explorationScore(story, preferences, stats))
        }

        // Top 40% by score, 60% random (prevents over-optimization)
        let sorted = scored.sorted { $0.score > $1.score }
        let topCount = max(1, limit * 4 / 10)

        var result = Array(sorted.prefix(topCount).map { $0.story })
        let remaining = Array(sorted.dropFirst(topCount)).shuffled()
        result.append(contentsOf: remaining.prefix(limit - topCount).map { $0.story })

        let finalFeed = Array(result.shuffled().prefix(limit))
        print("[ExplorationEngine] Generated \(finalFeed.count) stories from \(Set(finalFeed.compactMap { $0.category }).count) categories")
        return finalFeed
    }

    /// Score a story for exploration potential
    private static func explorationScore(
        _ story: Story,
        _ preferences: UserPreferences,
        _ stats: ReadingStats
    ) -> Double {
        guard let category = story.category else { return 0.5 }
        var score = 0.5

        // Conversion history (40%) - categories user has liked from explore before
        let conversions = preferences.explorationConversions[category] ?? 0
        score += min(1.0, Double(conversions) * 0.25) * 0.4

        // Adjacent interests (30%) - related to preferred categories
        let adjacencyScore = adjacencyBoost(category, preferences)
        score += adjacencyScore * 0.3

        // Tag overlap (30%) - shares tags with preferred content
        let tagScore = tagOverlap(story, preferences)
        score += tagScore * 0.3

        return min(1.0, score)
    }

    /// Boost for categories adjacent to user's preferences
    private static func adjacencyBoost(_ category: String, _ preferences: UserPreferences) -> Double {
        // Category groupings based on topic similarity
        let groups: [[String]] = [
            ["Ancient World", "Medieval"],
            ["19th Century", "20th Century"],
            ["Crime", "Exploration", "War"],
            ["Art", "Science", "Economics"]
        ]

        for group in groups {
            if group.contains(category) {
                let overlap = Set(group).intersection(Set(preferences.selectedCategories))
                if !overlap.isEmpty { return 0.7 }
            }
        }
        return 0.3
    }

    /// Score based on tag overlap with preferred content
    private static func tagOverlap(_ story: Story, _ preferences: UserPreferences) -> Double {
        let storyTags = Set(story.tags ?? [])
        let prefTags = Set(preferences.selectedTags)
        guard !storyTags.isEmpty, !prefTags.isEmpty else { return 0.3 }

        let overlap = storyTags.intersection(prefTags).count
        return min(1.0, 0.3 + Double(overlap) * 0.2)
    }

    /// Record when a user likes a story from exploration (conversion)
    static func recordConversion(category: String, preferences: inout UserPreferences) {
        preferences.explorationConversions[category, default: 0] += 1
    }
}
