import SwiftUI

// MARK: - Tab Selection

enum TabSelection: Int, CaseIterable {
    case home = 0
    case search = 1
    case profile = 2

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .search: return "magnifyingglass"
        case .profile: return "person.fill"
        }
    }

    var label: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .profile: return "Profile"
        }
    }
}

// MARK: - Custom Tab Bar View

struct TabBarView: View {
    @Binding var selectedTab: TabSelection
    var onHomeTapped: (() -> Void)? = nil  // Callback when Home is tapped

    private let tabBarHeight: CGFloat = 56
    private let bottomPadding: CGFloat = 28  // Extra padding above home indicator

    var body: some View {
        VStack(spacing: 0) {
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
            
            // Bottom padding for home indicator area
            Spacer()
                .frame(height: bottomPadding)
        }
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: -2)
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
                    .foregroundStyle(isSelected ? .black : .black.opacity(0.35))
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
        Color(hex: "#F5F4F0").ignoresSafeArea()

        VStack {
            Spacer()
            TabBarView(selectedTab: .constant(.home))
        }
    }
}
