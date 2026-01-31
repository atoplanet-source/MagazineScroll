import Foundation

// MARK: - Identifiable String Wrapper

/// A proper Identifiable wrapper for strings, replacing the fragile
/// `extension String: @retroactive Identifiable` hack.
///
/// Use this for SwiftUI sheet/fullScreenCover presentation with string identifiers.
struct IdentifiableString: Identifiable {
    let id: String
    let value: String
    
    init(_ value: String) {
        self.id = value
        self.value = value
    }
}

// MARK: - Convenience Extensions

extension IdentifiableString: Equatable {
    static func == (lhs: IdentifiableString, rhs: IdentifiableString) -> Bool {
        lhs.value == rhs.value
    }
}

extension IdentifiableString: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

extension IdentifiableString: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.init(value)
    }
}
