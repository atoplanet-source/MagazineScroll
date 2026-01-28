import Foundation

// MARK: - Story Model

struct Story: Codable, Identifiable, Sendable {
    let id: UUID
    let title: String
    let slug: String
    let description: String?
    let category: String?
    let thumbnailColor: String?  // Background color for card
    let tags: [String]?          // Sub-category tags for personalization
    var sections: [ContentBlock]

    init(
        id: UUID = UUID(),
        title: String,
        slug: String,
        description: String? = nil,
        category: String? = nil,
        thumbnailColor: String? = nil,
        tags: [String]? = nil,
        sections: [ContentBlock]
    ) {
        self.id = id
        self.title = title
        self.slug = slug
        self.description = description
        self.category = category
        self.thumbnailColor = thumbnailColor
        self.tags = tags
        self.sections = sections
    }

    // Legacy slides accessor for compatibility
    var slides: [ContentBlock] {
        get { sections }
        set { sections = newValue }
    }

    // Get first section's background color for card preview
    var previewBackgroundColor: String {
        thumbnailColor ?? sections.first?.backgroundColor ?? "#000000"
    }

    // Get title for card preview
    var previewText: String {
        title
    }
}
