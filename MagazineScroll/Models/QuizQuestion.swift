import Foundation

// MARK: - Quiz Question Model

/// Represents a single question in the onboarding quiz
struct QuizQuestion: Identifiable {
    let id: Int
    let type: QuestionType
    let question: String
    let options: [QuizOption]
    let minimumSelections: Int  // For multi-select

    init(id: Int, type: QuestionType, question: String, options: [QuizOption], minimumSelections: Int = 1) {
        self.id = id
        self.type = type
        self.question = question
        self.options = options
        self.minimumSelections = minimumSelections
    }
}

enum QuestionType {
    case categoryGrid      // Multi-select grid (Q1)
    case comparison        // A vs B dual cards (Q2, Q4, Q6, Q7)
    case singleChoice      // Single selection (Q3, Q5, Q8)
}

struct QuizOption: Identifiable {
    let id: String
    let label: String
    let description: String?
    let icon: String?
    let color: String?       // For category grid
    let categories: [String]? // Categories this option maps to
    let tags: [String]?      // Sub-category tags for personalization

    init(id: String, label: String, description: String? = nil, icon: String? = nil, color: String? = nil, categories: [String]? = nil, tags: [String]? = nil) {
        self.id = id
        self.label = label
        self.description = description
        self.icon = icon
        self.color = color
        self.categories = categories
        self.tags = tags
    }
}

// MARK: - Quiz Questions Data

enum QuizQuestions {

    static let allQuestions: [QuizQuestion] = [
        question1,
        question2,
        question3,
        question4a,
        question4b,
        question4c,
        question5,
        question6,
        question7,
        question8
    ]

    // Q1: Category Selection (Multi-Select Grid)
    static let question1 = QuizQuestion(
        id: 1,
        type: .categoryGrid,
        question: "What topics interest you?",
        options: [
            QuizOption(id: "economics", label: "Economics", color: "#2E5090", categories: ["Economics"]),
            QuizOption(id: "ancient", label: "Ancient World", color: "#C45B28", categories: ["Ancient World"]),
            QuizOption(id: "medieval", label: "Medieval", color: "#6B4C9A", categories: ["Medieval"]),
            QuizOption(id: "20th", label: "20th Century", color: "#2D6A4F", categories: ["20th Century"]),
            QuizOption(id: "19th", label: "19th Century", color: "#8B5A2B", categories: ["19th Century"]),
            QuizOption(id: "science", label: "Science", color: "#1976D2", categories: ["Science"]),
            QuizOption(id: "art", label: "Art", color: "#B33951", categories: ["Art"]),
            QuizOption(id: "crime", label: "Crime", color: "#5D4037", categories: ["Crime"]),
            QuizOption(id: "exploration", label: "Exploration", color: "#00695C", categories: ["Exploration"]),
            QuizOption(id: "war", label: "War", color: "#8D6E63", categories: ["War"])
        ],
        minimumSelections: 3
    )

    // Q2: Era Preference (3 Options)
    static let question2 = QuizQuestion(
        id: 2,
        type: .singleChoice,
        question: "Which draws you in?",
        options: [
            QuizOption(
                id: "ancient",
                label: "Ancient mysteries",
                description: "Lost civilizations and forgotten empires",
                icon: "building.columns.fill",
                color: "#C45B28",
                categories: ["Ancient World", "Medieval"]
            ),
            QuizOption(
                id: "both",
                label: "Both/All eras",
                description: "History from every time period",
                icon: "clock.fill",
                color: "#6B7280",
                categories: nil
            ),
            QuizOption(
                id: "modern",
                label: "Modern history",
                description: "Recent discoveries and transformations",
                icon: "sparkles",
                color: "#2D6A4F",
                categories: ["19th Century", "20th Century", "Science"]
            )
        ]
    )

    // Q3: Content Tone (2 Options)
    static let question3 = QuizQuestion(
        id: 3,
        type: .singleChoice,
        question: "What's your vibe?",
        options: [
            QuizOption(id: "serious", label: "Serious & scholarly", description: "Formal, academic tone", icon: "text.book.closed.fill"),
            QuizOption(id: "fun", label: "Fun & surprising", description: "Lighter, entertaining tone", icon: "party.popper.fill")
        ]
    )

    // Q4a: Economics vs Art (Comparison)
    static let question4a = QuizQuestion(
        id: 4,
        type: .comparison,
        question: "Choose your curiosity...",
        options: [
            QuizOption(
                id: "economics",
                label: "Money & Power",
                description: "How money shapes the world",
                icon: "chart.line.uptrend.xyaxis",
                color: "#2E5090",
                categories: ["Economics"]
            ),
            QuizOption(
                id: "art",
                label: "Art & Culture",
                description: "How art shapes the soul",
                icon: "paintpalette.fill",
                color: "#B33951",
                categories: ["Art"]
            )
        ]
    )

