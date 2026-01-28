import SwiftUI

@main
struct MagazineScrollApp: App {
    @State private var navigationState = NavigationState()
    @State private var savedStoriesManager = SavedStoriesManager()
    @State private var cloudKitManager = CloudKitManager.shared
    @State private var showOnboarding = false

    var body: some Scene {
        WindowGroup {
            ContentView(navigationState: navigationState, showOnboarding: $showOnboarding)
                .environment(savedStoriesManager)
                .environment(cloudKitManager)
                .task {
                    // Sync from iCloud
                    await cloudKitManager.syncFromCloud()

                    // Check if onboarding is needed
                    if !cloudKitManager.hasCompletedOnboarding {
                        showOnboarding = true
                    }

                    // Load stories from Supabase (falls back to SampleData on error)
                    do {
                        navigationState.stories = try await APIClient.shared.fetchStories()
                    } catch {
                        navigationState.stories = SampleData.stories
                    }
                }
                .onChange(of: cloudKitManager.hasCompletedOnboarding) { _, completed in
                    if completed {
                        showOnboarding = false
                    }
                }
        }
    }
}

// MARK: - Content View (Root)

struct ContentView: View {
    @Bindable var navigationState: NavigationState
    @Binding var showOnboarding: Bool

    var body: some View {
        ZStack {
            // Main tab-based content
            MainTabView(navigationState: navigationState)
                .zIndex(0)

            // Reader overlay
            if navigationState.isShowingReader {
                ReaderView(navigationState: navigationState)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
        .animation(.easeOut(duration: 0.3), value: navigationState.isShowingReader)
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingView()
        }
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories
    state.feedStories = SampleData.stories

    return ContentView(navigationState: state, showOnboarding: .constant(false))
        .environment(SavedStoriesManager())
        .environment(CloudKitManager.shared)
}
