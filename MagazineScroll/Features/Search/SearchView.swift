import SwiftUI

// MARK: - Search View

struct SearchView: View {
    @Bindable var navigationState: NavigationState
    @Environment(CloudKitManager.self) private var cloudKitManager
    
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var searchResults: [Story] = []
    @State private var selectedCategory: IdentifiableString? = nil
    @State private var recentSearches: [String] = []
    
    @FocusState private var isSearchFocused: Bool
    
    // Categories derived from stories
    private var categories: [CategoryInfo] {
        var categoryMap: [String: Int] = [:]
        for story in navigationState.stories {
            if let cat = story.category {
                categoryMap[cat, default: 0] += 1
            }
        }
        return categoryMap.map { CategoryInfo(name: $0.key, count: $0.value) }
            .sorted { $0.count > $1.count }
    }
    
    // Trending searches (could be dynamic later)
    private var trendingSearches: [String] {
        ["Pompeii", "World War II", "Renaissance art", "Ancient Egypt", "Vikings"]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Search Bar
            searchBar
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 12)
            
            if isSearching && !searchText.isEmpty {
                // Search Results
                searchResultsView
            } else {
                // Browse Mode
                browseView
            }
        }
        .background(Color(hex: "#F5F4F0"))
        .onChange(of: searchText) { _, newValue in
            performSearch(query: newValue)
        }
        .fullScreenCover(item: $selectedCategory) { category in
            CategoryDetailView(
                category: category.value,
                stories: storiesForCategory(category.value),
                navigationState: navigationState,
                onDismiss: { selectedCategory = nil }
            )
        }
    }
    
    // MARK: - Search Bar
    
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(isSearchFocused ? Color(hex: "#2E5090") : .gray)
            
            TextField("Search stories, topics, categories...", text: $searchText)
                .font(.system(size: 15, weight: .medium))
                .focused($isSearchFocused)
                .onSubmit {
                    if !searchText.isEmpty {
                        addToRecentSearches(searchText)
                    }
                }
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    isSearching = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(isSearchFocused ? Color(hex: "#2E5090") : .clear, lineWidth: 2)
        )
    }
    
    // MARK: - Browse View
    
    private var browseView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                // Browse Categories
                HomeSectionHeader(title: "Browse")
                
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 12) {
                    ForEach(categories, id: \.name) { category in
                        CategoryBrowseCard(category: category) {
                            selectedCategory = IdentifiableString(category.name)
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                // Trending Searches
                HomeSectionHeader(title: "Trending")
                
                VStack(spacing: 0) {
                    ForEach(Array(trendingSearches.enumerated()), id: \.element) { index, term in
                        TrendingSearchRow(rank: index + 1, term: term) {
                            searchText = term
                            isSearching = true
                            addToRecentSearches(term)
                        }
                    }
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal, 16)
                
                // Recent Searches (if any)
                if !recentSearches.isEmpty {
                    HStack {
                        HomeSectionHeader(title: "Recent")
                        Spacer()
                        Button("Clear") {
                            recentSearches.removeAll()
                        }
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.gray)
                        .padding(.trailing, 16)
                        .padding(.top, 24)
                    }
                    
                    VStack(spacing: 0) {
                        ForEach(recentSearches, id: \.self) { term in
                            RecentSearchRow(term: term) {
                                searchText = term
                                isSearching = true
                            }
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 16)
                }
                
                Spacer(minLength: 100)
            }
        }
    }
    
    // MARK: - Search Results View
    
    private var searchResultsView: some View {
        VStack(spacing: 0) {
            // Results count
            HStack {
                Text("\(searchResults.count) stories found")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
            
            if searchResults.isEmpty {
                emptySearchView
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(searchResults) { story in
                            SearchResultCard(story: story, searchQuery: searchText) {
                                openStory(story)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 100)
                }
            }
        }
    }
    
    private var emptySearchView: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            Text("No results for \"\(searchText)\"")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.secondary)
            Text("Try a different search term")
                .font(.system(size: 14))
                .foregroundStyle(.tertiary)
            Spacer()
        }
    }
    
    // MARK: - Helpers
    
    private func performSearch(query: String) {
        guard !query.isEmpty else {
            isSearching = false
            searchResults = []
            return
        }
        
        isSearching = true
        let lowercasedQuery = query.lowercased()
        
        searchResults = navigationState.stories.filter { story in
            // Search in title
            if story.title.lowercased().contains(lowercasedQuery) { return true }
            
            // Search in category
            if let category = story.category?.lowercased(), category.contains(lowercasedQuery) { return true }
            
            // Search in tags
            if let tags = story.tags {
                for tag in tags {
                    if tag.lowercased().contains(lowercasedQuery) { return true }
                }
            }
            
            // Search in description
            if let desc = story.description?.lowercased(), desc.contains(lowercasedQuery) { return true }
            
            return false
        }
    }
    
    private func storiesForCategory(_ category: String) -> [Story] {
        let readIDs = Set(cloudKitManager.readingStats.articlesRead)
        return navigationState.stories.filter { story in
            story.category == category && !readIDs.contains(story.id)
        }
    }
    
    private func openStory(_ story: Story) {
        // Add to recent searches
        if !searchText.isEmpty {
            addToRecentSearches(searchText)
        }
        
        navigationState.feedStories = searchResults.isEmpty ? [story] : searchResults
        if let index = navigationState.feedStories.firstIndex(where: { $0.id == story.id }) {
            navigationState.openStory(at: index)
        } else {
            navigationState.feedStories.insert(story, at: 0)
            navigationState.openStory(at: 0)
        }
    }
    
    private func addToRecentSearches(_ term: String) {
        // Remove if already exists
        recentSearches.removeAll { $0.lowercased() == term.lowercased() }
        // Add to front
        recentSearches.insert(term, at: 0)
        // Keep only last 5
        if recentSearches.count > 5 {
            recentSearches = Array(recentSearches.prefix(5))
        }
    }
}

