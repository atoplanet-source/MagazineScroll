import SwiftUI

// MARK: - String Identifiable Extension (for fullScreenCover)

extension String: @retroactive Identifiable {
    public var id: String { self }
}

// MARK: - Category Colors (uses CategoryPalettes for unified color source)

enum CategoryColors {
    static func color(for category: String?) -> String {
        // Use the primary color from CategoryPalettes for consistency
        return CategoryPalettes.palette(for: category).primary
    }
}

// MARK: - Home View

struct HomeView: View {
    @Bindable var navigationState: NavigationState
    var categoryResetTrigger: Bool = false  // When this toggles, reset selectedCategory
    @Environment(SavedStoriesManager.self) private var savedManager
    @Environment(CloudKitManager.self) private var cloudKitManager
    @State private var hasAppeared: Bool = false
    @State private var cachedCategories: [String] = []
    @State private var personalizedStories: [Story] = []
    @State private var featuredStoryId: UUID?
    @State private var showingCategory: String? = nil
    @State private var selectedCategory: String? = nil  // nil = "Home"

    private let maxHomeArticles = 15  // Increased for new layout sections

    /// Discovery stories - articles OUTSIDE user preferences (one per category for diversity)
    private var discoveryStories: [Story] {
        let preferredCategories = Set(cloudKitManager.userPreferences.selectedCategories)
        let readIDs = Set(cloudKitManager.readingStats.articlesRead)

        // Group eligible stories by category
        var storiesByCategory: [String: [Story]] = [:]
        for story in navigationState.stories {
            guard let cat = story.category,
                  !preferredCategories.contains(cat),
                  !readIDs.contains(story.id) else { continue }
            storiesByCategory[cat, default: []].append(story)
        }

        // Pick one random story from each category for diversity
        var diverseStories: [Story] = []
        for (_, stories) in storiesByCategory {
            if let randomStory = stories.randomElement() {
                diverseStories.append(randomStory)
            }
        }

        // Shuffle and return up to 6
        return Array(diverseStories.shuffled().prefix(6))
    }

    // Filtered stories based on category selection
    private var displayedStories: [Story] {
        if let category = selectedCategory {
            // Use storiesForCategory to pull from ALL stories (not just personalized ~15)
            return storiesForCategory(category)
        }
        return personalizedStories
    }

    // Stories for a specific category (excluding read articles)
    private func storiesForCategory(_ category: String) -> [Story] {
        let readIDs = Set(cloudKitManager.readingStats.articlesRead)
        return navigationState.stories.filter { story in
            story.category == category && !readIDs.contains(story.id)
        }
    }

    // MARK: - New Story Selection Properties

    /// Carousel: 3 top personalized + 1 discovery
    private var carouselStories: [Story] {
        let top3 = Array(displayedStories.prefix(3))
        if let discovery = discoveryStories.first, selectedCategory == nil {
            return top3 + [discovery]
        }
        return Array(displayedStories.prefix(4))
    }

    /// For You: next 3 after carousel
    private var forYouStories: [Story] {
        Array(displayedStories.dropFirst(3).prefix(3))
    }

    /// More For You: next 2 after "For You"
    private var moreForYouStories: [Story] {
        Array(displayedStories.dropFirst(6).prefix(2))
    }

    /// Top selected category (first from quiz)
    private var topSelectedCategory: String {
        cloudKitManager.userPreferences.selectedCategories.first ?? "Art"
    }

    /// Top engaged category (highest engagement score, different from selected)
    private var topEngagedCategory: String {
        let selected = topSelectedCategory
        let engagement = cloudKitManager.readingStats.categoryEngagement

        let sorted = engagement.sorted { $0.value.engagementScore > $1.value.engagementScore }

        // Find first category that's different from selected
        for (category, _) in sorted {
            if category != selected {
                return category
            }
        }

        // Fallback to second selected category or different default
        let secondSelected = cloudKitManager.userPreferences.selectedCategories.dropFirst().first
        if let second = secondSelected, second != selected {
            return second
        }

        // Default to a different category
        return selected == "Science" ? "Art" : "Science"
    }

