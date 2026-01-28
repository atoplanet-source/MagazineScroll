import SwiftUI

// MARK: - Color Extension for Hex Support

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: 1)
    }
}

// MARK: - Magazine Color Palette

enum MagazineColors {
    // Bold Colors
    static let red = Color(hex: "#E63946")
    static let blue = Color(hex: "#1D3557")
    static let green = Color(hex: "#2D6A4F")
    static let orange = Color(hex: "#E76F51")
    static let purple = Color(hex: "#7209B7")

    // Neutral Colors
    static let black = Color(hex: "#0D0D0D")
    static let white = Color(hex: "#FAFAFA")
    static let warmGray = Color(hex: "#8D8D8D")
    static let coolGray = Color(hex: "#6C757D")

    // Earthy Colors
    static let brown = Color(hex: "#6F4E37")
    static let forest = Color(hex: "#1B4332")
    static let navy = Color(hex: "#14213D")

    // Text Colors
    static let textOnDark = Color.white
    static let textOnLight = Color(hex: "#0D0D0D")

    // Helper to determine if a color is light or dark
    static func isLightColor(hex: String) -> Bool {
        let cleanHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF)
        let g = Double((int >> 8) & 0xFF)
        let b = Double(int & 0xFF)
        let luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255
        return luminance > 0.5
    }

    static func textColor(for backgroundColor: String) -> Color {
        isLightColor(hex: backgroundColor) ? textOnLight : textOnDark
    }

    // Returns a contrasting color for readability
    static func contrastColor(for hex: String) -> Color {
        isLightColor(hex: hex) ? .black : .white
    }

    // Get RGB components from hex
    static func rgbComponents(from hex: String) -> (r: Double, g: Double, b: Double)? {
        let cleanHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&int)
        guard cleanHex.count == 6 else { return nil }
        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0
        return (r, g, b)
    }
}
