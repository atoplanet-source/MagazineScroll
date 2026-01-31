import SwiftUI

// MARK: - Main Tab View

/// Root tab container with 3 tabs: Home, Search, Profile
struct MainTabView: View {
    @Bindable var navigationState: NavigationState
    @State private var selectedTab: TabSelection = .home
    @State private var homeCategoryResetTrigger: Bool = false  // Toggles to trigger category reset

    var body: some View {
        ZStack(alignment: .bottom) {
            // Tab content
            Group {
                switch selectedTab {
                case .home:
                    HomeView(
                        navigationState: navigationState,
                        categoryResetTrigger: homeCategoryResetTrigger
                    )

                case .search:
                    SearchView(navigationState: navigationState)

                case .profile:
                    ProfileView(navigationState: navigationState)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Tab bar (hidden when reader is showing)
            if !navigationState.isShowingReader {
                VStack(spacing: 0) {
                    Spacer()
                    TabBarView(
                        selectedTab: $selectedTab,
                        onHomeTapped: {
                            // Toggle to trigger category reset in HomeView
                            homeCategoryResetTrigger.toggle()
                        }
                    )
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: navigationState.isShowingReader)
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories
    state.feedStories = SampleData.stories

    return MainTabView(navigationState: state)
        .environment(SavedStoriesManager())
        .environment(CloudKitManager.shared)
}
