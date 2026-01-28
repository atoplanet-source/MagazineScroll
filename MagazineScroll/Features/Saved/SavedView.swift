import SwiftUI

struct SavedView: View {
    @Bindable var navigationState: NavigationState
    @Environment(SavedStoriesManager.self) private var savedManager
    @Environment(\.dismiss) private var dismiss

    private let bgColor = Color(hex: "#F5F4F0")
    private let accentColor = Color(hex: "#D32F2F")

    private var savedStories: [Story] {
        navigationState.stories.filter { savedManager.isSaved($0) }
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                if savedStories.isEmpty {
                    emptyStateView
                } else {
                    LazyVStack(spacing: 12) {
                        ForEach(savedStories, id: \.id) { story in
                            SavedStoryCard(story: story, accentColor: accentColor) {
                                openStory(story)
                            } onUnsave: {
                                withAnimation {
                                    savedManager.unsave(story)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
            .background(bgColor)
            .navigationTitle("Saved")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(accentColor)
                }
            }
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Spacer()
                .frame(height: 120)

            Image(systemName: "heart")
                .font(.system(size: 60))
                .foregroundStyle(Color(hex: "#C7C7CC"))

            Text("No Saved Articles")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)

            Text("Double-tap any article to save it here")
                .font(.system(size: 15))
                .foregroundStyle(Color(hex: "#8E8E93"))
                .multilineTextAlignment(.center)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
    }

    private func openStory(_ story: Story) {
        dismiss()
        if let index = navigationState.stories.firstIndex(where: { $0.id == story.id }) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                navigationState.openStory(at: index)
            }
        }
    }
}

// MARK: - Saved Story Card

struct SavedStoryCard: View {
    let story: Story
    let accentColor: Color
    let onTap: () -> Void
    let onUnsave: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            // Color indicator
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: story.previewBackgroundColor))
                .frame(width: 70, height: 70)

            // Content
            VStack(alignment: .leading, spacing: 6) {
                if let category = story.category {
                    Text(category.uppercased())
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(accentColor)
                        .tracking(0.3)
                }

                Text(story.title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            // Unsave button
            Button(action: onUnsave) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(accentColor)
            }
            .buttonStyle(.plain)
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories

    return SavedView(navigationState: state)
        .environment(SavedStoriesManager())
}