    // Q4b: Medieval vs 20th Century (Comparison)
    static let question4b = QuizQuestion(
        id: 5,
        type: .comparison,
        question: "Which era calls to you?",
        options: [
            QuizOption(
                id: "medieval",
                label: "Knights & castles",
                description: "The age of chivalry and conquest",
                icon: "shield.lefthalf.filled",
                color: "#6B4C9A",
                categories: ["Medieval"]
            ),
            QuizOption(
                id: "20th",
                label: "World wars & revolutions",
                description: "The century that shaped today",
                icon: "globe.americas.fill",
                color: "#2D6A4F",
                categories: ["20th Century"]
            )
        ]
    )

    // Q4c: Ancient World vs 19th Century (Comparison)
    static let question4c = QuizQuestion(
        id: 6,
        type: .comparison,
        question: "Pick your time...",
        options: [
            QuizOption(
                id: "ancient",
                label: "Pharaohs & empires",
                description: "Where civilization began",
                icon: "building.columns.fill",
                color: "#C45B28",
                categories: ["Ancient World"]
            ),
            QuizOption(
                id: "19th",
                label: "Industrial revolution",
                description: "Steam, steel, and progress",
                icon: "gearshape.2.fill",
                color: "#8B5A2B",
                categories: ["19th Century"]
            )
        ]
    )

    // Q5: Discovery Mode (2 Options)
    static let question5 = QuizQuestion(
        id: 7,
        type: .singleChoice,
        question: "When exploring new topics...",
        options: [
            QuizOption(id: "comfort", label: "Stay in my comfort zone", description: "More of what I love", icon: "heart.fill"),
            QuizOption(id: "surprise", label: "Surprise me often", description: "Push my boundaries", icon: "sparkles")
        ]
    )

    // Q6: Exploration vs War (Comparison)
    static let question6 = QuizQuestion(
        id: 8,
        type: .comparison,
        question: "Pick your adventure...",
        options: [
            QuizOption(
                id: "exploration",
                label: "Expeditions",
                description: "Journeys to unknown lands",
                icon: "map.fill",
                color: "#00695C",
                categories: ["Exploration"]
            ),
            QuizOption(
                id: "war",
                label: "Conflict & Courage",
                description: "Tales of battles and bravery",
                icon: "shield.fill",
                color: "#8D6E63",
                categories: ["War"]
            )
        ]
    )

    // Q7: Crime vs Science (Comparison)
    static let question7 = QuizQuestion(
        id: 9,
        type: .comparison,
        question: "What pulls you in?",
        options: [
            QuizOption(
                id: "crime",
                label: "Mysteries & Crime",
                description: "Unsolved cases and true crime",
                icon: "magnifyingglass",
                color: "#5D4037",
                categories: ["Crime"]
            ),
            QuizOption(
                id: "science",
                label: "Scientific Discovery",
                description: "Breakthroughs that changed the world",
                icon: "atom",
                color: "#1976D2",
                categories: ["Science"]
            )
        ]
    )

    // Q8: Reading Goal (3 Options)
    static let question8 = QuizQuestion(
        id: 10,
        type: .singleChoice,
        question: "What's your reading goal?",
        options: [
            QuizOption(id: "casual", label: "A few articles a week", description: "Leisurely pace", icon: "leaf.fill"),
            QuizOption(id: "regular", label: "Something new every day", description: "Daily habit", icon: "calendar"),
            QuizOption(id: "power", label: "As much as possible", description: "Knowledge hungry", icon: "flame.fill")
        ]
    )

    // MARK: - Category Follow-up Questions (Q101-Q110)
    // These are shown based on categories selected in Q1

    // Q101: Art follow-up
    static let artFollowUp = QuizQuestion(
        id: 101,
        type: .categoryGrid,
        question: "What art topics interest you most?",
        options: [
            QuizOption(id: "art-masters", label: "Renaissance Masters", color: "#6A1B9A", tags: ["renaissance", "famous-artists", "painting"]),
            QuizOption(id: "art-modern", label: "Modern & Contemporary", color: "#E63946", tags: ["modern", "design"]),
            QuizOption(id: "art-architecture", label: "Architecture & Sculpture", color: "#1976D2", tags: ["sculpture", "architecture"]),
            QuizOption(id: "art-crime", label: "Art Heists & Forgeries", color: "#5D4037", tags: ["art-heists", "forgeries"]),
            QuizOption(id: "art-film", label: "Film & Photography", color: "#212121", tags: ["film", "photography"]),
            QuizOption(id: "art-lost", label: "Lost & Destroyed Works", color: "#FF8F00", tags: ["lost-works"])
        ],
        minimumSelections: 1
    )

