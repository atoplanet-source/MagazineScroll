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
                            ExplorationCard(story: story) {
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
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "sparkles")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("You've explored everything!")
                .font(.headline)
                .foregroundStyle(.secondary)
            Text("Check back later for new stories")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
            Spacer()
        }
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

// MARK: - Exploration Card

struct ExplorationCard: View {
    let story: Story
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                // Category pill
                Text(story.category?.uppercased() ?? "")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(hex: categoryColor))
                    .clipShape(Capsule())

                Text(story.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.primary)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                if let tags = story.tags?.prefix(3), !tags.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(Array(tags), id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 11))
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.secondary.opacity(0.1))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
        }
        .buttonStyle(.plain)
    }

    private var categoryColor: String {
        CategoryColors.color(for: story.category)
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories

    return ExplorationView(navigationState: state)
        .environment(CloudKitManager.shared)
}
