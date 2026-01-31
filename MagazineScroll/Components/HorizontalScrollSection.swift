import SwiftUI

// MARK: - Horizontal Scroll Section

/// Horizontal scrolling row of story cards
struct HorizontalScrollSection: View {
    let stories: [Story]
    let onStoryTap: (Story) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stories.prefix(6)) { story in
                    StoryCard(story: story, style: .horizontal) {
                        onStoryTap(story)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Preview

#Preview {
    HorizontalScrollSection(
        stories: Array(SampleData.stories.prefix(6)),
        onStoryTap: { _ in }
    )
    .background(Color(hex: "#F5F4F0"))
}
