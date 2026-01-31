import SwiftUI

// MARK: - Unified Story Card Component

/// A unified card component for displaying stories across the app.
/// Replaces: CarouselCard, ArticleCard, HorizontalCard, ForYouCard, ExplorationCard
struct StoryCard: View {
    let story: Story
    let style: CardStyle
    let onTap: () -> Void
    
    /// Card display styles
    enum CardStyle {
        case carousel           // Large hero card (220pt height, full width)
        case article(height: CGFloat)  // Vertical list card (configurable height)
        case horizontal         // Horizontal scroll card (200x120)
        case forYou(index: Int) // For You tab with varying heights
        case exploration        // Exploration tab with tags
        case categoryRow(index: Int)  // Category detail row
    }
    
    var body: some View {
        Button(action: onTap) {
            cardContent
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var cardContent: some View {
        switch style {
        case .carousel:
            carouselContent
        case .article(let height):
            articleContent(height: height)
        case .horizontal:
            horizontalContent
        case .forYou(let index):
            forYouContent(index: index)
        case .exploration:
            explorationContent
        case .categoryRow(let index):
            categoryRowContent(index: index)
        }
    }
    
    // MARK: - Category Color
    
    private var categoryColor: String {
        CategoryColors.color(for: story.category)
    }
    
    // MARK: - Carousel Style (Large Hero)
    
    private var carouselContent: some View {
        ZStack(alignment: .bottomLeading) {
            Color(hex: categoryColor)
            
            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                
                Text(story.category?.uppercased() ?? "")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white.opacity(0.7))
                    .tracking(1.5)
                
                Text(story.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(3)
            }
            .padding(20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    // MARK: - Article Style (Vertical List)
    
    private func articleContent(height: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Spacer()
            
            Text(story.category?.uppercased() ?? "")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.white.opacity(0.7))
                .tracking(1)
            
            Text(story.title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .frame(height: height)
        .background(Color(hex: categoryColor))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    // MARK: - Horizontal Style (Scroll Cards)
    
    private var horizontalContent: some View {
        VStack(alignment: .leading, spacing: 6) {
            Spacer()
            Text(story.category?.uppercased() ?? "")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.white.opacity(0.6))
                .tracking(1)
            Text(story.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .frame(width: 200, height: 120, alignment: .leading)
        .padding(14)
        .background(Color(hex: categoryColor))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    // MARK: - For You Style (Varying Heights)
    
    private func forYouContent(index: Int) -> some View {
        let cardHeight: CGFloat = {
            switch index % 5 {
            case 0: return 140
            case 1, 2: return 100
            default: return 80
            }
        }()
        
        return HStack(spacing: 0) {
            // Color stripe
            Rectangle()
                .fill(Color(hex: categoryColor))
                .frame(width: 6)
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(story.category?.uppercased() ?? "")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(Color(hex: categoryColor))
                    .tracking(1)
                
                Text(story.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.black)
                    .lineLimit(cardHeight > 100 ? 3 : 2)
                
                if cardHeight > 120, let desc = story.description {
                    Text(desc)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.black.opacity(0.6))
                        .lineLimit(2)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.black.opacity(0.3))
                .padding(.trailing, 16)
        }
        .frame(height: cardHeight)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Exploration Style (With Tags)
    
    private var explorationContent: some View {
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
    
    // MARK: - Category Row Style
    
    private func categoryRowContent(index: Int) -> some View {
        HStack(spacing: 16) {
            // Number
            Text("\(index + 1)")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color(hex: categoryColor))
                .frame(width: 28)
            
            // Title
            Text(story.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.black.opacity(0.3))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.white)
    }
}

// MARK: - Preview

#Preview {
    let story = SampleData.stories[0]
    
    ScrollView {
        VStack(spacing: 20) {
            StoryCard(story: story, style: .carousel, onTap: {})
                .frame(height: 220)
            
            StoryCard(story: story, style: .article(height: 120), onTap: {})
            
            StoryCard(story: story, style: .horizontal, onTap: {})
            
            StoryCard(story: story, style: .forYou(index: 0), onTap: {})
            
            StoryCard(story: story, style: .exploration, onTap: {})
            
            StoryCard(story: story, style: .categoryRow(index: 0), onTap: {})
        }
        .padding()
    }
}
