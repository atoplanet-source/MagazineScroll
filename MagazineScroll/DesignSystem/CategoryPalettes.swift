import SwiftUI

// MARK: - Category Palette System

/// Provides vibrant rainbow color palettes for each story category.
/// Each category has a primary color (title page), title text color, and
/// a rainbow palette of 7-8 colors that cycle through content pages.

enum CategoryPalettes {

    // MARK: - Palette Struct

    struct Palette {
        let primary: String           // Title page background
        let titleText: String         // Title page text
        let contentColors: [(bg: String, text: String)]  // Rainbow colors for pages

        func pageColor(at index: Int) -> (bg: String, text: String) {
            return contentColors[index % contentColors.count]
        }
    }

    // MARK: - Get Palette for Category

    static func palette(for category: String?) -> Palette {
        switch category {
        case "Economics":
            return economicsPalette
        case "Ancient World":
            return ancientWorldPalette
        case "Medieval":
            return medievalPalette
        case "20th Century":
            return twentiethCenturyPalette
        case "19th Century":
            return nineteenthCenturyPalette
        case "Science":
            return sciencePalette
        case "Art":
            return artPalette
        case "Crime":
            return crimePalette
        case "Exploration":
            return explorationPalette
        case "War":
            return warPalette
        default:
            return defaultPalette
        }
    }

    // MARK: - Category Palettes

    // Economics: Rich Blue primary with pink/purple/cyan rainbow
    static let economicsPalette = Palette(
        primary: "#2E5090",
        titleText: "#FFD60A",
        contentColors: [
            ("#D81B60", "#FFFFFF"),  // Pink
            ("#7E57C2", "#FFFFFF"),  // Purple
            ("#00ACC1", "#FFFFFF"),  // Cyan
            ("#43A047", "#FFFFFF"),  // Green
            ("#FFB300", "#000000"),  // Gold
            ("#F4511E", "#FFFFFF"),  // Orange
            ("#1E88E5", "#FFFFFF"),  // Blue
        ]
    )

    // Ancient World: Terracotta primary with purple/teal/amber rainbow
    static let ancientWorldPalette = Palette(
        primary: "#C45B28",
        titleText: "#FFFFFF",
        contentColors: [
            ("#7E57C2", "#FFFFFF"),  // Purple
            ("#00897B", "#FFFFFF"),  // Teal
            ("#FFB300", "#000000"),  // Amber
            ("#EC407A", "#FFFFFF"),  // Pink
            ("#5C6BC0", "#FFFFFF"),  // Indigo
            ("#43A047", "#FFFFFF"),  // Green
            ("#FF7043", "#FFFFFF"),  // Orange
        ]
    )

    // Medieval: Royal Purple primary with cyan/red/green rainbow
    static let medievalPalette = Palette(
        primary: "#6B4C9A",
        titleText: "#FFD60A",
        contentColors: [
            ("#00ACC1", "#FFFFFF"),  // Cyan
            ("#E53935", "#FFFFFF"),  // Red
            ("#43A047", "#FFFFFF"),  // Green
            ("#FF9800", "#000000"),  // Orange
            ("#1E88E5", "#FFFFFF"),  // Blue
            ("#EC407A", "#FFFFFF"),  // Pink
            ("#FFEE58", "#000000"),  // Yellow
        ]
    )

    // 20th Century: Forest Green primary with purple/red/blue rainbow
    static let twentiethCenturyPalette = Palette(
        primary: "#2D6A4F",
        titleText: "#00D9FF",
        contentColors: [
            ("#8E24AA", "#FFFFFF"),  // Purple
            ("#E53935", "#FFFFFF"),  // Red
            ("#1E88E5", "#FFFFFF"),  // Blue
            ("#FFB300", "#000000"),  // Amber
            ("#00897B", "#FFFFFF"),  // Teal
            ("#FF7043", "#FFFFFF"),  // Orange
            ("#5C6BC0", "#FFFFFF"),  // Indigo
        ]
    )

