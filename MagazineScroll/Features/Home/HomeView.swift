import SwiftUI

// MARK: - Category Colors

enum CategoryColors {
    static func color(for category: String?) -> String {
        CategoryPalettes.palette(for: category).primary
    }
}

// MARK: - Home View

struct HomeView: View {
    @Bindable var navigationState: NavigationState
    var categoryResetTrigger: Bool = false
    @Environment(SavedStoriesManager.self) private var savedManager
    @Environment(CloudKitManager.self) private var cloudKitManager
    
    // MARK: - State
    
    @State private var hasAppeared: Bool = false
    @State private var cachedCategories: [String] = []
    @State private var personalizedStories: [Story] = []
    @State private var featuredStoryId: UUID?
    @State private var showingCategory: IdentifiableString? = nil
    @State private var selectedCategory: String? = nil
    @State private var loadError: Error? = nil
    @State private var isRetrying: Bool = false
    
    private let maxHomeArticles = 15
    
    // MARK: - Computed Properties
    
    /// Discovery stories - articles OUTSIDE user preferences
    private var discoveryStories: [Story] {
        let preferredCategories = Set(cloudKitManager.userPreferences.selectedCategories)
        let readIDs = Set(cloudKitManager.readingStats.articlesRead)
        
        var storiesByCategory: [String: [Story]] = [:]
        for story in navigationState.stories {
            guard let cat = story.category,
                  !preferredCategories.contains(cat),
                  !readIDs.contains(story.id) else { continue }
            storiesByCategory[cat, default: []].append(story)
        }
        
        var diverseStories: [Story] = []
        for (_, stories) in storiesByCategory {
            if let randomStory = stories.randomElement() {
                diverseStories.append(randomStory)
            }
        }
        
        return Array(diverseStories.shuffled().prefix(6))
    }
    
    private var displayedStories: [Story] {
        if let category = selectedCategory {
            return storiesForCategory(category)
        }
        return personalizedStories
    }
    
    private func storiesForCategory(_ category: String) -> [Story] {
        let readIDs = Set(cloudKitManager.readingStats.articlesRead)
        return navigationState.stories.filter { story in
            story.category == category && !readIDs.contains(story.id)
        }
    }
    
    // MARK: - Section Data
    
    private var carouselStories: [Story] {
        let top3 = Array(displayedStories.prefix(3))
        if let discovery = discoveryStories.first, selectedCategory == nil {
            return top3 + [discovery]
        }
        return Array(displayedStories.prefix(4))
    }
    
    private var forYouStories: [Story] {
        Array(displayedStories.dropFirst(3).prefix(3))
    }
    
    private var moreForYouStories: [Story] {
        Array(displayedStories.dropFirst(6).prefix(2))
    }
    
    private var topSelectedCategory: String {
        cloudKitManager.userPreferences.selectedCategories.first ?? "Art"
    }
    
    private var topEngagedCategory: String {
        let selected = topSelectedCategory
        let engagement = cloudKitManager.readingStats.categoryEngagement
        let sorted = engagement.sorted { $0.value.engagementScore > $1.value.engagementScore }
        
        for (category, _) in sorted {
            if category != selected { return category }
        }
        
        if let second = cloudKitManager.userPreferences.selectedCategories.dropFirst().first,
           second != selected {
            return second
        }
        
        return selected == "Science" ? "Art" : "Science"
    }
    
    // MARK: - Body
    
