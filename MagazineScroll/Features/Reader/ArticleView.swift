import SwiftUI
import UIKit

// MARK: - Article View (Paginated Text Flow)

struct ArticleView: View {
    let story: Story
    let onClose: () -> Void
    var disableVerticalScroll: Bool = false
    var isExplorationMode: Bool = false
    @Environment(SavedStoriesManager.self) private var savedManager
    @Environment(CloudKitManager.self) private var cloudKitManager
    @State private var pages: [PageContent] = []
    @State private var showHeartAnimation: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0
    @State private var isBackButtonPressed: Bool = false
    @State private var hasTrackedRead: Bool = false
    @State private var isCalculatingPages: Bool = false

    // Time-based read tracking
    @State private var readTimer: Timer? = nil
    @State private var timeOnArticle: TimeInterval = 0
    @State private var isAnimating: Bool = false
    private let readThresholdSeconds: TimeInterval = 30

    // Page cache to avoid recalculating pages - uses LRU cache with memory management
    private static let pageCache = PageCache.shared

    // Animation configuration - TikTok/Reels style snappy scrolling
    private let snapAnimationResponse: Double = 0.5   // Spring response time (lower = faster)
    private let snapAnimationDamping: Double = 1.0    // Damping (1.0 = no bounce)
    private let velocityThreshold: CGFloat = 200      // Lower = more sensitive to flicks
    private let dragThreshold: CGFloat = 40           // Lower = easier to trigger page change

    // Stable screen size - doesn't change
    private let screenSize = UIScreen.main.bounds.size

