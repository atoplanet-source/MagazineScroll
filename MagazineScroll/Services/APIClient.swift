import Foundation
import Supabase

// MARK: - API Client

actor APIClient {
    static let shared = APIClient()

    private init() {}

    // Fetch all stories from Supabase
    func fetchStories() async -> [Story] {
        do {
            let response: [StoryDTO] = try await supabase
                .from("stories")
                .select()
                .eq("published", value: true)
                .order("created_at", ascending: false)
                .execute()
                .value

            let stories = response.map { dto in
                dto.toStory()
            }

            print("✅ Loaded \(stories.count) stories from Supabase")
            return stories
        } catch {
            print("❌ Supabase error: \(error.localizedDescription)")
            return []
        }
    }

    // Fetch a single story by ID
    func fetchStory(id: UUID) async -> Story? {
        do {
            let response: [StoryDTO] = try await supabase
                .from("stories")
                .select()
                .eq("id", value: id.uuidString)
                .limit(1)
                .execute()
                .value

            return response.first?.toStory()
        } catch {
            print("❌ Error fetching story by ID: \(error.localizedDescription)")
            return nil
        }
    }

    // Fetch a single story by slug
    func fetchStory(slug: String) async -> Story? {
        do {
            let response: [StoryDTO] = try await supabase
                .from("stories")
                .select()
                .eq("slug", value: slug)
                .limit(1)
                .execute()
                .value

            return response.first?.toStory()
        } catch {
            print("❌ Error fetching story by slug: \(error.localizedDescription)")
            return nil
        }
    }

    // Fetch curated feed for a specific date
    func fetchCuratedFeed(for date: Date = Date()) async -> [Story]? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        print("📰 Fetching curated feed for date: \(dateString)")
        
        do {
            // First get the curated feed entry for the date
            let response: [CuratedFeedDTO] = try await supabase
                .from("curated_feeds")
                .select()
                .eq("date", value: dateString)
                .limit(1)
                .execute()
                .value
            
            print("📰 Curated feeds response count: \(response.count)")
            
            guard let feed = response.first else {
                print("📰 No curated feed entry for \(dateString)")
                return nil
            }
            
            print("📰 Found feed with \(feed.storyIds.count) story IDs: \(feed.storyIds)")
            
            guard !feed.storyIds.isEmpty else {
                print("📰 Feed has no story IDs")
                return nil
            }
            
            // Fetch the stories by IDs - need to fetch each one since .in() has UUID issues
            var stories: [StoryDTO] = []
            for storyId in feed.storyIds {
                let storyResponse: [StoryDTO] = try await supabase
                    .from("stories")
                    .select()
                    .eq("id", value: storyId)
                    .limit(1)
                    .execute()
                    .value
                if let story = storyResponse.first {
                    stories.append(story)
                }
            }
            
            print("📰 Fetched \(stories.count) stories from IDs")
            
            // Reorder to match curated order
            let storyMap = Dictionary(uniqueKeysWithValues: stories.map { ($0.id.uuidString.lowercased(), $0) })
            let orderedStories = feed.storyIds.compactMap { storyMap[$0.lowercased()]?.toStory() }
            
            print("✅ Loaded curated feed for \(dateString): \(orderedStories.count) stories")
            return orderedStories
        } catch {
            print("❌ Error fetching curated feed: \(error)")
            print("❌ Error details: \(error.localizedDescription)")
            return nil
        }
    }

    // Fetch available categories
    func fetchCategories() async -> [String] {
        do {
            let response: [StoryDTO] = try await supabase
                .from("stories")
                .select("category")
                .eq("published", value: true)
                .execute()
                .value

            let categories = Set(response.compactMap { $0.category })
            return Array(categories).sorted()
        } catch {
            print("❌ Error fetching categories: \(error.localizedDescription)")
            return []
        }
    }
}

// MARK: - API Errors

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case notFound
}
