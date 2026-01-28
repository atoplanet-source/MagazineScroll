# API Schema

## Data Models

### Story
```swift
struct Story: Codable, Identifiable {
    let id: UUID
    let title: String
    let slug: String
    let description: String?
    let thumbnailUrl: String?
    var slides: [Slide]
}
```

### Slide
```swift
struct Slide: Codable, Identifiable {
    let id: UUID
    let position: Int
    let slideType: SlideType
    let textContent: String?
    let imageUrl: String?
    let imageLayout: ImageLayout?
    let backgroundColor: String  // Hex color
    let textColor: String        // Hex color
}
```

### SlideType
```swift
enum SlideType: String, Codable {
    case textOnly = "text_only"
    case imageOnly = "image_only"
    case textWithImage = "text_with_image"
}
```

### ImageLayout
```swift
enum ImageLayout: String, Codable {
    case fullBleed = "full_bleed"
    case editorial = "editorial"
    case inset = "inset"
}
```

## API Endpoints (Future)

### GET /stories
Returns list of all stories (without slides for performance).

**Response:**
```json
{
  "stories": [
    {
      "id": "uuid",
      "title": "Story Title",
      "slug": "story-slug",
      "description": "Optional description",
      "thumbnailUrl": "https://..."
    }
  ]
}
```

### GET /stories/:slug
Returns single story with all slides.

**Response:**
```json
{
  "story": {
    "id": "uuid",
    "title": "Story Title",
    "slug": "story-slug",
    "description": "Optional description",
    "thumbnailUrl": "https://...",
    "slides": [
      {
        "id": "uuid",
        "position": 0,
        "slideType": "text_only",
        "textContent": "The text content",
        "imageUrl": null,
        "imageLayout": null,
        "backgroundColor": "#E63946",
        "textColor": "#FFFFFF"
      }
    ]
  }
}
```

## Color Format
All colors are 6-digit hex strings with # prefix:
- Valid: "#E63946", "#FFFFFF", "#0D0D0D"
- Invalid: "E63946", "#FFF", "rgb(230,57,70)"

## Current Implementation
For v1, all data is loaded from `SampleData.swift`. The `APIClient` is prepared to fetch from a real backend when ready.
