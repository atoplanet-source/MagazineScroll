import Foundation

// MARK: - Content Block Type

enum ContentBlockType: String, Codable, Sendable {
    case title           // Title section with decorative font
    case text            // Text-only section
    case image           // Image-only section
    case textWithImage   // Text followed by image
    case imageWithText   // Image followed by text
}

// MARK: - Image Style

enum ImageStyle: String, Codable, Sendable {
    case framed      // Image with border/frame
    case editorial   // Smaller, editorial placement
    case full        // Full width (no padding)
}

// MARK: - Content Block Model

struct ContentBlock: Codable, Identifiable, Sendable {
    let id: UUID
    let position: Int
    let blockType: ContentBlockType
    let title: String?           // For title sections
    let textContent: String?
    let textColor: String        // Hex color for text
    let accentColor: String?     // Optional accent color for highlighted words
    let imageName: String?       // Local image name
    let imageUrl: String?        // Remote image URL
    let imageStyle: ImageStyle?
    let backgroundColor: String  // Hex color

    init(
        id: UUID = UUID(),
        position: Int,
        blockType: ContentBlockType,
        title: String? = nil,
        textContent: String? = nil,
        textColor: String = "#000000",
        accentColor: String? = nil,
        imageName: String? = nil,
        imageUrl: String? = nil,
        imageStyle: ImageStyle? = nil,
        backgroundColor: String = "#FFFFFF"
    ) {
        self.id = id
        self.position = position
        self.blockType = blockType
        self.title = title
        self.textContent = textContent
        self.textColor = textColor
        self.accentColor = accentColor
        self.imageName = imageName
        self.imageUrl = imageUrl
        self.imageStyle = imageStyle
        self.backgroundColor = backgroundColor
    }
}

// MARK: - Legacy type aliases

typealias Slide = ContentBlock
typealias Section = ContentBlock
typealias SectionType = ContentBlockType

// MARK: - Legacy enums for compatibility

enum SlideType: String, Codable, Sendable {
    case textOnly = "text_only"
    case imageOnly = "image_only"
    case textWithImage = "text_with_image"
}

enum ImageLayout: String, Codable, Sendable {
    case fullBleed = "full_bleed"
    case editorial = "editorial"
    case inset = "inset"
}

// MARK: - Safe Collection Access

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