    // Q102: Crime follow-up
    static let crimeFollowUp = QuizQuestion(
        id: 102,
        type: .categoryGrid,
        question: "What crime stories draw you in?",
        options: [
            QuizOption(id: "crime-heists", label: "Heists & Thefts", color: "#5D4037", tags: ["heists"]),
            QuizOption(id: "crime-unsolved", label: "Unsolved Mysteries", color: "#37474F", tags: ["unsolved", "cold-cases"]),
            QuizOption(id: "crime-serial", label: "Serial Killers", color: "#B71C1C", tags: ["serial-killers"]),
            QuizOption(id: "crime-spy", label: "Spies & Espionage", color: "#1A237E", tags: ["espionage"]),
            QuizOption(id: "crime-fraud", label: "Fraud & Cons", color: "#4A148C", tags: ["fraud", "organized-crime"]),
            QuizOption(id: "crime-trials", label: "Famous Trials", color: "#212121", tags: ["trials"])
        ],
        minimumSelections: 1
    )

    // Q103: Economics follow-up
    static let economicsFollowUp = QuizQuestion(
        id: 103,
        type: .categoryGrid,
        question: "What economic stories fascinate you?",
        options: [
            QuizOption(id: "econ-crashes", label: "Crashes & Bubbles", color: "#B71C1C", tags: ["crashes", "bubbles"]),
            QuizOption(id: "econ-trade", label: "Trade & Commerce", color: "#2E5090", tags: ["trade", "corporations"]),
            QuizOption(id: "econ-currency", label: "Money & Currency", color: "#FFB800", tags: ["currency", "banking"]),
            QuizOption(id: "econ-markets", label: "Markets & Speculation", color: "#1B5E20", tags: ["markets", "inflation"])
        ],
        minimumSelections: 1
    )

    // Q104: Science follow-up
    static let scienceFollowUp = QuizQuestion(
        id: 104,
        type: .categoryGrid,
        question: "What scientific topics excite you?",
        options: [
            QuizOption(id: "sci-physics", label: "Physics & Chemistry", color: "#1976D2", tags: ["physics", "chemistry"]),
            QuizOption(id: "sci-medicine", label: "Medicine & Biology", color: "#C62828", tags: ["medicine", "biology"]),
            QuizOption(id: "sci-space", label: "Space & Astronomy", color: "#0D47A1", tags: ["space", "discoveries"]),
            QuizOption(id: "sci-inventions", label: "Inventions & Discoveries", color: "#2E7D32", tags: ["inventions", "discoveries"]),
            QuizOption(id: "sci-expeditions", label: "Scientific Expeditions", color: "#00695C", tags: ["expeditions"])
        ],
        minimumSelections: 1
    )

    // Q105: War follow-up
    static let warFollowUp = QuizQuestion(
        id: 105,
        type: .categoryGrid,
        question: "What military history interests you?",
        options: [
            QuizOption(id: "war-battles", label: "Famous Battles", color: "#B71C1C", tags: ["battles", "strategy"]),
            QuizOption(id: "war-generals", label: "Great Commanders", color: "#8D6E63", tags: ["generals"]),
            QuizOption(id: "war-naval", label: "Naval Warfare", color: "#0D47A1", tags: ["naval"]),
            QuizOption(id: "war-air", label: "Air Combat", color: "#37474F", tags: ["air-combat"]),
            QuizOption(id: "war-resistance", label: "Resistance & Espionage", color: "#5D4037", tags: ["resistance"]),
            QuizOption(id: "war-sieges", label: "Sieges & Fortifications", color: "#6A1B9A", tags: ["sieges"])
        ],
        minimumSelections: 1
    )

    // Q106: Exploration follow-up
    static let explorationFollowUp = QuizQuestion(
        id: 106,
        type: .categoryGrid,
        question: "What exploration stories call to you?",
        options: [
            QuizOption(id: "exp-arctic", label: "Polar Expeditions", color: "#5C6BC0", tags: ["arctic", "survival"]),
            QuizOption(id: "exp-ocean", label: "Ocean Depths", color: "#0D47A1", tags: ["ocean"]),
            QuizOption(id: "exp-space", label: "Space Exploration", color: "#14213D", tags: ["space"]),
            QuizOption(id: "exp-lost", label: "Lost Cities & Archaeology", color: "#FF8F00", tags: ["lost-cities", "mapping"]),
            QuizOption(id: "exp-mountains", label: "Mountain Expeditions", color: "#5D4037", tags: ["mountaineering", "survival"])
        ],
        minimumSelections: 1
    )

