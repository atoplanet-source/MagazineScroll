import SwiftUI

// MARK: - Home Section Header

/// Section header with optional "See all" button
struct HomeSectionHeader: View {
    let title: String
    var icon: String? = nil
    var showSeeAll: Bool = false
    var onSeeAll: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            HStack(spacing: 6) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(hex: "#2E5090"))
                }
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
            }
            
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

// MARK: - Preview

#Preview {
    VStack(spacing: 0) {
        HomeSectionHeader(title: "For You")
        HomeSectionHeader(title: "Science", showSeeAll: true, onSeeAll: {})
    }
    .background(Color(hex: "#F5F4F0"))
}