    // 19th Century: Saddle Brown primary with purple/cyan/green rainbow
    static let nineteenthCenturyPalette = Palette(
        primary: "#8B5A2B",
        titleText: "#FFFFFF",
        contentColors: [
            ("#7E57C2", "#FFFFFF"),  // Purple
            ("#00ACC1", "#FFFFFF"),  // Cyan
            ("#43A047", "#FFFFFF"),  // Green
            ("#FF9800", "#000000"),  // Orange
            ("#EC407A", "#FFFFFF"),  // Pink
            ("#1E88E5", "#FFFFFF"),  // Blue
            ("#FFEE58", "#000000"),  // Yellow
        ]
    )

    // Science: Bright Blue primary with purple/teal/orange rainbow
    static let sciencePalette = Palette(
        primary: "#1976D2",
        titleText: "#00D9FF",
        contentColors: [
            ("#8E24AA", "#FFFFFF"),  // Purple
            ("#00897B", "#FFFFFF"),  // Teal
            ("#FF7043", "#FFFFFF"),  // Orange
            ("#7CB342", "#000000"),  // Lime
            ("#EC407A", "#FFFFFF"),  // Pink
            ("#FFB300", "#000000"),  // Amber
            ("#00ACC1", "#FFFFFF"),  // Cyan
        ]
    )

    // Art: Crimson primary with purple/blue/green rainbow
    static let artPalette = Palette(
        primary: "#B33951",
        titleText: "#FFFFFF",
        contentColors: [
            ("#7E57C2", "#FFFFFF"),  // Purple
            ("#29B6F6", "#000000"),  // Light Blue
            ("#66BB6A", "#000000"),  // Green
            ("#FFA000", "#000000"),  // Amber
            ("#00ACC1", "#FFFFFF"),  // Cyan
            ("#FFD740", "#000000"),  // Yellow
            ("#5C6BC0", "#FFFFFF"),  // Indigo
        ]
    )

    // Crime: Dark Brown primary with red/purple/cyan rainbow
    static let crimePalette = Palette(
        primary: "#5D4037",
        titleText: "#FF5252",
        contentColors: [
            ("#E53935", "#FFFFFF"),  // Red
            ("#8E24AA", "#FFFFFF"),  // Purple
            ("#00ACC1", "#FFFFFF"),  // Cyan
            ("#FFEE58", "#000000"),  // Yellow
            ("#43A047", "#FFFFFF"),  // Green
            ("#FF9800", "#000000"),  // Orange
            ("#5C6BC0", "#FFFFFF"),  // Indigo
        ]
    )

    // Exploration: Dark Teal primary with blue/pink/green rainbow
    static let explorationPalette = Palette(
        primary: "#00695C",
        titleText: "#FFFFFF",
        contentColors: [
            ("#1E88E5", "#FFFFFF"),  // Blue
            ("#EC407A", "#FFFFFF"),  // Pink
            ("#7CB342", "#000000"),  // Green
            ("#FFB300", "#000000"),  // Amber
            ("#8E24AA", "#FFFFFF"),  // Purple
            ("#00ACC1", "#FFFFFF"),  // Cyan
            ("#FF7043", "#FFFFFF"),  // Orange
        ]
    )

    // War: Muted Brown primary with red/purple/teal rainbow
    static let warPalette = Palette(
        primary: "#8D6E63",
        titleText: "#FFFFFF",
        contentColors: [
            ("#E53935", "#FFFFFF"),  // Red
            ("#7E57C2", "#FFFFFF"),  // Purple
            ("#00897B", "#FFFFFF"),  // Teal
            ("#FF9800", "#000000"),  // Orange
            ("#1E88E5", "#FFFFFF"),  // Blue
            ("#7CB342", "#000000"),  // Lime
            ("#EC407A", "#FFFFFF"),  // Pink
        ]
    )

    // Default palette for unknown categories
    static let defaultPalette = Palette(
        primary: "#37474F",
        titleText: "#FFFFFF",
        contentColors: [
            ("#7E57C2", "#FFFFFF"),  // Purple
            ("#00ACC1", "#FFFFFF"),  // Cyan
            ("#43A047", "#FFFFFF"),  // Green
            ("#FF9800", "#000000"),  // Orange
            ("#EC407A", "#FFFFFF"),  // Pink
            ("#1E88E5", "#FFFFFF"),  // Blue
            ("#FFEE58", "#000000"),  // Yellow
        ]
    )
}