    // Q107: Ancient World follow-up
    static let ancientFollowUp = QuizQuestion(
        id: 107,
        type: .categoryGrid,
        question: "Which ancient civilizations intrigue you?",
        options: [
            QuizOption(id: "anc-rome", label: "Rome & Carthage", color: "#B71C1C", tags: ["rome", "empires"]),
            QuizOption(id: "anc-greece", label: "Greece & Mythology", color: "#1565C0", tags: ["greece", "mythology"]),
            QuizOption(id: "anc-egypt", label: "Egypt & Pyramids", color: "#FF8F00", tags: ["egypt", "archaeology"]),
            QuizOption(id: "anc-meso", label: "Mesopotamia & Beyond", color: "#5D4037", tags: ["mesopotamia"]),
            QuizOption(id: "anc-disasters", label: "Ancient Disasters", color: "#E76F51", tags: ["disasters"])
        ],
        minimumSelections: 1
    )

    // Q108: Medieval follow-up
    static let medievalFollowUp = QuizQuestion(
        id: 108,
        type: .categoryGrid,
        question: "What medieval topics draw you in?",
        options: [
            QuizOption(id: "med-crusades", label: "Crusades & Holy Wars", color: "#1565C0", tags: ["crusades", "religion"]),
            QuizOption(id: "med-castles", label: "Castles & Knights", color: "#6B4C9A", tags: ["castles", "knights"]),
            QuizOption(id: "med-plague", label: "Plague & Disasters", color: "#212121", tags: ["plague"]),
            QuizOption(id: "med-monarchy", label: "Kings & Queens", color: "#FFB800", tags: ["monarchy"]),
            QuizOption(id: "med-byzantium", label: "Byzantium & Vikings", color: "#6A1B9A", tags: ["byzantium", "vikings"])
        ],
        minimumSelections: 1
    )

    // Q109: 19th Century follow-up
    static let nineteenthFollowUp = QuizQuestion(
        id: 109,
        type: .categoryGrid,
        question: "What 19th century stories interest you?",
        options: [
            QuizOption(id: "19-industrial", label: "Industrial Revolution", color: "#3E2723", tags: ["industrial", "inventions"]),
            QuizOption(id: "19-colonial", label: "Colonial Era", color: "#8B5A2B", tags: ["colonial"]),
            QuizOption(id: "19-victorian", label: "Victorian Age", color: "#6A1B9A", tags: ["victorian"]),
            QuizOption(id: "19-disasters", label: "Disasters & Catastrophes", color: "#D84315", tags: ["disasters"]),
            QuizOption(id: "19-revolution", label: "Revolutions & Upheaval", color: "#B71C1C", tags: ["revolution"])
        ],
        minimumSelections: 1
    )

    // Q110: 20th Century follow-up
    static let twentiethFollowUp = QuizQuestion(
        id: 110,
        type: .categoryGrid,
        question: "What 20th century topics fascinate you?",
        options: [
            QuizOption(id: "20-wwi", label: "World War I", color: "#5D4037", tags: ["wwi"]),
            QuizOption(id: "20-wwii", label: "World War II", color: "#B71C1C", tags: ["wwii"]),
            QuizOption(id: "20-coldwar", label: "Cold War Era", color: "#37474F", tags: ["cold-war"]),
            QuizOption(id: "20-space", label: "Space Race", color: "#0D47A1", tags: ["space-race", "technology"]),
            QuizOption(id: "20-disasters", label: "Disasters & Mysteries", color: "#212121", tags: ["disasters", "mysteries"]),
            QuizOption(id: "20-civil", label: "Civil Rights & Change", color: "#2D6A4F", tags: ["civil-rights"])
        ],
        minimumSelections: 1
    )

    // Map category IDs to their follow-up questions
    static let categoryFollowUps: [String: QuizQuestion] = [
        "art": artFollowUp,
        "crime": crimeFollowUp,
        "economics": economicsFollowUp,
        "science": scienceFollowUp,
        "war": warFollowUp,
        "exploration": explorationFollowUp,
        "ancient": ancientFollowUp,
        "medieval": medievalFollowUp,
        "19th": nineteenthFollowUp,
        "20th": twentiethFollowUp
    ]
}
