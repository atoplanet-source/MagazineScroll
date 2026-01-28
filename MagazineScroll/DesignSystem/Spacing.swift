import SwiftUI

// MARK: - Spacing Constants

enum Spacing {
    // Base unit for calculations
    static let unit: CGFloat = 8

    // Standard spacing values
    static let xxs: CGFloat = unit * 0.5   // 4
    static let xs: CGFloat = unit          // 8
    static let sm: CGFloat = unit * 1.5    // 12
    static let md: CGFloat = unit * 2      // 16
    static let lg: CGFloat = unit * 3      // 24
    static let xl: CGFloat = unit * 4      // 32
    static let xxl: CGFloat = unit * 6     // 48

    // Slide padding
    static func horizontalPadding(for screenWidth: CGFloat) -> CGFloat {
        screenWidth * 0.06
    }

    // Home grid spacing
    static let gridSpacing: CGFloat = 16
    static let cardPadding: CGFloat = 20

    // Safe area insets
    static let safeAreaBottom: CGFloat = 34
}
