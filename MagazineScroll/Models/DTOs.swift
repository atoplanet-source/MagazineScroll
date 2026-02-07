import Foundation

// MARK: - Database Response Models

struct StoryDTO: Codable, Sendable {
    let id: UUID
    let slug: String
    let title: String
    let description: String?
    let category: String?
    let thumbnailColor: String?
    let published: Bool
    let bodyText: String?
    let designConfig: DesignConfigDTO?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, slug, title, description, category, published
        case thumbnailColor = "thumbnail_color"
        case bodyText = "body_text"
        case designConfig = "design_config"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    func toStory() -> Story {
        let sections: [ContentBlock]
        if let text = bodyText, !text.isEmpty {
            sections = [ContentBlock(
                position: 0,
                blockType: .text,
                textContent: text,
                textColor: "#FFFFFF",
                backgroundColor: thumbnailColor ?? "#000000"
            )]
        } else {
            sections = []
        }

        return Story(
            id: id,
            title: title,
            slug: slug,
            description: description,
            category: category,
            thumbnailColor: thumbnailColor,
            sections: sections
        )
    }
}

struct DesignConfigDTO: Codable, Sendable {
    let thumbnailColor: String?
    let titlePage: TitlePageConfig?
    let colorPalette: [ColorPair]?
    let imagePlaceholderColors: [String]?
    let imageAspectRatios: [Double]?
    let imagePositionSeed: Int?
    let imageColorOffset: Int?

    struct TitlePageConfig: Codable, Sendable {
        let backgroundColor: String?
        let textColor: String?
    }

    struct ColorPair: Codable, Sendable {
        let background: String
        let text: String
    }
}

struct CuratedFeedDTO: Codable, Sendable {
    let id: UUID
    let date: String
    let title: String?
    let storyIds: [String]
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, date, title
        case storyIds = "story_ids"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct StoryImageDTO: Codable, Sendable {
    let id: UUID
    let storyId: UUID
    let filename: String
    let publicUrl: String?
    let position: Int?

    enum CodingKeys: String, CodingKey {
        case id, filename, position
        case storyId = "story_id"
        case publicUrl = "public_url"
    }
}
