import SwiftUI

@main
struct MagazineScrollApp: App {
    @State private var navigationState = NavigationState()
    @State private var savedStoriesManager = SavedStoriesManager()
    @State private var cloudKitManager = CloudKitManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView(navigationState: navigationState)
                .environment(savedStoriesManager)
                .environment(cloudKitManager)
                .task {
                    // Sync from iCloud
                    await cloudKitManager.syncFromCloud()

                    // Load stories from Supabase (falls back to SampleData on error)
                    do {
                        navigationState.stories = try await APIClient.shared.fetchStories()
                    } catch {
                        navigationState.stories = SampleData.stories
                    }
                }
        }
    }
}

// MARK: - Content View (Root)

struct ContentView: View {
    @Bindable var navigationState: NavigationState

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
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories
    state.feedStories = SampleData.stories

    return ContentView(navigationState: state)
        .environment(SavedStoriesManager())
        .environment(CloudKitManager.shared)
}
