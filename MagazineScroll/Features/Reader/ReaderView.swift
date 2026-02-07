import SwiftUI

// MARK: - Reader View

// MARK: - Gesture Direction
enum GestureDirection {
    case undetermined, horizontal, vertical
}

struct ReaderView: View {
    @Bindable var navigationState: NavigationState
    @Environment(CloudKitManager.self) private var cloudKitManager
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isDraggingHorizontally: Bool = false
    @State private var hasInitialized: Bool = false
    @State private var gestureDirection: GestureDirection = .undetermined
    @State private var isLoadingMore: Bool = false

    // Animation configuration for horizontal swipe
    private let swipeThreshold: CGFloat = 50
    private let velocityThreshold: CGFloat = 300

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    // Safe access to current story
    private var currentStory: Story? {
        guard currentIndex >= 0 && currentIndex < navigationState.feedStories.count else { return nil }
        return navigationState.feedStories[currentIndex]
    }
    
    private var previousStory: Story? {
        guard currentIndex > 0 && currentIndex - 1 < navigationState.feedStories.count else { return nil }
        return navigationState.feedStories[currentIndex - 1]
    }
    
    private var nextStory: Story? {
        guard currentIndex + 1 < navigationState.feedStories.count else { return nil }
        return navigationState.feedStories[currentIndex + 1]
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Previous story (for peek) - hide in random mode since next will be random anyway
                if let prevStory = previousStory, !navigationState.isRandomMode {
                    ArticleView(
                        story: prevStory,
                        onClose: { navigationState.closeReader() },
                        disableVerticalScroll: isDraggingHorizontally,
                        isExplorationMode: navigationState.isExplorationMode
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: -geometry.size.width + dragOffset)
                }

                // Current story
                if let story = currentStory {
                    ArticleView(
                        story: story,
                        onClose: { navigationState.closeReader() },
                        disableVerticalScroll: isDraggingHorizontally,
                        isExplorationMode: navigationState.isExplorationMode
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: dragOffset)
                }

                // Next story (for peek) - hide in random mode since next will be random anyway
                if let nextStory = nextStory, !navigationState.isRandomMode {
                    ArticleView(
                        story: nextStory,
                        onClose: { navigationState.closeReader() },
                        disableVerticalScroll: isDraggingHorizontally,
                        isExplorationMode: navigationState.isExplorationMode
                    )
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: geometry.size.width + dragOffset)
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 1)
                    .onChanged { value in
                        // Safety: don't process gestures if no stories
                        guard !navigationState.feedStories.isEmpty else { return }
                        
                        let horizontal = abs(value.translation.width)
                        let vertical = abs(value.translation.height)

                        // Determine direction on first movement (very early detection)
                        if gestureDirection == .undetermined && (horizontal > 3 || vertical > 3) {
                            if horizontal > vertical * 0.8 {
                                // Horizontal bias - treat as horizontal swipe
                                gestureDirection = .horizontal
                                isDraggingHorizontally = true
                            } else {
                                gestureDirection = .vertical
                            }
                        }

                        // Only process horizontal drags here
                        guard gestureDirection == .horizontal else { return }

                        let translation = value.translation.width
                        let storyCount = navigationState.feedStories.count
                        let safeCurrentIndex = min(max(0, currentIndex), max(0, storyCount - 1))

                        // In random mode, no edge resistance - can always swipe to another random article
                        if navigationState.isRandomMode {
                            dragOffset = translation
                        } else if safeCurrentIndex == 0 && translation > 0 {
                            // Add resistance at edges (non-random mode only)
                            dragOffset = translation * 0.3
                        } else if safeCurrentIndex == storyCount - 1 && translation < 0 {
                            dragOffset = translation * 0.3
                        } else {
                            dragOffset = translation
                        }
                    }
                    .onEnded { value in
                        let wasHorizontal = gestureDirection == .horizontal

                        // Reset direction state immediately
                        gestureDirection = .undetermined

                        guard wasHorizontal else {
                            isDraggingHorizontally = false
                            dragOffset = 0
                            return
                        }
                        
                        // Safety: don't process if no stories
                        guard !navigationState.feedStories.isEmpty else {
                            isDraggingHorizontally = false
                            dragOffset = 0
                            return
                        }

                        let velocity = value.velocity.width
                        let translation = value.translation.width
                        let screenWidth = geometry.size.width
                        let storyCount = navigationState.feedStories.count

                        // Ensure currentIndex is valid
                        let safeCurrentIndex = min(max(0, currentIndex), max(0, storyCount - 1))
                        var targetIndex = safeCurrentIndex

                        if translation < -swipeThreshold || velocity < -velocityThreshold {
                            if safeCurrentIndex < storyCount - 1 {
                                targetIndex = safeCurrentIndex + 1
                            }
                        } else if translation > swipeThreshold || velocity > velocityThreshold {
                            if safeCurrentIndex > 0 {
                                targetIndex = safeCurrentIndex - 1
                            }
                        }

                        if targetIndex != safeCurrentIndex {
                            if navigationState.isRandomMode && storyCount > 0 {
                                // Random mode: instant transition with crossfade, no slide
                                // (No peek view is rendered, so slide would show black screen)
                                let nextRandomIndex = Int.random(in: 0..<storyCount)
                                dragOffset = 0
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    currentIndex = nextRandomIndex
                                }
                                isDraggingHorizontally = false
                            } else {
                                // Normal mode: slide animation with peek view
                                let targetOffset = targetIndex > safeCurrentIndex ? -screenWidth : screenWidth

                                withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                                    dragOffset = targetOffset
                                }

                                // After animation, update index and reset offset (no visual change)
                                let capturedTargetIndex = targetIndex
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                    currentIndex = capturedTargetIndex
                                    dragOffset = 0
                                    isDraggingHorizontally = false
                                }
                            }
                        } else {
                            // Snap back to current position
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.9)) {
                                dragOffset = 0
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                isDraggingHorizontally = false
                            }
                        }
                    }
            )
        }
        .ignoresSafeArea()
        .background(Color.black)
        .onAppear {
            if !hasInitialized {
                // Ensure currentIndex is within bounds
                let maxIndex = max(0, navigationState.feedStories.count - 1)
                currentIndex = min(max(0, navigationState.currentStoryIndex), maxIndex)
                hasInitialized = true
            }
            // Pre-warm adjacent story page caches for smooth swiping
            preWarmAdjacentPages()
        }
        .onChange(of: currentIndex) { _, newIndex in
            navigationState.currentStoryIndex = newIndex
            checkAndLoadMore()
            // Pre-warm adjacent pages after swiping to new article
            preWarmAdjacentPages()
        }
    }

    // MARK: - Page Pre-warming

    /// Pre-warm adjacent story page caches for smooth horizontal swiping
    private func preWarmAdjacentPages() {
        let screenSize = UIScreen.main.bounds.size

        // Pre-warm previous story (if not in random mode)
        if let prevStory = previousStory, !navigationState.isRandomMode {
            if !PageCache.shared.contains(prevStory.id) {
                Task.detached(priority: .utility) {
                    let pages = ArticleView.calculatePages(story: prevStory, screenSize: screenSize)
                    await MainActor.run {
                        PageCache.shared.set(prevStory.id, pages: pages)
                    }
                }
            }
        }

        // Pre-warm next story (if not in random mode)
        if let nextStory = nextStory, !navigationState.isRandomMode {
            if !PageCache.shared.contains(nextStory.id) {
                Task.detached(priority: .utility) {
                    let pages = ArticleView.calculatePages(story: nextStory, screenSize: screenSize)
                    await MainActor.run {
                        PageCache.shared.set(nextStory.id, pages: pages)
                    }
                }
            }
        }
    }

    // MARK: - Infinite Scroll

    /// Check if we're approaching the end of the feed and need to load more
    private func checkAndLoadMore() {
        let remaining = navigationState.feedStories.count - currentIndex

        // Load more when 2 or fewer articles remain
        if remaining <= 2 && !isLoadingMore {
            loadMoreStories()
        }
    }

    /// Load more personalized stories to append to the feed
    private func loadMoreStories() {
        isLoadingMore = true

        let preferences = cloudKitManager.userPreferences
        let stats = cloudKitManager.readingStats
        let currentIDs = Set(navigationState.feedStories.map { $0.id })

        // Get more personalized stories (excluding current feed and read articles)
        var moreStories = PersonalizationEngine.personalizedFeed(
            stories: navigationState.stories.filter { !currentIDs.contains($0.id) },
            preferences: preferences,
            stats: stats,
            limit: 10,
            excludeRead: true
        )

        // Mix in discovery stories for "surprise me" users
        if preferences.discoveryMode == .surpriseMe {
            let discoveryCount = 3  // Add 3 random from non-preferred categories
            let preferredCategories = Set(preferences.selectedCategories)
            let discoveryStories = navigationState.stories
                .filter { !currentIDs.contains($0.id) && !preferredCategories.contains($0.category ?? "") }
                .shuffled()
                .prefix(discoveryCount)

            moreStories.append(contentsOf: discoveryStories)
            moreStories.shuffle()
        }

        if !moreStories.isEmpty {
            navigationState.feedStories.append(contentsOf: moreStories)
        }

        isLoadingMore = false
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories
    state.feedStories = SampleData.stories
    state.isShowingReader = true

    return ReaderView(navigationState: state)
        .environment(SavedStoriesManager())
}
