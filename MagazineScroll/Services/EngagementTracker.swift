import Foundation

// MARK: - Engagement Tracker

/// Tracks reading engagement for the current article session
@Observable
final class EngagementTracker {
    static let shared = EngagementTracker()

    private var currentEngagement: ArticleEngagement?

    private init() {}

    /// Start tracking a new reading session
    func startReading(story: Story, totalPages: Int) {
        currentEngagement = ArticleEngagement(
            storyId: story.id,
            category: story.category,
            enterTime: Date(),
            exitTime: nil,
            pagesViewed: 1,
            totalPages: totalPages,
            wasLiked: false
        )
    }

    /// Record when user views a new page (tracks max page reached)
    func recordPageView(pageIndex: Int) {
        currentEngagement?.pagesViewed = max(
            currentEngagement?.pagesViewed ?? 0,
            pageIndex + 1
        )
    }

    /// Record when user likes/saves the article
    func recordLike() {
        currentEngagement?.wasLiked = true
    }

    /// End the reading session and return the engagement data
    func endReading() -> ArticleEngagement? {
        guard var engagement = currentEngagement else { return nil }
        engagement.exitTime = Date()
        currentEngagement = nil
        return engagement
    }

    /// Check if currently tracking a story
    func isTracking(storyId: UUID) -> Bool {
        currentEngagement?.storyId == storyId
    }
}
