import SwiftUI

// MARK: - Reading Stats View

struct ReadingStatsView: View {
    let stats: ReadingStats

    var body: some View {
        VStack(spacing: 16) {
            // Section header
            HStack {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color(hex: "#2D6A4F"))

                Text("Reading Stats")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black)

                Spacer()
            }

            // Stats grid
            HStack(spacing: 12) {
                StatCard(
                    value: "\(stats.totalArticlesRead)",
                    label: "Articles Read",
                    icon: "book.fill",
                    color: "#2E5090"
                )

                StatCard(
                    value: "\(stats.currentStreak)",
                    label: "Day Streak",
                    icon: "flame.fill",
                    color: "#C45B28"
                )

                StatCard(
                    value: "\(stats.longestStreak)",
                    label: "Best Streak",
                    icon: "trophy.fill",
                    color: "#FFB300"
                )
            }

            // Favorite category
            if let favorite = stats.favoriteCategory {
                HStack(spacing: 12) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: CategoryColors.color(for: favorite)))

                    Text("Favorite Category:")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.black.opacity(0.6))

                    Text(favorite)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: CategoryColors.color(for: favorite)))

                    Spacer()
                }
                .padding(14)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

// MARK: - Stat Card

struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(Color(hex: color))

            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.black)

            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(.black.opacity(0.5))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    var stats = ReadingStats()
    stats.articlesRead = [UUID(), UUID(), UUID(), UUID(), UUID()]
    stats.categoryReadCounts = ["Science": 3, "Art": 2]
    stats.currentStreak = 5
    stats.longestStreak = 12

    return ZStack {
        Color(hex: "#F5F4F0").ignoresSafeArea()
        ReadingStatsView(stats: stats)
            .padding(20)
    }
}
