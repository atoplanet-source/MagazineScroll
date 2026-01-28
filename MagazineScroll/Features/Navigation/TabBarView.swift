import SwiftUI

// MARK: - Tab Selection

enum TabSelection: Int, CaseIterable {
    case home = 0
    case explore = 1
    case profile = 2

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .explore: return "sparkles"
        case .profile: return "person.fill"
        }
    }

    var label: String {
        switch self {
        case .home: return "Home"
        case .explore: return "Discover"
        case .profile: return "Profile"
        }
    }
}

// MARK: - Custom Tab Bar View

struct TabBarView: View {
    @Binding var selectedTab: TabSelection
    var onHomeTapped: (() -> Void)? = nil  // Callback when Home is tapped

    private let tabBarHeight: CGFloat = 60

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabSelection.allCases, id: \.rawValue) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    onTap: {
                        // If tapping Home while already on Home, trigger callback
                        if tab == .home && selectedTab == .home {
                            onHomeTapped?()
                        }
                        selectedTab = tab
                    }
                )
            }
        }
        .frame(height: tabBarHeight)
        .background(
            Rectangle()
                .fill(Color(hex: "#1A1A1A"))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: -4)
        )
    }
}

// MARK: - Tab Bar Button

struct TabBarButton: View {
    let tab: TabSelection
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 22, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(isSelected ? .white : .white.opacity(0.4))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color(hex: "#1A1A1A").ignoresSafeArea()

        VStack {
            Spacer()
            TabBarView(selectedTab: .constant(.home))
        }
    }
}
