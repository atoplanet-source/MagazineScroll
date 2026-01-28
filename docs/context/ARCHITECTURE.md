# Architecture

## Overview
The app follows a feature-based architecture with clear separation of concerns.

## Layers

### App Layer
- Entry point (`MagazineScrollApp.swift`)
- Root view (`ContentView`)
- Global state initialization

### Features Layer
Organized by feature domain:
- **Home**: Story discovery and selection
- **Reader**: Story consumption experience
- **Shared**: Reusable UI components

### Models Layer
- Data structures (`Story`, `Slide`)
- App state (`NavigationState`)
- Type-safe enums (`SlideType`, `ImageLayout`)

### Design System Layer
- Typography configuration
- Color palette
- Spacing constants

### Services Layer
- API client (prepared for backend)
- Image caching

## State Management

### NavigationState (@Observable)
Central state object managing:
- Story list
- Current story/slide indices
- Reader visibility
- Navigation methods

### Data Flow
1. App initializes `NavigationState`
2. State passed via `@Bindable` to views
3. Views call state methods for navigation
4. SwiftUI reactively updates UI

## Key Decisions

### iOS 17+ APIs
- `@Observable` macro for state (replaces ObservableObject)
- `@Bindable` for property bindings
- `containerRelativeFrame` for full-screen slides
- `scrollTargetBehavior(.paging)` for snap scroll

### File System Synchronization
Using Xcode 15+ file system synchronized groups:
- Files auto-include when added to folders
- No manual project file management
- Better source control

### No External Dependencies
v1 uses only Apple frameworks:
- SwiftUI for UI
- Foundation for data
- Native AsyncImage for remote images

## Performance Considerations

### LazyVStack
Slides rendered on-demand as user scrolls.

### Image Caching
Simple in-memory cache with size limit.

### View Identity
Using `id()` modifier with slide index for scroll position tracking.
