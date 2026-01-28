import Foundation

@Observable
final class SavedStoriesManager {
    private let cloudKitManager: CloudKitManager

    var savedStoryIDs: Set<UUID> {
        cloudKitManager.savedStoryIDs
    }

    init(cloudKitManager: CloudKitManager = .shared) {
        self.cloudKitManager = cloudKitManager
    }

    func isSaved(_ story: Story) -> Bool {
        cloudKitManager.isSaved(story.id)
    }

    func toggleSave(_ story: Story) {
        cloudKitManager.toggleSave(story.id)
    }

    func save(_ story: Story) {
        cloudKitManager.saveStory(story.id)
        // Track the like for personalization
        cloudKitManager.likeArticle(story.id, category: story.category)
    }

    func unsave(_ story: Story) {
        cloudKitManager.unsaveStory(story.id)
    }
}
