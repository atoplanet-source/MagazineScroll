import Foundation

// MARK: - User Preferences Model

/// Stores user's quiz answers and derived preferences for personalization
struct UserPreferences: Codable, Equatable {
    // Quiz answers
    var selectedCategories: [String]       // Q1: Multi-select categories (min 3)
    var eraPreference: EraPreference       // Q2: Ancient vs Modern vs Both
    var contentTone: ContentTone           // Q3: Serious vs Fun
    var economicsVsArt: ContentPreference  // Q4a: Economics or Art
    var medievalVs20th: ContentPreference  // Q4b: Medieval or 20th Century
    var ancientVs19th: ContentPreference   // Q4c: Ancient World or 19th Century
    var discoveryMode: DiscoveryMode       // Q5: Comfort zone vs Surprise
    var explorationVsWar: ContentPreference // Q6: Exploration or War
    var crimeVsScience: ContentPreference  // Q7: Crime or Science
    var readingGoal: ReadingGoal           // Q8: Casual/Regular/Power

    // Tag preferences from follow-up questions (Q101-Q110)
    var selectedTags: [String]

    // Exploration tracking: Category -> times liked from explore tab
    var explorationConversions: [String: Int] = [:]

    var hasCompletedOnboarding: Bool
    var lastUpdated: Date

    init() {
        self.selectedCategories = []
        self.eraPreference = .both
        self.contentTone = .fun
        self.economicsVsArt = .neither
        self.medievalVs20th = .neither
        self.ancientVs19th = .neither
        self.discoveryMode = .balanced
        self.explorationVsWar = .neither
        self.crimeVsScience = .neither
        self.readingGoal = .regular
        self.selectedTags = []
        self.explorationConversions = [:]
        self.hasCompletedOnboarding = false
        self.lastUpdated = Date()
    }

    // MARK: - Computed Properties

    /// All categories the user prefers based on quiz answers
    var preferredCategories: Set<String> {
        var categories = Set(selectedCategories)

        // Add era-based categories
        switch eraPreference {
        case .ancient:
            categories.insert("Ancient World")
            categories.insert("Medieval")
        case .modern:
            categories.insert("19th Century")
            categories.insert("20th Century")
            categories.insert("Science")
        case .both:
            break
        }

        // Add comparison-based categories
        switch economicsVsArt {
        case .optionA: categories.insert("Economics")
        case .optionB: categories.insert("Art")
        case .neither: break
        }

        switch medievalVs20th {
        case .optionA: categories.insert("Medieval")
        case .optionB: categories.insert("20th Century")
        case .neither: break
        }

        switch ancientVs19th {
        case .optionA: categories.insert("Ancient World")
        case .optionB: categories.insert("19th Century")
        case .neither: break
        }

        switch explorationVsWar {
        case .optionA: categories.insert("Exploration")
        case .optionB: categories.insert("War")
        case .neither: break
        }

        switch crimeVsScience {
        case .optionA: categories.insert("Crime")
        case .optionB: categories.insert("Science")
        case .neither: break
        }

        return categories
    }

    /// Category weights for personalization scoring (0.0 - 1.0)
    func categoryWeight(for category: String) -> Double {
        if selectedCategories.contains(category) {
            return 1.0  // Explicitly selected
        } else if preferredCategories.contains(category) {
            return 0.7  // Inferred from comparisons
        }
        return 0.3  // Not selected but not excluded
    }

    /// Tag weights for personalization scoring (0.0 - 1.0)
    func tagWeight(for tag: String) -> Double {
        if selectedTags.contains(tag) {
            return 1.0  // Explicitly selected
        }
        return 0.5  // Neutral
    }

    /// How much variety to inject into recommendations
    var varietyFactor: Double {
        switch discoveryMode {
        case .comfortZone: return 0.1
        case .surpriseMe: return 0.4
        case .balanced: return 0.25
        }
    }
}

// MARK: - Preference Enums

enum EraPreference: String, Codable, CaseIterable {
    case ancient = "ancient"
    case modern = "modern"
    case both = "both"
}

enum ContentTone: String, Codable, CaseIterable {
    case serious = "serious"
    case fun = "fun"

    var displayName: String {
        switch self {
        case .serious: return "Serious & scholarly"
        case .fun: return "Fun & surprising"
        }
    }

    var icon: String {
        switch self {
        case .serious: return "text.book.closed.fill"
        case .fun: return "party.popper.fill"
        }
    }
}

enum ContentPreference: String, Codable {
    case optionA = "optionA"
    case optionB = "optionB"
    case neither = "neither"
}

enum DiscoveryMode: String, Codable, CaseIterable {
    case comfortZone = "comfort"
    case surpriseMe = "surprise"
    case balanced = "balanced"

    var displayName: String {
        switch self {
        case .comfortZone: return "Stay in my comfort zone"
        case .surpriseMe: return "Surprise me often"
        case .balanced: return "Balance both"
        }
    }
}

enum ReadingGoal: String, Codable, CaseIterable {
    case casual = "casual"     // A few articles a week
    case regular = "regular"   // Something new every day
    case power = "power"       // As much as possible

    var displayName: String {
        switch self {
        case .casual: return "A few articles a week"
        case .regular: return "Something new every day"
        case .power: return "As much as possible"
        }
    }

    var icon: String {
        switch self {
        case .casual: return "leaf.fill"
        case .regular: return "calendar"
        case .power: return "flame.fill"
        }
    }
}
