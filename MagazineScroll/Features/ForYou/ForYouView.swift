import SwiftUI

// MARK: - For You View

struct ForYouView: View {
    @Bindable var navigationState: NavigationState
    @State private var viewModel = ForYouViewModel()
    @State private var showingSurprise = false
    @State private var surpriseStory: Story?

    var body: some View {
        ZStack {
            // Background
            Color(hex: "#F5F4F0")
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header
                    headerSection
                        .padding(.top, 60)

                    // Surprise Me Button
                    surpriseMeButton
                        .padding(.top, 24)
                        .padding(.horizontal, 20)

                    // Personalized Feed
                    if viewModel.isLoading {
                        loadingView
                            .padding(.top, 40)
                    } else if viewModel.personalizedStories.isEmpty {
                        emptyState
                            .padding(.top, 40)
                    } else {
                        personalizedFeed
                            .padding(.top, 24)
                    }
                }
                .padding(.bottom, 120)
            }
        }
        .onAppear {
            if viewModel.personalizedStories.isEmpty {
                viewModel.generateFeed(from: navigationState.stories)
            }
        }
        .onChange(of: navigationState.stories.count) { _, _ in
            viewModel.generateFeed(from: navigationState.stories)
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(Color(hex: "#FFB300"))

                Text("For You")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.black)
            }

            Text("Personalized based on your interests")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black.opacity(0.5))
        }
    }

    // MARK: - Surprise Me Button

    private var surpriseMeButton: some View {
        Button {
            if let story = viewModel.surpriseStory(from: navigationState.stories) {
                surpriseStory = story
                openSurpriseStory(story)
            }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "dice.fill")
                    .font(.system(size: 20, weight: .semibold))

                Text("Surprise Me")
                    .font(.system(size: 17, weight: .bold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    colors: [Color(hex: "#8E24AA"), Color(hex: "#EC407A")],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color(hex: "#8E24AA").opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Personalized Feed

    private var personalizedFeed: some View {
        LazyVStack(spacing: 12) {
            ForEach(Array(viewModel.personalizedStories.enumerated()), id: \.element.id) { index, story in
                ForYouCard(
                    story: story,
                    index: index,
                    onTap: { openStory(story, at: index) }
                )
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Loading View

    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.2)

            Text("Curating your feed...")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black.opacity(0.5))
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "sparkles")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(.black.opacity(0.3))

            Text("No personalized stories yet")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black.opacity(0.6))

            Text("Complete the quiz to get recommendations")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.black.opacity(0.4))
        }
        .padding(40)
    }

    // MARK: - Helpers

    private func openStory(_ story: Story, at index: Int) {
        navigationState.feedStories = viewModel.personalizedStories
        navigationState.openStory(at: index)
    }

    private func openSurpriseStory(_ story: Story) {
        navigationState.feedStories = [story]
        navigationState.openStory(at: 0)
    }
}

// MARK: - For You Card

struct ForYouCard: View {
    let story: Story
    let index: Int
    let onTap: () -> Void

    private var bgColor: String {
        CategoryColors.color(for: story.category)
    }

    // Vary card height based on position
    private var cardHeight: CGFloat {
        switch index % 5 {
        case 0: return 140  // Tall
        case 1, 2: return 100  // Medium
        default: return 80  // Compact
        }
    }

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 0) {
                // Color stripe
                Rectangle()
                    .fill(Color(hex: bgColor))
                    .frame(width: 6)

                // Content
                VStack(alignment: .leading, spacing: 6) {
                    // Category
                    Text(story.category?.uppercased() ?? "")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color(hex: bgColor))
                        .tracking(1)

                    // Title
                    Text(story.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.black)
                        .lineLimit(cardHeight > 100 ? 3 : 2)

                    // Description (only on tall cards)
                    if cardHeight > 120, let desc = story.description {
                        Text(desc)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.black.opacity(0.6))
                            .lineLimit(2)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)

                // Chevron
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.3))
                    .padding(.trailing, 16)
            }
            .frame(height: cardHeight)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let state = NavigationState()
    state.stories = SampleData.stories

    return ForYouView(navigationState: state)
        .environment(SavedStoriesManager())
}
