import Foundation
import SwiftUI

// MARK: - Onboarding View Model

@Observable
final class OnboardingViewModel {
    // Quiz state
    var currentQuestionIndex: Int = 0
    var answers: [Int: Set<String>] = [:]  // Question ID -> Selected option IDs

    // Animation
    var isTransitioning: Bool = false

    private let cloudKitManager: CloudKitManager

    init(cloudKitManager: CloudKitManager = .shared) {
        self.cloudKitManager = cloudKitManager
    }

    // MARK: - Computed Properties

    /// Dynamically build questions based on previous answers
    var questions: [QuizQuestion] {
        buildQuestionList()
    }

    var currentQuestion: QuizQuestion? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }

    var progress: Double {
        Double(currentQuestionIndex) / Double(questions.count)
    }

    var isLastQuestion: Bool {
        currentQuestionIndex == questions.count - 1
    }

    var canProceed: Bool {
        guard let question = currentQuestion else { return false }
        let selectedCount = answers[question.id]?.count ?? 0
        return selectedCount >= question.minimumSelections
    }

    var selectedOptionsForCurrentQuestion: Set<String> {
        guard let question = currentQuestion else { return [] }
        return answers[question.id] ?? []
    }

    // MARK: - Dynamic Question Builder

    private func buildQuestionList() -> [QuizQuestion] {
        var result: [QuizQuestion] = []

        // Q1: Always - Topic selection (required)
        result.append(QuizQuestions.question1)

        // Q2: Always - Era preference
        result.append(QuizQuestions.question2)

        // Q3: Always - Content tone
        result.append(QuizQuestions.question3)

        // Get selected topics from Q1
        let selectedTopics = answers[1] ?? []

        // Conditional comparison questions based on Q1 selections:
        // Only show comparisons when user selected BOTH topics
        // This asks "which do you prefer MORE?" rather than forcing unrelated choices

        // Q4a: Economics vs Art - show only if BOTH were selected
        if selectedTopics.contains("economics") && selectedTopics.contains("art") {
            result.append(QuizQuestions.question4a)
        }

        // Q4b: Medieval vs 20th Century - show only if BOTH were selected
        if selectedTopics.contains("medieval") && selectedTopics.contains("20th") {
            result.append(QuizQuestions.question4b)
        }

        // Q4c: Ancient vs 19th Century - show only if BOTH were selected
        if selectedTopics.contains("ancient") && selectedTopics.contains("19th") {
            result.append(QuizQuestions.question4c)
        }

        // Q5: Always - Discovery mode
        result.append(QuizQuestions.question5)

        // Q6: Exploration vs War - show only if BOTH were selected
        if selectedTopics.contains("exploration") && selectedTopics.contains("war") {
            result.append(QuizQuestions.question6)
        }

        // Q7: Crime vs Science - show only if BOTH were selected
        if selectedTopics.contains("crime") && selectedTopics.contains("science") {
            result.append(QuizQuestions.question7)
        }

        // Category follow-up questions (Q101-Q110)
        // Show one follow-up for each category selected in Q1
        for topicId in selectedTopics {
            if let followUp = QuizQuestions.categoryFollowUps[topicId] {
                result.append(followUp)
            }
        }

        // Q8: Always - Reading goal (at the end)
        result.append(QuizQuestions.question8)

        return result
    }

    // MARK: - Actions

    func selectOption(_ optionId: String) {
        guard let question = currentQuestion else { return }

        var currentAnswers = answers[question.id] ?? []

        switch question.type {
        case .categoryGrid:
            // Multi-select toggle
            if currentAnswers.contains(optionId) {
                currentAnswers.remove(optionId)
            } else {
                currentAnswers.insert(optionId)
            }
        case .comparison, .singleChoice:
            // Single select - replace
            currentAnswers = [optionId]
        }

        answers[question.id] = currentAnswers
    }

    func isSelected(_ optionId: String) -> Bool {
        guard let question = currentQuestion else { return false }
        return answers[question.id]?.contains(optionId) ?? false
    }

    func nextQuestion() {
        guard canProceed else { return }

        withAnimation(.easeInOut(duration: 0.3)) {
            isTransitioning = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            if self.isLastQuestion {
                self.completeOnboarding()
            } else {
                self.currentQuestionIndex += 1
            }

            withAnimation(.easeInOut(duration: 0.3)) {
                self.isTransitioning = false
            }
        }
    }

    func previousQuestion() {
        guard currentQuestionIndex > 0 else { return }

        withAnimation(.easeInOut(duration: 0.3)) {
            isTransitioning = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.currentQuestionIndex -= 1
            withAnimation(.easeInOut(duration: 0.3)) {
                self.isTransitioning = false
            }
        }
    }

    // MARK: - Complete Onboarding

    private func completeOnboarding() {
        var preferences = UserPreferences()

        // Q1 (id=1): Categories - Always present
        if let categoryAnswers = answers[1] {
            let allOptions = QuizQuestions.question1.options
            let selectedCategories = allOptions
                .filter { categoryAnswers.contains($0.id) }
                .flatMap { $0.categories ?? [] }
            preferences.selectedCategories = selectedCategories
        }

        // Q2 (id=2): Era Preference - Always present
        if let eraAnswer = answers[2]?.first {
            switch eraAnswer {
            case "ancient": preferences.eraPreference = .ancient
            case "both": preferences.eraPreference = .both
            case "modern": preferences.eraPreference = .modern
            default: preferences.eraPreference = .both
            }
        }

        // Q3 (id=3): Content Tone - Always present
        if let toneAnswer = answers[3]?.first {
            preferences.contentTone = toneAnswer == "serious" ? .serious : .fun
        }

        // Q4a (id=4): Economics vs Art - Conditional
        if let answer = answers[4]?.first {
            preferences.economicsVsArt = answer == "economics" ? .optionA : .optionB
        }

        // Q4b (id=5): Medieval vs 20th Century - Conditional
        if let answer = answers[5]?.first {
            preferences.medievalVs20th = answer == "medieval" ? .optionA : .optionB
        }

        // Q4c (id=6): Ancient World vs 19th Century - Conditional
        if let answer = answers[6]?.first {
            preferences.ancientVs19th = answer == "ancient" ? .optionA : .optionB
        }

        // Q5 (id=7): Discovery Mode - Always present
        if let answer = answers[7]?.first {
            preferences.discoveryMode = answer == "comfort" ? .comfortZone : .surpriseMe
        }

        // Q6 (id=8): Exploration vs War - Conditional
        if let answer = answers[8]?.first {
            preferences.explorationVsWar = answer == "exploration" ? .optionA : .optionB
        }

        // Q7 (id=9): Crime vs Science - Conditional
        if let answer = answers[9]?.first {
            preferences.crimeVsScience = answer == "crime" ? .optionA : .optionB
        }

        // Q8 (id=10): Reading Goal - Always present
        if let answer = answers[10]?.first {
            switch answer {
            case "casual": preferences.readingGoal = .casual
            case "power": preferences.readingGoal = .power
            default: preferences.readingGoal = .regular
            }
        }

        // Category follow-up questions (Q101-Q110): Collect selected tags
        var allSelectedTags: [String] = []
        for (categoryId, followUpQuestion) in QuizQuestions.categoryFollowUps {
            // Check if user answered this follow-up
            if let selectedOptions = answers[followUpQuestion.id] {
                // Find the tags for each selected option
                for optionId in selectedOptions {
                    if let option = followUpQuestion.options.first(where: { $0.id == optionId }),
                       let tags = option.tags {
                        allSelectedTags.append(contentsOf: tags)
                    }
                }
            }
        }
        preferences.selectedTags = Array(Set(allSelectedTags)) // Remove duplicates

        preferences.hasCompletedOnboarding = true
        preferences.lastUpdated = Date()

        cloudKitManager.updatePreferences(preferences)
    }
}
