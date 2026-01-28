import Foundation

// MARK: - Home View Model

@Observable
final class HomeViewModel {
    var isLoading = false
    var error: Error?

    func loadStories() async -> [Story] {
        isLoading = true
        defer { isLoading = false }

        // Return sample data for now
        return SampleData.stories
    }
}
