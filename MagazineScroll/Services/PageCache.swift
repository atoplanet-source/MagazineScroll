import Foundation
import UIKit

// MARK: - Page Cache (LRU with Memory Management)

/// Thread-safe LRU cache for article pages with automatic memory management.
/// Replaces the unbounded static dictionary in ArticleView.
final class PageCache {
    static let shared = PageCache()
    
    // MARK: - Configuration
    
    /// Maximum number of stories to keep in cache
    private let maxSize: Int = 20
    
    /// Lock for thread safety
    private let lock = NSLock()
    
    /// Storage: UUID -> (pages, accessOrder)
    private var cache: [UUID: [PageContent]] = [:]
    
    /// LRU tracking: most recently accessed at end
    private var accessOrder: [UUID] = []
    
    // MARK: - Init
    
    private init() {
        // Listen for memory warnings
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemoryWarning),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public API
    
    /// Get cached pages for a story
    func get(_ storyId: UUID) -> [PageContent]? {
        lock.lock()
        defer { lock.unlock() }
        
        guard let pages = cache[storyId] else { return nil }
        
        // Update access order (move to end = most recent)
        if let index = accessOrder.firstIndex(of: storyId) {
            accessOrder.remove(at: index)
            accessOrder.append(storyId)
        }
        
        return pages
    }
    
    /// Store pages for a story
    func set(_ storyId: UUID, pages: [PageContent]) {
        lock.lock()
        defer { lock.unlock() }
        
        // If already cached, just update
        if cache[storyId] != nil {
            cache[storyId] = pages
            // Update access order
            if let index = accessOrder.firstIndex(of: storyId) {
                accessOrder.remove(at: index)
                accessOrder.append(storyId)
            }
            return
        }
        
        // Evict oldest if at capacity
        while cache.count >= maxSize, let oldest = accessOrder.first {
            accessOrder.removeFirst()
            cache.removeValue(forKey: oldest)
        }
        
        // Insert new entry
        cache[storyId] = pages
        accessOrder.append(storyId)
    }
    
    /// Check if story is cached
    func contains(_ storyId: UUID) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return cache[storyId] != nil
    }
    
    /// Pre-warm cache for adjacent stories (call from background thread)
    func prewarm(storyIds: [UUID], calculator: (UUID) -> [PageContent]?) {
        for id in storyIds {
            // Skip if already cached
            lock.lock()
            let alreadyCached = cache[id] != nil
            lock.unlock()
            
            if alreadyCached { continue }
            
            // Calculate and cache
            if let pages = calculator(id) {
                set(id, pages: pages)
            }
        }
    }
    
    /// Clear entire cache
    func clear() {
        lock.lock()
        defer { lock.unlock() }
        cache.removeAll()
        accessOrder.removeAll()
    }
    
    /// Current cache size
    var count: Int {
        lock.lock()
        defer { lock.unlock() }
        return cache.count
    }
    
    // MARK: - Memory Management
    
    @objc private func handleMemoryWarning() {
        // Clear half the cache on memory warning
        lock.lock()
        defer { lock.unlock() }
        
        let removeCount = cache.count / 2
        for _ in 0..<removeCount {
            if let oldest = accessOrder.first {
                accessOrder.removeFirst()
                cache.removeValue(forKey: oldest)
            }
        }
        
        print("⚠️ PageCache: Memory warning - evicted \(removeCount) entries, \(cache.count) remaining")
    }
}

// MARK: - Debug Helpers

#if DEBUG
extension PageCache {
    /// Debug description of cache state
    var debugDescription: String {
        lock.lock()
        defer { lock.unlock() }
        return "PageCache: \(cache.count)/\(maxSize) entries"
    }
}
#endif