    // Dynamic safe area inset for status bar
    private var topSafeAreaInset: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first { $0.isKeyWindow }?
            .safeAreaInsets.top ?? 47
    }

    // Computed current page based on offset
    private var currentPageIndex: Int {
        let pageHeight = screenSize.height
        let totalOffset = scrollOffset + dragOffset
        return max(0, min(pages.count - 1, Int(round(-totalOffset / pageHeight))))
    }

    private var snapAnimation: Animation {
        .spring(response: snapAnimationResponse, dampingFraction: snapAnimationDamping)
    }

    // MARK: - Adaptive Navbar Colors (based on current page)

    private var currentBackgroundColor: String {
        return pages[safe: currentPageIndex]?.backgroundColor ?? "#000000"
    }

    private var navbarForegroundColor: Color {
        isLightColor(hex: currentBackgroundColor) ? .black : .white
    }

    init(story: Story, onClose: @escaping () -> Void, disableVerticalScroll: Bool = false, isExplorationMode: Bool = false) {
        self.story = story
        self.onClose = onClose
        self.disableVerticalScroll = disableVerticalScroll
        self.isExplorationMode = isExplorationMode
    }

    var body: some View {
        // Base container that anchors content to top
        Color.black
            .frame(width: screenSize.width, height: screenSize.height)
            .overlay(alignment: .top) {
                // Show loading placeholder while calculating pages
                if pages.isEmpty && isCalculatingPages {
                    // Show title page background color as placeholder
                    Color(hex: CategoryPalettes.palette(for: story.category).primary)
                        .ignoresSafeArea()
                } else {
                    // Page content - anchored to top, offset controls which page is visible
                    VStack(spacing: 0) {
                        ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                            PageView(page: page, screenSize: screenSize)
                                .frame(width: screenSize.width, height: screenSize.height)
                        }
                    }
                    .offset(y: scrollOffset + dragOffset)
                }
            }
            .clipped()
            .simultaneousGesture(pagingDragGesture)
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                // Navbar with safe area padding
                HStack {
                    Circle()
                        .fill(navbarForegroundColor.opacity(isBackButtonPressed ? 0.25 : 0))
                        .frame(width: 48, height: 48)
                        .overlay(
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(navbarForegroundColor.opacity(isBackButtonPressed ? 0.4 : 0.85))
                        )
                        .scaleEffect(isBackButtonPressed ? 0.8 : 1.0)
                        .animation(.easeInOut(duration: 0.12), value: isBackButtonPressed)
                        .contentShape(Circle())
                        .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    if !isBackButtonPressed {
                                        withAnimation(.easeInOut(duration: 0.12)) {
                                            isBackButtonPressed = true
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeInOut(duration: 0.12)) {
                                        isBackButtonPressed = false
                                    }
                                    onClose()
                                }
                        )

                    Spacer()

                    Text(story.title)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(navbarForegroundColor.opacity(0.6))
                        .lineLimit(1)
                }
                .padding(.horizontal, 20)
                .padding(.top, topSafeAreaInset + 8) // Dynamic safe area + small padding
            }
            .overlay(alignment: .bottom) {
                // Page counter - only shows after title page
                if currentPageIndex > 0 {
                    let pagesLeft = pages.count - 1 - currentPageIndex
                    HStack {
                        Spacer()
                        Text("\(pagesLeft) pages left")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(navbarForegroundColor.opacity(0.5))
                            .padding(.trailing, 16)
                    }
                    .padding(.bottom, 40) // Safe area padding for bottom
                }
            }
        .overlay {
            if showHeartAnimation {
                HeartAnimationView()
            }
        }
        .onTapGesture(count: 2) {
            savedManager.save(story)
            EngagementTracker.shared.recordLike()
            cloudKitManager.likeArticle(story.id, category: story.category)

            // Track exploration conversion if liking from exploration tab
            if isExplorationMode, let category = story.category {
                cloudKitManager.recordExplorationConversion(category: category)
            }

            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                showHeartAnimation = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeOut(duration: 0.2)) {
                    showHeartAnimation = false
                }
            }
        }
        .onChange(of: story.id) { _, _ in
            // End tracking for previous story
            if let engagement = EngagementTracker.shared.endReading() {
                cloudKitManager.recordEngagement(engagement)
            }

            scrollOffset = 0
            hasTrackedRead = false
            loadPagesAsync()
            startReadTimer()
        }
        .onChange(of: currentPageIndex) { _, newPage in
            // Record page view for engagement tracking
            EngagementTracker.shared.recordPageView(pageIndex: newPage)

            // Track as read when user reaches the last page
            if newPage == pages.count - 1 && !hasTrackedRead && pages.count > 1 {
                markAsRead()
            }
        }
        .onAppear {
            if pages.isEmpty {
                loadPagesAsync()
            }
            // Start engagement tracking (will update when pages load)
            if !pages.isEmpty {
                EngagementTracker.shared.startReading(story: story, totalPages: pages.count)
            }
            startReadTimer()
        }
        .onDisappear {
            stopReadTimer()
            // End engagement tracking and record
            if let engagement = EngagementTracker.shared.endReading() {
                cloudKitManager.recordEngagement(engagement)
            }
        }
    }

    func resetToStart() {
        // No-op for now
    }

    // MARK: - Read Timer

    private func startReadTimer() {
        stopReadTimer()
        timeOnArticle = 0
        readTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            DispatchQueue.main.async { [self] in
                // Skip updates during scroll animations to prevent conflicts
                guard !isAnimating else { return }
                timeOnArticle += 1
                if timeOnArticle >= readThresholdSeconds && !hasTrackedRead {
                    markAsRead()
                }
            }
        }
    }

    private func stopReadTimer() {
        readTimer?.invalidate()
        readTimer = nil
    }

    private func markAsRead() {
        guard !hasTrackedRead else { return }
        hasTrackedRead = true
        CloudKitManager.shared.markArticleRead(story.id, category: story.category)
    }

    // MARK: - Async Page Loading with Cache

    private func loadPagesAsync() {
        // Check cache first (uses LRU cache with memory management)
        if let cached = Self.pageCache.get(story.id) {
            pages = cached
            EngagementTracker.shared.startReading(story: story, totalPages: pages.count)
            return
        }

        // Prevent duplicate calculations
        guard !isCalculatingPages else { return }
        isCalculatingPages = true

        // Calculate pages off main thread
        let storyToCalculate = story
        let size = screenSize
        Task.detached(priority: .userInitiated) {
            let calculatedPages = Self.calculatePages(story: storyToCalculate, screenSize: size)

            // Cache the result (LRU cache handles eviction automatically)
            await MainActor.run {
                Self.pageCache.set(storyToCalculate.id, pages: calculatedPages)
                self.pages = calculatedPages
                self.isCalculatingPages = false
                EngagementTracker.shared.startReading(story: storyToCalculate, totalPages: calculatedPages.count)
            }
        }
    }

    // MARK: - Custom Paging Gesture

    private var pagingDragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                // Don't process vertical scroll if horizontal swipe is active
                guard !disableVerticalScroll else { return }

                let proposedOffset = scrollOffset + value.translation.height
                let maxOffset: CGFloat = 0
                let minOffset = -CGFloat(max(0, pages.count - 1)) * screenSize.height

                if proposedOffset > maxOffset {
                    dragOffset = value.translation.height * 0.3  // Rubber band top
                } else if proposedOffset < minOffset {
                    let overshoot = minOffset - proposedOffset
                    dragOffset = value.translation.height + overshoot * 0.7  // Rubber band bottom
                } else {
                    dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                guard !disableVerticalScroll else {
                    dragOffset = 0
                    return
                }
                handleDragEnd(value: value)
            }
    }

    private func handleDragEnd(value: DragGesture.Value) {
        let pageHeight = screenSize.height

        // Transfer dragOffset to scrollOffset (preserves visual position)
        let currentVisualOffset = scrollOffset + dragOffset
        scrollOffset = currentVisualOffset
        dragOffset = 0  // No visual change - we just transferred it

        let currentPage = Int(round(-currentVisualOffset / pageHeight))
        let velocity = value.predictedEndTranslation.height - value.translation.height
        let dragDistance = value.translation.height

        var targetPage = currentPage

        // Only change by ONE page max
        if abs(velocity) > velocityThreshold || abs(dragDistance) > dragThreshold {
            if dragDistance > 0 || velocity > velocityThreshold {
                targetPage = currentPage - 1  // Previous page
            } else if dragDistance < 0 || velocity < -velocityThreshold {
                targetPage = currentPage + 1  // Next page
            }
        }

        targetPage = max(0, min(pages.count - 1, targetPage))

        // Now animate from current position to target
        isAnimating = true
        withAnimation(snapAnimation) {
            scrollOffset = -CGFloat(targetPage) * pageHeight
        }
        // Clear animation flag after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + snapAnimationResponse + 0.1) {
            isAnimating = false
        }
    }

    // MARK: - Color Helpers

    private func isLightColor(hex: String) -> Bool {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        guard hexString.count == 6,
              let hexValue = UInt64(hexString, radix: 16) else {
            return false
        }

        let r = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hexValue & 0x0000FF) / 255.0

        // Calculate perceived luminance
        let luminance = 0.299 * r + 0.587 * g + 0.114 * b
        return luminance > 0.5
    }

    // MARK: - Text Measurement Helper

    private static func measureTextWidth(_ text: String, font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width
    }

    private static func measureTextHeight(_ text: String, font: UIFont, width: CGFloat, lineSpacing: CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]

        let boundingRect = (text as NSString).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )

        return ceil(boundingRect.height)
    }

    // MARK: - Pagination Logic

    /// Calculate pages for a story - used for both rendering and pre-warming cache
    static func calculatePages(story: Story, screenSize: CGSize) -> [PageContent] {
        let fontSize: CGFloat = 38
        let lineSpacing: CGFloat = fontSize * 0.35
        let horizontalPadding: CGFloat = 24
        let topPadding: CGFloat = screenSize.height * 0.03 + 80  // 3% down from current
        let bottomPadding: CGFloat = 40

        let availableWidth = screenSize.width - (horizontalPadding * 2)
        let availableHeight = screenSize.height - topPadding - bottomPadding

        // Get the actual UIFont for measurement
        let uiFont = UIFont(name: "Inter18pt-Black", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .black)

        // Combine all text from story sections
        var fullText = ""
        for section in story.sections {
            if let text = section.textContent {
                if !fullText.isEmpty {
                    fullText += " "
                }
                fullText += text
            }
        }

        // Clean up text
        fullText = fullText.replacingOccurrences(of: "\n", with: " ")
        fullText = fullText.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        fullText = fullText.trimmingCharacters(in: .whitespacesAndNewlines)

        let words = fullText.split(separator: " ").map(String.init)

        // Get category-based color palette
        let palette = CategoryPalettes.palette(for: story.category)

        guard !words.isEmpty else {
            return [PageContent(
                text: "",
                title: story.title,
                backgroundColor: palette.primary,
                textColor: palette.titleText,
                imagePlaceholder: nil
            )]
        }

        var pages: [PageContent] = []
        var currentWordIndex = 0
        var colorIndex = 0

        // Add title page first (uses category's primary color)
        pages.append(PageContent(
            text: "",
            title: story.title,
            backgroundColor: palette.primary,
            textColor: palette.titleText,
            imagePlaceholder: nil
        ))

        let maxPages = 50
        // Small buffer for rendering differences between UIKit measurement and SwiftUI rendering
        let safeHeight = availableHeight - 10

        while currentWordIndex < words.count && pages.count < maxPages {
            // Get rainbow colors cycling through the palette
            let colors = palette.pageColor(at: colorIndex)

            var lines: [String] = []
            var currentLine = ""

            // Build lines using actual text measurement
            while currentWordIndex < words.count {
                let word = words[currentWordIndex]
                let testLine = currentLine.isEmpty ? word : currentLine + " " + word
                let lineWidth = measureTextWidth(testLine, font: uiFont)

                if lineWidth <= availableWidth {
                    currentLine = testLine
                    currentWordIndex += 1
                } else {
                    // Line is full - check if adding it would exceed page height BEFORE adding
                    if !currentLine.isEmpty {
                        let testLines = lines + [currentLine]
                        let testText = testLines.joined(separator: "\n")
                        let testHeight = measureTextHeight(testText, font: uiFont, width: availableWidth, lineSpacing: lineSpacing)

                        if testHeight > safeHeight {
                            // Adding this line would exceed page - don't add it
                            // Rewind the words in currentLine
                            let wordsInLine = currentLine.split(separator: " ").count
                            currentWordIndex -= wordsInLine
                            currentLine = ""
                            break
                        }

                        lines.append(currentLine)
                    } else {
                        // Single word too long - add it anyway
                        lines.append(word)
                        currentWordIndex += 1
                    }
                    currentLine = ""
                }
            }

            // Add remaining line if we have room
            if !currentLine.isEmpty {
                let testLines = lines + [currentLine]
                let testText = testLines.joined(separator: "\n")
                let testHeight = measureTextHeight(testText, font: uiFont, width: availableWidth, lineSpacing: lineSpacing)

                if testHeight <= safeHeight {
                    lines.append(currentLine)
                } else {
                    // Put the words back for the next page
                    let wordsInLine = currentLine.split(separator: " ").count
                    currentWordIndex -= wordsInLine
                }
            }

            let pageText = lines.joined(separator: "\n")

            if !pageText.isEmpty {
                pages.append(PageContent(
                    text: pageText,
                    title: nil,
                    backgroundColor: colors.bg,
                    textColor: colors.text,
                    imagePlaceholder: nil
                ))
                colorIndex += 1
            }
        }

        return pages
    }
}

