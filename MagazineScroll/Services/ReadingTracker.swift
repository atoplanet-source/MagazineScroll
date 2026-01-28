import Foundation
import SwiftUI

// MARK: - Reading Tracker

/// Tracks when a user has completed reading an article.
/// An article is considered "read" when the user reaches the last page.
@Observable
final class ReadingTracker {
    private let cloudKitManager: CloudKitManager

    init(cloudKitManager: CloudKitManager = .shared) {
        self.cloudKitManager = cloudKitManager
    }

    /// Mark an article as read when user reaches the last page
    func markAsRead(story: Story) {
        cloudKitManager.markArticleRead(story.id, category: story.category)
    }

    /// Check if article has been read
    func hasRead(story: Story) -> Bool {
        cloudKitManager.hasReadArticle(story.id)
    }

    /// Get reading stats
    var stats: ReadingStats {
        cloudKitManager.readingStats
    }
}

// MARK: - Reading Progress Modifier

/// View modifier to track reading progress and mark articles as read
struct ReadingProgressModifier: ViewModifier {
    let story: Story
    let currentPage: Int
    let totalPages: Int
    let tracker: ReadingTracker

    @State private var hasMarkedAsRead = false

    func body(content: Content) -> some View {
        content
            .onChange(of: currentPage) { _, newPage in
                // Mark as read when user reaches the last page
                if newPage == totalPages - 1 && !hasMarkedAsRead {
                    hasMarkedAsRead = true
                    tracker.markAsRead(story: story)
                }
            }
    }
}

extension View {
    func trackReadingProgress(
        story: Story,
        currentPage: Int,
        totalPages: Int,
        tracker: ReadingTracker
    ) -> some View {
        modifier(ReadingProgressModifier(
            story: story,
            currentPage: currentPage,
            totalPages: totalPages,
            tracker: tracker
        ))
    }
}
