import SwiftUI

// MARK: - Onboarding View

/// Main onboarding quiz flow container
struct OnboardingView: View {
    @State private var viewModel = OnboardingViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Background
            Color(hex: "#1A1A1A")
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                topBar
                    .padding(.top, 8)

                Spacer()

                // Question content
                questionContent
                    .opacity(viewModel.isTransitioning ? 0 : 1)
                    .offset(y: viewModel.isTransitioning ? 20 : 0)

                Spacer()

                // Bottom button
                bottomButton
                    .padding(.bottom, 40)
            }
        }
        .statusBarHidden(false)
    }

    // MARK: - Top Bar

    private var topBar: some View {
        VStack(spacing: 16) {
            // Back button and progress
            HStack {
                // Back button
                Button {
                    if viewModel.currentQuestionIndex > 0 {
                        viewModel.previousQuestion()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white.opacity(viewModel.currentQuestionIndex > 0 ? 0.8 : 0.3))
                }
                .disabled(viewModel.currentQuestionIndex == 0)

                Spacer()

                // Question counter
                Text("\(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.6))

                Spacer()

                // Placeholder for symmetry
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.clear)
            }
            .padding(.horizontal, 24)

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    // Track
                    Capsule()
                        .fill(Color.white.opacity(0.15))
                        .frame(height: 4)

                    // Progress
                    Capsule()
                        .fill(Color.white)
                        .frame(width: geo.size.width * viewModel.progress, height: 4)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.progress)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 24)
        }
    }

    // MARK: - Question Content

    @ViewBuilder
    private var questionContent: some View {
        if let question = viewModel.currentQuestion {
            switch question.type {
            case .categoryGrid:
                CategoryGridView(
                    question: question,
                    selectedOptions: viewModel.selectedOptionsForCurrentQuestion,
                    onSelect: { viewModel.selectOption($0) }
                )

            case .comparison:
                ComparisonView(
                    question: question,
                    selectedOption: viewModel.selectedOptionsForCurrentQuestion.first,
                    onSelect: { viewModel.selectOption($0) }
                )

            case .singleChoice:
                QuizQuestionView(
                    question: question,
                    selectedOption: viewModel.selectedOptionsForCurrentQuestion.first,
                    onSelect: { viewModel.selectOption($0) }
                )
            }
        }
    }

    // MARK: - Bottom Button

    private var bottomButton: some View {
        Button {
            viewModel.nextQuestion()
        } label: {
            Text(viewModel.isLastQuestion ? "Get Started" : "Continue")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(viewModel.canProceed ? Color(hex: "#1A1A1A") : .white.opacity(0.4))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(viewModel.canProceed ? Color.white : Color.white.opacity(0.1))
                )
        }
        .disabled(!viewModel.canProceed)
        .padding(.horizontal, 24)
        .animation(.easeInOut(duration: 0.2), value: viewModel.canProceed)
    }
}

#Preview {
    OnboardingView()
}