    var body: some View {
        VStack(spacing: 0) {
            // Category pill tabs
            categoryPillsSection
                .background(Color(hex: "#F5F4F0"))

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // 1. Carousel (4 cards: 3 personalized + 1 discovery)
                    if !carouselStories.isEmpty {
                        CarouselView(
                            stories: carouselStories,
                            onStoryTap: { openStory($0) }
                        )
                        .padding(.top, 16)
                    }

                    // 2. "For You" section (3 articles)
                    if !forYouStories.isEmpty {
                        HomeSectionHeader(title: "For You")
                        VStack(spacing: 12) {
                            ForEach(forYouStories) { story in
                                ArticleCard(story: story, onTap: { openStory(story) })
                            }
                        }
                        .padding(.horizontal, 16)
                    }

                    // Only show additional sections on Home tab
                    if selectedCategory == nil {
                        // 3. "Try Something New" horizontal section
                        if !discoveryStories.isEmpty {
                            HomeSectionHeader(title: "Try Something New")
                            HorizontalScrollSection(
                                stories: Array(discoveryStories.dropFirst()),
                                onStoryTap: { openStory($0) }
                            )
                        }

                        // 4. Top selected category section
                        let topSelectedStories = storiesForCategory(topSelectedCategory)
                        if !topSelectedStories.isEmpty {
                            HomeSectionHeader(
                                title: topSelectedCategory,
                                showSeeAll: true,
                                onSeeAll: { showingCategory = topSelectedCategory }
                            )
                            HorizontalScrollSection(
                                stories: topSelectedStories,
                                onStoryTap: { openCategoryStory($0, fromCategory: topSelectedStories) }
                            )
                        }

                        // 5. Top engaged category section
                        let topEngagedStories = storiesForCategory(topEngagedCategory)
                        if !topEngagedStories.isEmpty && topEngagedCategory != topSelectedCategory {
                            HomeSectionHeader(
                                title: topEngagedCategory,
                                showSeeAll: true,
                                onSeeAll: { showingCategory = topEngagedCategory }
                            )
                            HorizontalScrollSection(
                                stories: topEngagedStories,
                                onStoryTap: { openCategoryStory($0, fromCategory: topEngagedStories) }
                            )
                        }
                    }

                    // 6. "More For You" (2 articles)
                    if !moreForYouStories.isEmpty {
                        HomeSectionHeader(title: "More For You")
                        VStack(spacing: 12) {
                            ForEach(moreForYouStories) { story in
                                ArticleCard(story: story, onTap: { openStory(story) })
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
        .onChange(of: cloudKitManager.userPreferences.hasCompletedOnboarding) { _, completed in
            // Regenerate feed when user completes onboarding
            if completed && !navigationState.stories.isEmpty {
                generatePersonalizedFeed()
            }
        }
        .onChange(of: cloudKitManager.userPreferences.selectedCategories) { _, _ in
            // Regenerate feed when preferences change
            if !navigationState.stories.isEmpty {
                generatePersonalizedFeed()
            }
        }
        .onChange(of: categoryResetTrigger) { _, _ in
            // Reset to Home when tab is tapped while already on Home
            selectedCategory = nil
        }
        .fullScreenCover(item: $showingCategory) { category in
            CategoryDetailView(
                category: category,
                stories: storiesForCategory(category),
                navigationState: navigationState,
                onDismiss: { showingCategory = nil }
            )
        }
    }

    // MARK: - Category Pills

    private var categoryPillsSection: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    // First half of categories
                    let midpoint = cachedCategories.count / 2
                    ForEach(Array(cachedCategories.prefix(midpoint)), id: \.self) { category in
                        CategoryPill(
                            title: category,
                            isSelected: selectedCategory == category,
                            accentColor: CategoryColors.color(for: category),
                            onTap: { selectedCategory = category }
                        )
                    }

                    // Home pill (in the middle)
                    CategoryPill(
                        title: "Home",
                        isSelected: selectedCategory == nil,
                        accentColor: "#2E5090",
                        onTap: { selectedCategory = nil }
                    )
                    .id("home-pill")

                    // Second half of categories
                    ForEach(Array(cachedCategories.suffix(from: midpoint)), id: \.self) { category in
                        CategoryPill(
                            title: category,
                            isSelected: selectedCategory == category,
                            accentColor: CategoryColors.color(for: category),
                            onTap: { selectedCategory = category }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .onAppear {
                // Center the Home pill on load
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo("home-pill", anchor: .center)
                    }
                }
            }
        }
    }

    // MARK: - Helpers

    private func openStory(_ story: Story) {
        if let index = navigationState.feedStories.firstIndex(where: { $0.id == story.id }) {
            navigationState.openStory(at: index)
        } else {
            // Story not in feed (e.g. from category section) - insert at beginning
            navigationState.feedStories.insert(story, at: 0)
            navigationState.openStory(at: 0)
        }
    }

    private func openCategoryStory(_ story: Story, fromCategory stories: [Story]) {
        // Set feedStories to just this category's stories
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

    /// Check if cached feed is valid, otherwise regenerate
    private func checkAndRefresh() {
        // Try to restore from cache first
        if cloudKitManager.isFeedCacheValid && personalizedStories.isEmpty {
            restoreFeedFromCache()
        }

        // If still empty or cache was invalid, generate new feed
        if personalizedStories.isEmpty || !cloudKitManager.isFeedCacheValid {
            generatePersonalizedFeed()
        }
    }

    /// Restore feed from cached UUIDs, filtering out newly-read articles
    private func restoreFeedFromCache() {
        let cachedIds = cloudKitManager.cachedFeedIds
        let readIds = Set(cloudKitManager.readingStats.articlesRead)

        // Reconstruct stories from cached IDs, filtering out read ones
        var restoredStories: [Story] = []
        for id in cachedIds {
            // Skip if article was read since cache was created
            if readIds.contains(id) { continue }

            if let story = navigationState.stories.first(where: { $0.id == id }) {
                restoredStories.append(story)
            }
        }

        // Only use cache if we have enough stories left
        if restoredStories.count >= 3 {
            personalizedStories = restoredStories

            // Restore featured ID if still valid
            if let cachedFeaturedId = cloudKitManager.cachedFeaturedId,
               restoredStories.contains(where: { $0.id == cachedFeaturedId }) {
                featuredStoryId = cachedFeaturedId
            } else {
                featuredStoryId = restoredStories.first?.id
            }

            // Update navigation state feed
            navigationState.feedStories = restoredStories
        }
    }

    /// Generates personalized story feed using user preferences
    private func generatePersonalizedFeed() {
        guard !navigationState.stories.isEmpty else {
            personalizedStories = []
            featuredStoryId = nil
            return
        }

        let preferences = cloudKitManager.userPreferences

        // Don't generate feed if user is in the middle of onboarding
        // (has not completed but also has no selections yet)
        // This prevents showing a random feed before preferences are set
        if !preferences.hasCompletedOnboarding && preferences.selectedCategories.isEmpty {
            print("[HomeView] Skipping feed generation - onboarding in progress")
            return
        }

        let stats = cloudKitManager.readingStats

        // Use PersonalizationEngine to get ordered stories (exclude read articles)
        let feed = PersonalizationEngine.personalizedFeed(
            stories: navigationState.stories,
            preferences: preferences,
            stats: stats,
            limit: maxHomeArticles,
            excludeRead: true
        )

        personalizedStories = feed

        // Featured story is the top personalized story
        featuredStoryId = feed.first?.id

        // Build feed stories list for reader navigation
        navigationState.feedStories = feed

        // Cache the feed for persistence across tab switches
        cloudKitManager.cacheFeed(
            storyIds: feed.map { $0.id },
            featuredId: featuredStoryId
        )
    }
}

// MARK: - Carousel View

struct CarouselView: View {
    let stories: [Story]
    let onStoryTap: (Story) -> Void
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $currentIndex) {
                ForEach(Array(stories.enumerated()), id: \.element.id) { index, story in
                    CarouselCard(story: story, onTap: { onStoryTap(story) })
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

struct CarouselCard: View {
    let story: Story
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack(alignment: .bottomLeading) {
                Color(hex: CategoryColors.color(for: story.category))

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
        .buttonStyle(.plain)
    }
}

// MARK: - Article Card (Unified)

struct ArticleCard: View {
    let story: Story
    let onTap: () -> Void
    var height: CGFloat = 120

    var body: some View {
        Button(action: onTap) {
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
            .background(Color(hex: CategoryColors.color(for: story.category)))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Home Section Header

struct HomeSectionHeader: View {
    let title: String
    var showSeeAll: Bool = false
    var onSeeAll: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.black)

            Spacer()

            if showSeeAll, let action = onSeeAll {
                Button(action: action) {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.gray)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, 12)
    }
}

// MARK: - Horizontal Scroll Section

struct HorizontalScrollSection: View {
    let stories: [Story]
    let onStoryTap: (Story) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stories.prefix(6)) { story in
                    HorizontalCard(story: story, onTap: { onStoryTap(story) })
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct HorizontalCard: View {
    let story: Story
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
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
            .background(Color(hex: CategoryColors.color(for: story.category)))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Category Pill

struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let accentColor: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(isSelected ? .white : .black.opacity(0.7))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? Color(hex: accentColor) : Color(hex: "#E5E5E5"))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Category Detail View

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
                        CategoryStoryRow(
                            story: story,
                            index: index,
                            onTap: { openStory(story) }
                        )
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

struct CategoryStoryRow: View {
    let story: Story
    let index: Int
    let onTap: () -> Void

    private var bgColor: String {
        CategoryColors.color(for: story.category)
    }

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Number
                Text("\(index + 1)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color(hex: bgColor))
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
        .buttonStyle(.plain)
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

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories

    return HomeView(navigationState: state)
        .environment(SavedStoriesManager())
}