    var body: some View {
        contentView
            .background(Color(hex: "#F5F4F0"))
        .onAppear {
            initializeCategories()
            checkAndRefresh()
            withAnimation(.easeOut(duration: 0.4).delay(0.1)) {
                hasAppeared = true
            }
        }
        .onChange(of: navigationState.stories.count) { _, _ in
            initializeCategories()
            generatePersonalizedFeed()
            hasAppeared = false
            withAnimation(.easeOut(duration: 0.4).delay(0.1)) {
                hasAppeared = true
            }
        }
        .onChange(of: cloudKitManager.userPreferences.selectedCategories) { _, _ in
            if !navigationState.stories.isEmpty {
                generatePersonalizedFeed()
            }
        }
        .onChange(of: categoryResetTrigger) { _, _ in
            selectedCategory = nil
        }
        .fullScreenCover(item: $showingCategory) { category in
            CategoryDetailView(
                category: category.value,
                stories: storiesForCategory(category.value),
                navigationState: navigationState,
                onDismiss: { showingCategory = nil }
            )
        }
    }
    
    // MARK: - Content View
    
    @ViewBuilder
    private var contentView: some View {
        if let error = loadError {
            ErrorStateView(
                title: "Unable to Load Stories",
                message: error.localizedDescription,
                retryAction: retryLoad
            )
        } else if navigationState.stories.isEmpty && !hasAppeared {
            LoadingStateView(message: "Loading stories...")
        } else {
            storiesScrollView
        }
    }
    
    private var storiesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // 1. Carousel
                if !carouselStories.isEmpty {
                    CarouselView(
                        stories: carouselStories,
                        onStoryTap: { openStory($0) }
                    )
                    .padding(.top, 16)
                }
                
