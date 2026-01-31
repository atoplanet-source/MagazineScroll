import SwiftUI

// MARK: - Error State View

/// Reusable error state with retry button
struct ErrorStateView: View {
    let title: String
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "wifi.slash")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.primary)
                
                Text(message)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Button(action: retryAction) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                    Text("Try Again")
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color(hex: "#2E5090"))
                .clipShape(Capsule())
            }
            
            Spacer()
        }
    }
}

// MARK: - Empty State View

/// Reusable empty state
struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.tertiary)
            
            Spacer()
        }
    }
}

// MARK: - Loading State View

/// Reusable loading state
struct LoadingStateView: View {
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            
            ProgressView()
                .scaleEffect(1.2)
            
            Text(message)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.secondary)
            
            Spacer()
        }
    }
}

// MARK: - Previews

#Preview("Error State") {
    ErrorStateView(
        title: "Unable to Load Stories",
        message: "Check your internet connection and try again.",
        retryAction: {}
    )
}

#Preview("Empty State") {
    EmptyStateView(
        icon: "sparkles",
        title: "You've explored everything!",
        message: "Check back later for new stories"
    )
}

#Preview("Loading State") {
    LoadingStateView(message: "Loading stories...")
}
