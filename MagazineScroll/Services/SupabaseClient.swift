import Foundation
import Supabase

// MARK: - Supabase Configuration

enum SupabaseConfig {
    static let url = URL(string: "https://egfwisgqdyhzpmeoracb.supabase.co")!
    static let anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVnZndpc2dxZHloenBtZW9yYWNiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg0MjczNDksImV4cCI6MjA4NDAwMzM0OX0.YdjduzJggQEFUqk14z1EviQKsiG8jOIywPjDV0JyUXM"
}

// MARK: - Supabase Client Instance

let supabase = SupabaseClient(
    supabaseURL: SupabaseConfig.url,
    supabaseKey: SupabaseConfig.anonKey
)