                // 2. "For You" section
                if !forYouStories.isEmpty {
                    HomeSectionHeader(title: "For You")
                    VStack(spacing: 12) {
                        ForEach(forYouStories) { story in
                            StoryCard(story: story, style: .article(height: 120)) {
                                openStory(story)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                // Only show additional sections on Home tab
                if selectedCategory == nil {
                    // 3. "Try Something New"
                    if !discoveryStories.isEmpty {
                        HomeSectionHeader(title: "Try Something New")
                        HorizontalScrollSection(
                            stories: Array(discoveryStories.dropFirst()),
                            onStoryTap: { openStory($0) }
                        )
                    }
                    
                    // 4. Top selected category
                    let topSelectedStories = storiesForCategory(topSelectedCategory)
                    if !topSelectedStories.isEmpty {
                        HomeSectionHeader(
                            title: topSelectedCategory,
                            showSeeAll: true,
                            onSeeAll: { showingCategory = IdentifiableString(topSelectedCategory) }
                        )
                        HorizontalScrollSection(
                            stories: topSelectedStories,
                            onStoryTap: { openCategoryStory($0, fromCategory: topSelectedStories) }
                        )
                    }
                    
                    // 5. Top engaged category
                    let topEngagedStories = storiesForCategory(topEngagedCategory)
                    if !topEngagedStories.isEmpty && topEngagedCategory != topSelectedCategory {
                        HomeSectionHeader(
                            title: topEngagedCategory,
                            showSeeAll: true,
                            onSeeAll: { showingCategory = IdentifiableString(topEngagedCategory) }
                        )
                        HorizontalScrollSection(
                            stories: topEngagedStories,
                            onStoryTap: { openCategoryStory($0, fromCategory: topEngagedStories) }
                        )
                    }
                    
                }
                
                // 6. "More For You"
                if !moreForYouStories.isEmpty {
                    HomeSectionHeader(title: "More For You")
                    VStack(spacing: 12) {
                        ForEach(moreForYouStories) { story in
                            StoryCard(story: story, style: .article(height: 120)) {
                                openStory(story)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)
                }
            }
            .opacity(hasAppeared ? 1 : 0)
        }
        .background(Color(hex: "#F5F4F0"))
    }
    
    // MARK: - Actions
    
    private func openStory(_ story: Story) {
        if let index = navigationState.feedStories.firstIndex(where: { $0.id == story.id }) {
            navigationState.openStory(at: index)
        } else {
            navigationState.feedStories.insert(story, at: 0)
            navigationState.openStory(at: 0)
        }
    }
    
    private func openCategoryStory(_ story: Story, fromCategory stories: [Story]) {
        navigationState.feedStories = stories
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            navigationState.openStory(at: index)
        }
    }
    
    private func initializeCategories() {
        var cats = Set<String>()
        for story in navigationState.stories {
            if let category = story.category {
                cats.insert(category)
            }
        }
        cachedCategories = cats.sorted()
    }
    
    private func retryLoad() {
        isRetrying = true
        loadError = nil
        
        Task {
            let stories = await APIClient.shared.fetchStories()
            await MainActor.run {
                isRetrying = false
                if stories.isEmpty {
                    loadError = NSError(
                        domain: "MagazineScroll",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Unable to load stories. Check your connection."]
                    )
                } else {
                    navigationState.stories = stories
                }
            }
        }
    }
    
    private func checkAndRefresh() {
        if cloudKitManager.isFeedCacheValid && personalizedStories.isEmpty {
            restoreFeedFromCache()
        }
        
        if personalizedStories.isEmpty || !cloudKitManager.isFeedCacheValid {
            generatePersonalizedFeed()
        }
    }
    
    private func restoreFeedFromCache() {
        let cachedIds = cloudKitManager.cachedFeedIds
        let readIds = Set(cloudKitManager.readingStats.articlesRead)
        
        var restoredStories: [Story] = []
        for id in cachedIds {
            if readIds.contains(id) { continue }
            if let story = navigationState.stories.first(where: { $0.id == id }) {
                restoredStories.append(story)
            }
        }
        
        if restoredStories.count >= 3 {
            personalizedStories = restoredStories
            
            if let cachedFeaturedId = cloudKitManager.cachedFeaturedId,
               restoredStories.contains(where: { $0.id == cachedFeaturedId }) {
                featuredStoryId = cachedFeaturedId
            } else {
                featuredStoryId = restoredStories.first?.id
            }
            
            navigationState.feedStories = restoredStories
        }
    }
    
    private func generatePersonalizedFeed() {
        guard !navigationState.stories.isEmpty else {
            personalizedStories = []
            featuredStoryId = nil
            return
        }
        
        let stats = cloudKitManager.readingStats
        let readIDs = Set(stats.articlesRead)
        
        // Filter out already read articles
        let unreadStories = navigationState.stories.filter { !readIDs.contains($0.id) }
        
        // Group by category
        var storiesByCategory: [String: [Story]] = [:]
        for story in unreadStories {
            let cat = story.category ?? "Other"
            storiesByCategory[cat, default: []].append(story)
        }
        
        // Shuffle each category bucket
        for (cat, stories) in storiesByCategory {
            storiesByCategory[cat] = stories.shuffled()
        }
        
        // Round-robin pull from each category for even distribution
        var feed: [Story] = []
        var categoryKeys = Array(storiesByCategory.keys).shuffled()
        var indices: [String: Int] = Dictionary(uniqueKeysWithValues: categoryKeys.map { ($0, 0) })
        
        while feed.count < maxHomeArticles {
            var addedThisRound = false
            for cat in categoryKeys {
                guard feed.count < maxHomeArticles else { break }
                if let idx = indices[cat], let stories = storiesByCategory[cat], idx < stories.count {
                    feed.append(stories[idx])
                    indices[cat] = idx + 1
                    addedThisRound = true
                }
            }
            // If no stories added, we've exhausted all categories
            if !addedThisRound { break }
            // Re-shuffle category order each round for more variety
            categoryKeys.shuffle()
        }
        
        personalizedStories = feed
        featuredStoryId = feed.first?.id
        navigationState.feedStories = feed
        
        cloudKitManager.cacheFeed(
            storyIds: feed.map { $0.id },
            featuredId: featuredStoryId
        )
    }
}

// MARK: - Corner Radius Extension

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories
    
    return HomeView(navigationState: state)
        .environment(SavedStoriesManager())
        .environment(CloudKitManager.shared)
}
