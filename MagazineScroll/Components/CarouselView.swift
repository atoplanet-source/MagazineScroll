import SwiftUI

// MARK: - Carousel View

/// Horizontal paging carousel for featured stories
struct CarouselView: View {
    let stories: [Story]
    let onStoryTap: (Story) -> Void
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $currentIndex) {
                ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                    StoryCard(story: story, style: .carousel) {
                        onStoryTap(story)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 220)
            
            // Page indicators
            HStack(spacing: 6) {
                ForEach(0..<stories.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.black : Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview

#Preview {
    CarouselView(
        stories: Array(SampleData.stories.prefix(4)),
        onStoryTap: { _ in }
    )
    .background(Color(hex: "#F5F4F0"))
}
