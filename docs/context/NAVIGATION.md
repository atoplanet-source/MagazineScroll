# Navigation

## User Flows

### Launch Flow
```
App Launch
    │
    ▼
Load Stories (from SampleData)
    │
    ▼
Home View (Story Grid)
```

### Story Entry Flow
```
Home View
    │
    ▼ Tap Story Card
    │
Open Story at Index
    │
    ▼
Reader View (First Slide)
```

### Slide Navigation
```
Reader View
    │
    ├─▼ Scroll Down ─→ Next Slide
    │
    ├─▲ Scroll Up ──→ Previous Slide
    │
    └─ Snap to nearest slide on release
```

### Story Navigation
```
Reader View
    │
    ├─◀ Swipe Right ─→ Previous Story (if exists)
    │                   Reset to first slide
    │
    └─▶ Swipe Left ──→ Next Story (if exists)
                       Reset to first slide
```

### Exit Flow
```
Reader View
    │
    ▼ Tap Close Button
    │
Animate out
    │
    ▼
Home View
```

## State Transitions

### NavigationState Properties
```swift
@Observable class NavigationState {
    var stories: [Story]         // All available stories
    var currentStoryIndex: Int   // 0-based index
    var currentSlideIndex: Int   // 0-based index
    var isShowingReader: Bool    // Reader visibility
}
```

### State Mutations

| Action | Method | State Change |
|--------|--------|--------------|
| Open story | `openStory(at:)` | Set index, reset slide, show reader |
| Close reader | `closeReader()` | Hide reader, reset slide |
| Next story | `nextStory()` | Increment story, reset slide |
| Previous story | `previousStory()` | Decrement story, reset slide |
| Go to slide | `goToSlide(_:)` | Set slide index |

## Navigation Indicators

### Story Position
- Left chevron: Previous story available
- Right chevron: Next story available
- No indicator: At start/end of story list

### Slide Position
- No explicit indicator (scroll provides feedback)
- Could add dots or progress bar in v2

## Gesture Recognition

### Vertical Scroll
- Built-in iOS scroll behavior
- `.scrollTargetBehavior(.paging)` handles snap

### Horizontal Swipe
- Custom `DragGesture`
- Threshold: 50pt horizontal movement
- Must be more horizontal than vertical
- Animated offset before navigation

## Animation

### Reader Transition
- Spring animation (0.4s response, 0.85 damping)
- Slide from trailing edge

### Story Switch
- Spring animation (0.4s response, 0.8 damping)
- Offset animation before content change
