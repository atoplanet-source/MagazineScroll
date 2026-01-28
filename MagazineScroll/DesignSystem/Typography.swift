import SwiftUI

// MARK: - Typography System

enum Typography {
    // Font names - Inter font family (18pt optical size)
    static let primaryFontName = "Inter18pt-Black"
    static let secondaryFontName = "Inter18pt-ExtraBold"

    // Primary font (Inter Black) for main content
    static func primaryFont(size: CGFloat) -> Font {
        .custom(primaryFontName, size: size)
    }

    // Secondary font (Inter ExtraBold) for labels
    static func secondaryFont(size: CGFloat) -> Font {
        .custom(secondaryFontName, size: size)
    }

    // System bold as fallback
    static func boldSystem(size: CGFloat) -> Font {
        .system(size: size, weight: .black)
    }

    // Dynamic font size calculation based on word count
    static func calculateFontSize(screenWidth: CGFloat, wordCount: Int) -> CGFloat {
        // Base size relative to screen width for better scaling
        let baseSize = screenWidth * 0.09

        let multiplier: CGFloat = switch wordCount {
        case 0...3: 1.5
        case 4...8: 1.2
        case 9...15: 1.0
        case 16...22: 0.85
        default: 0.7
        }

        return baseSize * multiplier
    }

    // Letter spacing for text
    static func letterSpacing(for wordCount: Int, screenWidth: CGFloat) -> CGFloat {
        wordCount <= 5 ? screenWidth * 0.005 : 0
    }

    // Line height multiplier
    static let lineHeightMultiplier: CGFloat = 1.1
}
