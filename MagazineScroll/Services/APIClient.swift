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
