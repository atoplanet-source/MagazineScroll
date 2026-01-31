import SwiftUI

// MARK: - In Progress Card

/// Card showing a story that was started but not finished, with progress indicator
struct InProgressCard: View {
    let story: Story
    let progress: Double  // 0.0 to 1.0
    let onTap: () -> Void
    
    private var categoryColor: String {
        CategoryColors.color(for: story.category)
    }
    
    private var progressPercent: Int {
        Int(progress * 100)
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 0) {
                // Top section with category and progress
                HStack {
                    Text(story.category?.uppercased() ?? "")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white.opacity(0.7))
                        .tracking(1)
                    
                    Spacer()
                    
                    // Progress badge
                    Text("\(progressPercent)%")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.white.opacity(0.25))
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 14)
                .padding(.top, 14)
                
                Spacer()
                
                // Title
                Text(story.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 14)
                
                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        // Background
                        Rectangle()
                            .fill(.white.opacity(0.2))
                        
                        // Progress
                        Rectangle()
                            .fill(.white)
                            .frame(width: geo.size.width * progress)
                    }
                }
                .frame(height: 3)
                .padding(.top, 10)
            }
            .frame(width: 160, height: 130)
            .background(Color(hex: categoryColor))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    HStack(spacing: 12) {
        InProgressCard(
            story: SampleData.stories[0],
            progress: 0.6,
            onTap: {}
        )
        
        InProgressCard(
            story: SampleData.stories[1],
            progress: 0.3,
            onTap: {}
        )
    }
    .padding()
    .background(Color(hex: "#F5F4F0"))
}