// MARK: - Category Info

struct CategoryInfo {
    let name: String
    let count: Int
}

// MARK: - Category Browse Card

struct CategoryBrowseCard: View {
    let category: CategoryInfo
    let onTap: () -> Void
    
    private var bgColor: String {
        CategoryColors.color(for: category.name)
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 4) {
                Spacer()
                Text(category.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                Text("\(category.count) stories")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.7))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(14)
            .frame(height: 100)
            .background(
                ZStack {
                    Color(hex: bgColor)
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.3)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Trending Search Row

struct TrendingSearchRow: View {
    let rank: Int
    let term: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Text("\(rank)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color(hex: "#2E5090"))
                    .frame(width: 24)
                
                Text(term)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.gray.opacity(0.5))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Recent Search Row

struct RecentSearchRow: View {
    let term: String
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                
                Text(term)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(systemName: "arrow.up.left")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.gray.opacity(0.5))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Search Result Card

struct SearchResultCard: View {
    let story: Story
    let searchQuery: String
    let onTap: () -> Void
    
    private var bgColor: String {
        CategoryColors.color(for: story.category)
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                // Category pill
                Text(story.category?.uppercased() ?? "")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(Color(hex: bgColor))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(hex: bgColor).opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                // Title with highlight
                highlightedTitle
                
                // Preview
                if let desc = story.description {
                    Text(desc)
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                
                // Meta
                HStack(spacing: 12) {
                    if let sections = story.sections.count as Int?, sections > 0 {
                        Text("\(sections + 1) pages")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.tertiary)
                    }
                }
                .padding(.top, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: .black.opacity(0.04), radius: 8, y: 2)
        }
        .buttonStyle(.plain)
    }
    
    private var highlightedTitle: some View {
        let title = story.title
        let query = searchQuery.lowercased()
        
        if let range = title.lowercased().range(of: query) {
            let before = String(title[..<range.lowerBound])
            let match = String(title[range])
            let after = String(title[range.upperBound...])
            
            return Text(before)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.black)
            + Text(match)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.black)
                .background(Color(hex: "#FFF3CD"))
            + Text(after)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.black)
        } else {
            return Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(.black)
        }
    }
}

// MARK: - Preview

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories
    
    return SearchView(navigationState: state)
        .environment(CloudKitManager.shared)
}
