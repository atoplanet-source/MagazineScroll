import SwiftUI

// MARK: - Exploration View

/// Discover tab showing stories from non-preferred categories
struct ExplorationView: View {
    @Bindable var navigationState: NavigationState
    @Environment(CloudKitManager.self) private var cloudKitManager
    @State private var feed: [Story] = []
    @State private var isLoading = true

    var body: some View {
        VStack(spacing: 0) {
            // Header with Jump Right In button
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("DISCOVER")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.secondary)
                        .tracking(1.5)

                    Spacer()

                    if !feed.isEmpty {
                        Button(action: jumpRightIn) {
                            HStack(spacing: 6) {
                                Image(systemName: "shuffle")
                                Text("Jump Right In")
                            }
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color(hex: "#2E5090"))
                            .clipShape(Capsule())
                        }
                    }
                }

                Text("Try Something New")
                    .font(.system(size: 28, weight: .bold))

                Text("Stories outside your usual interests")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)

            if isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else if feed.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(feed) { story in
                            StoryCard(story: story, style: .exploration) {
                                openStory(story)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)
                }
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .onAppear { loadFeed() }
    }

    private var emptyStateView: some View {
        EmptyStateView(
            icon: "sparkles",
            title: "You've explored everything!",
            message: "Check back later for new stories"
        )
    }

    private func loadFeed() {
        feed = ExplorationEngine.generateFeed(
            stories: navigationState.stories,
            preferences: cloudKitManager.userPreferences,
            stats: cloudKitManager.readingStats
        )
        isLoading = false
    }

    private func openStory(_ story: Story) {
        navigationState.feedStories = feed
        navigationState.isExplorationMode = true
        if let index = feed.firstIndex(where: { $0.id == story.id }) {
            navigationState.openStory(at: index)
        }
    }

    private func jumpRightIn() {
        guard !feed.isEmpty else { return }
        navigationState.feedStories = feed
        navigationState.isExplorationMode = true
        navigationState.isRandomMode = true
        navigationState.openRandomStory()
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories

    return ExplorationView(navigationState: state)
        .environment(CloudKitManager.shared)
}