// MARK: - Page Content Model

struct PageContent {
    let text: String
    let title: String?
    let backgroundColor: String
    let textColor: String
    let imagePlaceholder: ImagePlaceholder?
}

struct ImagePlaceholder {
    let color: String
    let aspectRatio: CGFloat
}

// MARK: - Page View

struct PageView: View {
    let page: PageContent
    let screenSize: CGSize

    private let fontSize: CGFloat = 38
    private let horizontalPadding: CGFloat = 24
    private var topPadding: CGFloat { screenSize.height * 0.03 + 80 }
    private let bottomPadding: CGFloat = 40

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background
            Color(hex: page.backgroundColor)

            // Content
            if let title = page.title {
                // Title page
                titlePageContent(title: title)
            } else {
                // Regular text page
                textPageContent()
            }
        }
    }

    private func titlePageContent(title: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()

            Text(title)
                .font(Typography.primaryFont(size: 52))
                .foregroundStyle(Color(hex: page.textColor))
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
                .frame(height: screenSize.height * 0.15)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, bottomPadding)
    }

    private func textPageContent() -> some View {
        Text(page.text)
            .font(Typography.primaryFont(size: fontSize))
            .foregroundStyle(Color(hex: page.textColor))
            .lineSpacing(fontSize * 0.35)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.top, topPadding)
            .padding(.horizontal, horizontalPadding)
    }

    private func imagePlaceholderView(placeholder: ImagePlaceholder) -> some View {
        let availableWidth = screenSize.width - (horizontalPadding * 2)
        let availableHeight = screenSize.height - topPadding - bottomPadding
        let maxImageHeight = availableHeight * 0.35

        let imageWidth: CGFloat
        let imageHeight: CGFloat

        if placeholder.aspectRatio > 1 {
            imageWidth = availableWidth
            imageHeight = min(maxImageHeight, availableWidth / placeholder.aspectRatio)
        } else {
            imageHeight = maxImageHeight
            imageWidth = min(availableWidth * 0.7, imageHeight * placeholder.aspectRatio)
        }

        return RoundedRectangle(cornerRadius: 4)
            .fill(Color(hex: placeholder.color))
            .frame(width: imageWidth, height: imageHeight)
            .frame(maxWidth: .infinity, alignment: placeholder.aspectRatio > 1 ? .center : .leading)
    }
}

// MARK: - Heart Animation View

struct HeartAnimationView: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.8

    var body: some View {
        Image(systemName: "heart.fill")
            .font(.system(size: 80))
            .foregroundStyle(.white)
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            .scaleEffect(scale)
            .opacity(opacity)
            .onAppear {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                    scale = 1.2
                }
                withAnimation(.easeOut(duration: 0.15).delay(0.4)) {
                    scale = 1.0
                }
            }
    }
}

// MARK: - Safe Array Subscript

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    ArticleView(
        story: SampleData.stories[0],
        onClose: {}
    )
    .environment(SavedStoriesManager())
}
