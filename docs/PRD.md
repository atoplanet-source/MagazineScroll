# Magazine App - Product Requirements Document

## Vision
A typography-driven reading experience where text IS the design. Each screen displays one sentence as a full-viewport visual poster, transforming reading into a visual journey.

## Target Platform
- iOS 17.0+
- iPhone only
- Portrait orientation locked
- SwiftUI framework

## Core Features

### 1. Home Screen
- Grid layout of story cards
- Each card previews the first slide
- Tap to enter story reader
- Dark theme with accent colors

### 2. Story Reader
- Full-screen slides (one sentence per slide)
- Vertical scroll with snap-to-slide behavior
- Horizontal swipe to navigate between stories
- Close button to return home
- Navigation indicators for adjacent stories

### 3. Slide Types
- **Text Only**: Bold text centered, fills viewport
- **Image Only**: Full-bleed or editorial placement
- **Text + Image**: Combined layout with image (~60-70% width)

### 4. Typography System
- Primary: Inter Black (900 weight)
- Dynamic sizing based on word count
- Automatic letter-spacing for short text
- Never cut off text on any screen size

### 5. Color System
- Per-slide background colors
- Automatic text color contrast
- Smooth transitions during scroll

## Data Model

### Story
- ID, title, slug
- Optional description and thumbnail
- Array of slides

### Slide
- Position in story
- Type (text, image, or mixed)
- Text content
- Image URL and layout
- Background and text colors (hex)

## Navigation Flow
1. Launch → Home (story grid)
2. Tap card → Reader (first slide)
3. Scroll down → Next slide
4. Scroll up → Previous slide
5. Swipe left → Next story
6. Swipe right → Previous story
7. Tap X → Return to Home

## Success Metrics
- App launches without crashes
- Slides display correctly on all iPhone sizes
- Typography scales appropriately
- Navigation feels smooth and responsive
- Colors match design specifications

## Future Considerations (v2+)
- Backend API integration
- User accounts and saved stories
- Offline reading support
- Share functionality
- iPad support
- Landscape mode for images
