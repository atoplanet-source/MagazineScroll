import SwiftUI

// MARK: - Category Detail View

/// Full-screen category view with curated sections
struct CategoryDetailView: View {
    let category: String
    let stories: [Story]
    @Bindable var navigationState: NavigationState
    let onDismiss: () -> Void
    
    @State private var shuffleId = UUID()  // Changes to trigger re-shuffle
    
    private var bgColor: String {
        CategoryColors.color(for: category)
    }
    
    // MARK: - Curated Sections
    
    /// Featured story (random, changes on shuffle)
    private var featuredStory: Story? {
        // Use shuffleId to make this reactive to shuffle
        _ = shuffleId
        return stories.randomElement()
    }
    
    /// Popular stories (simulated - in real app would use engagement data)
    private var popularStories: [Story] {
        _ = shuffleId
        return Array(stories.shuffled().prefix(4))
    }
    
    /// New stories (simulated - in real app would sort by created_at)
    private var newStories: [Story] {
        _ = shuffleId
        return Array(stories.shuffled().prefix(6))
    }
    
    /// More to explore
    private var moreStories: [Story] {
        _ = shuffleId
        let usedIds = Set([featuredStory?.id].compactMap { $0 } + popularStories.map { $0.id } + newStories.map { $0.id })
        return stories.filter { !usedIds.contains($0.id) }.shuffled()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            header
            
            // Content
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // Featured Story
                    if let featured = featuredStory {
                        FeaturedCategoryCard(story: featured, categoryColor: bgColor) {
                            openStory(featured)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                    
                    // Popular Section
                    if !popularStories.isEmpty {
                        sectionHeader("Popular in \(category)")
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 12) {
                            ForEach(popularStories) { story in
                                CategoryGridCard(story: story) {
                                    openStory(story)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    // New This Week Section
                    if !newStories.isEmpty {
                        sectionHeader("New This Week")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(newStories) { story in
                                    CategoryHorizontalCard(story: story) {
                                        openStory(story)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    
                    // More to Explore
                    if !moreStories.isEmpty {
                        sectionHeader("More to Explore")
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 12) {
                            ForEach(moreStories.prefix(8)) { story in
                                CategoryGridCard(story: story) {
                                    openStory(story)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    Spacer(minLength: 100)
                }
            }
            .background(Color(hex: "#F5F4F0"))
        }
        .background(Color(hex: bgColor))
    }
    
    // MARK: - Header
    
    private var header: some View {
        HStack {
            Button(action: onDismiss) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            Spacer()
            
            Text(category)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.white)
            
            Spacer()
            
            Button(action: shuffle) {
                HStack(spacing: 4) {
                    Text("Shuffle")
                        .font(.system(size: 13, weight: .semibold))
                    Image(systemName: "shuffle")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.white.opacity(0.2))
                .clipShape(Capsule())
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 60)
        .padding(.bottom, 16)
        .background(Color(hex: bgColor))
    }
    
    // MARK: - Section Header
    
    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color(hex: bgColor))
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, 12)
    }
    
    // MARK: - Actions
    
    private func shuffle() {
        withAnimation(.easeInOut(duration: 0.3)) {
            shuffleId = UUID()
        }
    }
    
    private func openStory(_ story: Story) {
        onDismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            navigationState.feedStories = stories
            if let index = stories.firstIndex(where: { $0.id == story.id }) {
                navigationState.openStory(at: index)
            }
        }
    }
}

// MARK: - Featured Category Card

struct FeaturedCategoryCard: View {
    let story: Story
    let categoryColor: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                Spacer()
                
                Text(story.title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .frame(height: 160)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: categoryColor))
            )
            .overlay(alignment: .topTrailing) {
                Image(systemName: "bookmark")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(16)
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Category Grid Card

struct CategoryGridCard: View {
    let story: Story
    let onTap: () -> Void
    
    // Rotate through a set of muted colors for variety
    private var cardColor: String {
        let colors = ["#A67B5B", "#8B7355", "#6B8E6B", "#7B8A8B", "#8B6969", "#6B7B8B"]
        let hash = abs(story.id.hashValue)
        return colors[hash % colors.count]
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text(story.title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .frame(height: 110)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: cardColor))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Category Horizontal Card

struct CategoryHorizontalCard: View {
    let story: Story
    let onTap: () -> Void
    
    private var cardColor: String {
        let colors = ["#A67B5B", "#8B7355", "#6B8E6B", "#7B8A8B", "#8B6969", "#6B7B8B"]
        let hash = abs(story.id.hashValue)
        return colors[hash % colors.count]
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text(story.title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
            }
            .frame(width: 150, alignment: .leading)
            .padding(14)
            .frame(height: 100)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: cardColor))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories
    
    return CategoryDetailView(
        category: "19th Century",
        stories: SampleData.stories,
        navigationState: state,
        onDismiss: {}
    )
}
