import SwiftUI

// MARK: - Navigation State

@Observable
final class NavigationState {
    var stories: [Story] = []
    var feedStories: [Story] = []  // Stories in homepage feed order (for reader navigation)
    var currentStoryIndex: Int = 0
    var currentSlideIndex: Int = 0
    var isShowingReader: Bool = false
    var selectedTab: TabSelection = .home
    var isExplorationMode: Bool = false  // Track if reading from exploration tab
    var isRandomMode: Bool = false  // Random shuffle mode for exploration "Jump Right In"

    var currentStory: Story? {
        feedStories[safe: currentStoryIndex]
    }

    var currentSlide: Slide? {
        currentStory?.slides[safe: currentSlideIndex]
    }

    var hasNextStory: Bool {
        currentStoryIndex < feedStories.count - 1
    }

    var hasPreviousStory: Bool {
        currentStoryIndex > 0
    }

    func openStory(at index: Int) {
        guard feedStories.indices.contains(index) else { return }
        currentStoryIndex = index
        currentSlideIndex = 0
        isShowingReader = true
    }

    func openRandomStory() {
        guard !feedStories.isEmpty else { return }
        // Open a random story from the feed
        currentStoryIndex = Int.random(in: 0..<feedStories.count)
        currentSlideIndex = 0
        isShowingReader = true
    }

    func closeReader() {
        isShowingReader = false
        currentSlideIndex = 0
        isExplorationMode = false
        isRandomMode = false
    }

    func nextStory() {
        guard hasNextStory else { return }
        currentStoryIndex += 1
        currentSlideIndex = 0
    }

    func previousStory() {
        guard hasPreviousStory else { return }
        currentStoryIndex -= 1
        currentSlideIndex = 0
    }

    func goToSlide(_ index: Int) {
        guard let story = currentStory,
              story.slides.indices.contains(index) else { return }
        currentSlideIndex = index
    }
}
