import SwiftUI

// MARK: - Comparison View (Q2, Q4, Q6, Q7)

/// A vs B dual card comparison for binary choices
struct ComparisonView: View {
    let question: QuizQuestion
    let selectedOption: String?
    let onSelect: (String) -> Void

    var body: some View {
        VStack(spacing: 32) {
            // Question
            Text(question.question)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            // Comparison cards
            HStack(spacing: 16) {
                ForEach(question.options) { option in
                    ComparisonCard(
                        option: option,
                        isSelected: selectedOption == option.id,
                        onTap: { onSelect(option.id) }
                    )
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

// MARK: - Comparison Card

struct ComparisonCard: View {
    let option: QuizOption
    let isSelected: Bool
    let onTap: () -> Void

    private var bgColor: Color {
        Color(hex: option.color ?? "#333333")
    }

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 16) {
                // Icon
                if let icon = option.icon {
                    Image(systemName: icon)
                        .font(.system(size: 36, weight: .medium))
                        .foregroundStyle(.white)
                }

                // Title
                Text(option.label)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                // Description
                if let description = option.description {
                    Text(description)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 32)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(bgColor.opacity(isSelected ? 1.0 : 0.5))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.white.opacity(isSelected ? 0.8 : 0), lineWidth: 3)
            )
            .scaleEffect(isSelected ? 1.02 : 1.0)
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

#Preview {
    ZStack {
        Color(hex: "#1A1A1A").ignoresSafeArea()
        ComparisonView(
            question: QuizQuestions.question2,
            selectedOption: "ancient",
            onSelect: { _ in }
        )
    }
}
