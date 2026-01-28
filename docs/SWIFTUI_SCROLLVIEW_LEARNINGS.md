# SwiftUI ScrollView Debugging Learnings

This document captures debugging insights from fixing snapping and layout issues in the MagazineScroll article reader.

## The Problem

When opening an article, the view would display correctly for ~0.25 seconds, then snap/jump to a different position. Text would also sometimes overflow page bounds or show truncation (`...`).

---

## Root Causes & Fixes

### 1. Spring Animation Settling Causes ScrollView Snapping

**Symptom**: Article opens correctly, then snaps upward after a fraction of a second.

**Root Cause**: Using `.spring()` animation on a parent view affects nested ScrollViews. The spring's "settling" oscillation triggers layout recalculations that cause the ScrollView to jump.

**Bad Code**:
```swift
// In ContentView
.animation(.spring(response: 0.4, dampingFraction: 0.85), value: navigationState.isShowingReader)
```

**Fix**: Use `.easeOut()` instead - no oscillation means no settling-triggered redraws.
```swift
.animation(.easeOut(duration: 0.3), value: navigationState.isShowingReader)
```

**Key Learning**: Avoid spring animations on views containing ScrollViews with paging behavior.

---

### 2. scrollPosition Binding Forces Scroll Position

**Symptom**: ScrollView jumps to position 0 on appear.

**Root Cause**: `.scrollPosition(id: $scrollPosition)` with an initial value of `nil` or `0` forces the scroll to that position after the view renders.

**Bad Code**:
```swift
@State private var scrollPosition: Int? = nil

ScrollView {
    // content
}
.scrollPosition(id: $scrollPosition)
```

**Fix**: Remove the binding if you don't need programmatic scrolling, or initialize it correctly.
```swift
// Just remove it if not needed
ScrollView {
    // content
}
.scrollTargetBehavior(.paging)  // This alone handles paging
```

**Key Learning**: Only use `.scrollPosition(id:)` if you need to programmatically scroll. The binding actively controls position.

---

### 3. onAppear in LazyVStack Causes Re-renders

**Symptom**: Snapping occurs after scrolling a few pages.

**Root Cause**: Using `.onAppear` on items inside a LazyVStack to track which page is visible triggers state updates, which can cause re-renders and layout shifts.

**Bad Code**:
```swift
LazyVStack(spacing: 0) {
    ForEach(pages) { page in
        PageView(page: page)
            .onAppear {
                visiblePageIndex = page.index  // Triggers re-render!
            }
    }
}
```

**Fix**: Avoid setting state in `.onAppear` of lazy-loaded items. If you need to track position, use `.scrollPosition(id:)` or a scroll offset reader.

---

### 4. fixedSize Causes Text Overflow

**Symptom**: Text extends beyond page bounds, ignoring frame constraints.

**Root Cause**: `.fixedSize(horizontal: false, vertical: true)` tells SwiftUI to use the text's ideal size vertically, ignoring any frame constraints.

**Bad Code**:
```swift
Text(content)
    .lineLimit(nil)
    .fixedSize(horizontal: false, vertical: true)  // Ignores page height!
```

**Fix**: Let the frame constrain the text. Pre-calculate pagination so text naturally fits.
```swift
Text(content)
    .frame(maxWidth: .infinity, alignment: .topLeading)
// Don't use fixedSize - let the parent frame do its job
```

**Key Learning**: `.fixedSize()` overrides frame constraints. Only use it when you want the view to expand to its ideal size.

---

### 5. GeometryReader in ScrollView Items Causes Instability

**Symptom**: Intermittent layout jumps, especially on first render.

**Root Cause**: GeometryReader reports size asynchronously. When used inside scrolling content, the size can change after initial render, causing jumps.

**Bad Code**:
```swift
ScrollView {
    LazyVStack {
        ForEach(items) { item in
            GeometryReader { geo in
                // geo.size changes after first render!
                ItemView()
                    .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}
```

**Fix**: Use `UIScreen.main.bounds` for stable screen dimensions.
```swift
private let screenSize = UIScreen.main.bounds.size

ScrollView {
    LazyVStack {
        ForEach(items) { item in
            ItemView()
                .frame(width: screenSize.width, height: screenSize.height)
        }
    }
}
```

**Key Learning**: For full-screen paging, use `UIScreen.main.bounds` instead of GeometryReader. It's stable and available immediately.

---

### 6. Safe Area Handling with ignoresSafeArea

**Symptom**: Content doesn't extend to screen edges, or nav bar overlaps content incorrectly.

**Root Cause**: Inconsistent use of `.ignoresSafeArea()` between parent and child views.

**Fix**: Apply `.ignoresSafeArea()` at the ScrollView level, and use overlays for navigation elements.
```swift
ScrollView {
    // content
}
.ignoresSafeArea()
.overlay(alignment: .top) {
    // Navigation bar as overlay, not inside ScrollView
    NavBar()
        .padding(.top, 8)
}
```

---

### 7. Initializing State from Computed Values

**Symptom**: Need to pre-calculate pages in init to avoid layout shifts.

**Solution**: Use `_propertyName = State(initialValue:)` syntax in init.
```swift
struct ArticleView: View {
    @State private var pages: [PageContent]

    init(story: Story) {
        self.story = story
        // Must use underscore syntax to set State in init
        _pages = State(initialValue: Self.calculatePages(story: story))
    }

    // Must be static to use in init (self not available yet)
    static func calculatePages(story: Story) -> [PageContent] {
        // calculation logic
    }
}
```

---

## Summary Checklist

When building paginated ScrollViews in SwiftUI:

- [ ] Use `.easeOut()` or `.linear()` animations, not `.spring()` on parent views
- [ ] Avoid `.scrollPosition(id:)` unless needed for programmatic scrolling
- [ ] Don't set state in `.onAppear` of lazy-loaded items
- [ ] Don't use `.fixedSize()` if you want frame constraints respected
- [ ] Use `UIScreen.main.bounds` instead of GeometryReader for stable dimensions
- [ ] Apply `.ignoresSafeArea()` at ScrollView level
- [ ] Use overlays for floating UI elements (nav bars, etc.)
- [ ] Pre-calculate content in `init()` to avoid layout shifts

---

## Debugging Tips

1. **Isolate the problem**: Remove animations, bindings, and state updates one at a time
2. **Check timing**: If it works then snaps after ~0.25s, look for spring animations or async state updates
3. **Check state changes**: Any `@State` update in `.onAppear` or `.onChange` can trigger re-renders
4. **Test without lazy loading**: Replace `LazyVStack` with `VStack` to see if lazy loading is the issue
5. **Print frame sizes**: Add `.background(GeometryReader { geo in Color.clear.onAppear { print(geo.size) }})` to debug sizes

---

*Last updated: January 2026*
