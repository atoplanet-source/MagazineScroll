import SwiftUI

// MARK: - Category Grid View (Q1)

/// Multi-select grid of categories with colored tiles
struct CategoryGridView: View {
    let question: QuizQuestion
    let selectedOptions: Set<String>
    let onSelect: (String) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        VStack(spacing: 32) {
            // Question
            Text(question.question)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            // Selection hint
            let selectedCount = selectedOptions.count
            Text("Select at least \(question.minimumSelections) topics")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.white.opacity(selectedCount >= question.minimumSelections ? 0.4 : 0.7))

            // Grid
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(question.options) { option in
                    CategoryTile(
                        option: option,
                        isSelected: selectedOptions.contains(option.id),
                        onTap: { onSelect(option.id) }
                    )
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Category Tile

struct CategoryTile: View {
    let option: QuizOption
    let isSelected: Bool
    let onTap: () -> Void

    private var bgColor: Color {
        Color(hex: option.color ?? "#333333")
    }

    var body: some View {
        Button(action: onTap) {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 16)
                    .fill(bgColor.opacity(isSelected ? 1.0 : 0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(.white.opacity(isSelected ? 0.8 : 0), lineWidth: 3)
                    )

                // Content
                VStack(spacing: 8) {
                    Text(option.label)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    }
                }
                .padding(16)
            }
            .frame(height: 90)
        }
        .buttonStyle(.plain)
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

#Preview {
    ZStack {
        Color(hex: "#1A1A1A").ignoresSafeArea()
        CategoryGridView(
            question: QuizQuestions.question1,
            selectedOptions: ["economics", "ancient"],
            onSelect: { _ in }
        )
    }
}
