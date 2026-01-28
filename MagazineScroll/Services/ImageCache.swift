import SwiftUI

// MARK: - Image Cache

actor ImageCache {
    static let shared = ImageCache()

    private var cache: [String: Image] = [:]
    private let maxCacheSize = 50

    private init() {}

    func image(for url: String) -> Image? {
        cache[url]
    }

    func setImage(_ image: Image, for url: String) {
        // Simple LRU-like behavior: clear cache if too large
        if cache.count >= maxCacheSize {
            // Remove half the cached images (oldest)
            let keysToRemove = Array(cache.keys.prefix(maxCacheSize / 2))
            for key in keysToRemove {
                cache.removeValue(forKey: key)
            }
        }
        cache[url] = image
    }

    func clearCache() {
        cache.removeAll()
    }
}
