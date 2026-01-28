import SwiftUI

// MARK: - Profile View

struct ProfileView: View {
    @Bindable var navigationState: NavigationState
    @Environment(SavedStoriesManager.self) private var savedManager
    @State private var cloudKit = CloudKitManager.shared
    @State private var showingSettings = false

    private var savedStories: [Story] {
        navigationState.stories.filter { savedManager.isSaved($0) }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // Header
                headerSection
                    .padding(.top, 60)

                // Reading Stats
                ReadingStatsView(stats: cloudKit.readingStats)
                    .padding(.top, 32)
                    .padding(.horizontal, 20)

                // Saved Articles
                savedArticlesSection
                    .padding(.top, 40)

                // Settings button
                settingsButton
                    .padding(.top, 32)
                    .padding(.bottom, 120)
            }
        }
        .background(Color(hex: "#F5F4F0"))
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 16) {
            // Profile icon
            ZStack {
                Circle()
                    .fill(Color(hex: "#2E5090"))
                    .frame(width: 80, height: 80)

                Image(systemName: "person.fill")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(.white)
            }

            // Title
            Text("Your Profile")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.black)
        }
    }

    // MARK: - Saved Articles Section

    private var savedArticlesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section header
            HStack {
                Image(systemName: "heart.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color(hex: "#B33951"))

                Text("Saved Articles")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black)

                Spacer()

                Text("\(savedStories.count)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.5))
            }
            .padding(.horizontal, 20)

            if savedStories.isEmpty {
                // Empty state
                VStack(spacing: 12) {
                    Image(systemName: "heart")
                        .font(.system(size: 32, weight: .light))
                        .foregroundStyle(.black.opacity(0.3))

                    Text("No saved articles yet")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.black.opacity(0.5))

                    Text("Double-tap any article to save it")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.black.opacity(0.4))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 20)
            } else {
                // Saved articles list
                LazyVStack(spacing: 12) {
                    ForEach(savedStories) { story in
                        SavedArticleRow(story: story) {
                            openStory(story)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    // MARK: - Settings Button

    private var settingsButton: some View {
        Button {
            showingSettings = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 18, weight: .medium))

                Text("Edit Preferences")
                    .font(.system(size: 16, weight: .semibold))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundStyle(.black.opacity(0.7))
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 20)
    }

    // MARK: - Helpers

    private func openStory(_ story: Story) {
        navigationState.feedStories = savedStories
        if let index = savedStories.firstIndex(where: { $0.id == story.id }) {
            navigationState.openStory(at: index)
        }
    }
}

// MARK: - Saved Article Row

struct SavedArticleRow: View {
    let story: Story
    let onTap: () -> Void

    private var bgColor: String {
        CategoryColors.color(for: story.category)
    }

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                // Color indicator
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(hex: bgColor))
                    .frame(width: 56, height: 56)
                    .overlay(
                        Text(story.category?.prefix(1).uppercased() ?? "")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                    )

                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(story.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.black)
                        .lineLimit(2)

                    Text(story.category ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color(hex: bgColor))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.3))
            }
            .padding(12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories

    return ProfileView(navigationState: state)
        .environment(SavedStoriesManager())
}
