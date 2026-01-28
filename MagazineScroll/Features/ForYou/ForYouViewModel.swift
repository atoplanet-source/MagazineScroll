import Foundation
import SwiftUI

// MARK: - For You View Model

@Observable
final class ForYouViewModel {
    var personalizedStories: [Story] = []
    var isLoading: Bool = false

    private let cloudKitManager: CloudKitManager

    init(cloudKitManager: CloudKitManager = .shared) {
        self.cloudKitManager = cloudKitManager
    }

    // MARK: - Generate Personalized Feed

    func generateFeed(from stories: [Story]) {
        isLoading = true

        let preferences = cloudKitManager.userPreferences
        let stats = cloudKitManager.readingStats

        personalizedStories = PersonalizationEngine.personalizedFeed(
            stories: stories,
            preferences: preferences,
            stats: stats,
            limit: 50
        )

        isLoading = false
    }

    // MARK: - Surprise Me

    func surpriseStory(from stories: [Story]) -> Story? {
        let preferences = cloudKitManager.userPreferences
        let stats = cloudKitManager.readingStats

        return PersonalizationEngine.surpriseStory(
            stories: stories,
            preferences: preferences,
            stats: stats
        )
    }

    // MARK: - Refresh

    func refresh(from stories: [Story]) {
        generateFeed(from: stories)
    }
}
