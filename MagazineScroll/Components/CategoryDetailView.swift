import SwiftUI

// MARK: - Category Detail View

/// Full-screen category view with story list
struct CategoryDetailView: View {
    let category: String
    let stories: [Story]
    @Bindable var navigationState: NavigationState
    let onDismiss: () -> Void
    
    private var bgColor: String {
        CategoryColors.color(for: category)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            ZStack {
                Color(hex: bgColor)
                
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    
                    Text("\(stories.count) STORIES")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white.opacity(0.7))
                        .tracking(1.5)
                    
                    Text(category)
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                
                // Close button
                VStack {
                    HStack {
                        Button(action: onDismiss) {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(width: 36, height: 36)
                                .background(.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 60)
                    Spacer()
                }
            }
            .frame(height: 180)
            
            // Story list
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                        StoryCard(story: story, style: .categoryRow(index: index)) {
                            openStory(story)
                        }
                    }
                }
                .padding(.bottom, 40)
            }
            .background(Color(hex: bgColor).opacity(0.15))
        }
        .background(Color(hex: bgColor).opacity(0.15))
    }
    
    private func openStory(_ story: Story) {
        onDismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            // Set feedStories to this category's stories for navigation
            navigationState.feedStories = stories
            if let index = stories.firstIndex(where: { $0.id == story.id }) {
                navigationState.openStory(at: index)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories
    
    return CategoryDetailView(
        category: "Science",
        stories: SampleData.stories.filter { $0.category == "Science" },
        navigationState: state,
        onDismiss: {}
    )
}
