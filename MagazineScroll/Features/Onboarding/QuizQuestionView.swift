import SwiftUI

// MARK: - Quiz Question View (Single Choice Q3, Q5, Q8)

/// Single selection view with icon-based options
struct QuizQuestionView: View {
    let question: QuizQuestion
    let selectedOption: String?
    let onSelect: (String) -> Void

    var body: some View {
        VStack(spacing: 40) {
            // Question
            Text(question.question)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            // Options
            VStack(spacing: 16) {
                ForEach(question.options) { option in
                    SingleChoiceRow(
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

// MARK: - Single Choice Row

struct SingleChoiceRow: View {
    let option: QuizOption
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Icon
                if let icon = option.icon {
                    ZStack {
                        Circle()
                            .fill(isSelected ? Color.white : Color.white.opacity(0.15))
                            .frame(width: 48, height: 48)

                        Image(systemName: icon)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(isSelected ? Color(hex: "#1A1A1A") : .white)
                    }
                }

                // Text
                VStack(alignment: .leading, spacing: 4) {
                    Text(option.label)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)

                    if let description = option.description {
                        Text(description)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }

                Spacer()

                // Selection indicator
                ZStack {
                    Circle()
                        .strokeBorder(.white.opacity(0.4), lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? Color.white.opacity(0.15) : Color.white.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(.white.opacity(isSelected ? 0.4 : 0.1), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(isSelected ? 1.01 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}

#Preview {
    ZStack {
        Color(hex: "#1A1A1A").ignoresSafeArea()
        QuizQuestionView(
            question: QuizQuestions.question3,
            selectedOption: "mix",
            onSelect: { _ in }
        )
    }
}
