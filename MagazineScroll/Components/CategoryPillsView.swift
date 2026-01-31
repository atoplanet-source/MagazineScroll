import SwiftUI

// MARK: - Category Pills View

/// Horizontal scrolling category filter pills
struct CategoryPillsView: View {
    let categories: [String]
    @Binding var selectedCategory: String?
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    // First half of categories
                    let midpoint = categories.count / 2
                    ForEach(Array(categories.prefix(midpoint)), id: \.self) { category in
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
                    ForEach(Array(categories.suffix(from: midpoint)), id: \.self) { category in
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

// MARK: - Preview

#Preview {
    CategoryPillsView(
        categories: ["Art", "Science", "History", "Crime", "War"],
        selectedCategory: .constant(nil)
    )
    .background(Color(hex: "#F5F4F0"))
}
