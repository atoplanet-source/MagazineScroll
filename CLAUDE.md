# MagazineScroll

## Overview
A typography-driven iOS magazine reading app with paginated vertical scrolling articles. Each story features bold text that fills pages top-to-bottom. The homepage features a bold, colorful editorial design with a featured hero section and category-colored article cards.

## Tech Stack
- iOS 17.0+ (SwiftUI)
- iPhone only (Portrait locked)
- Supabase backend for story storage (required - no offline fallback)
- Uses Inter font family (Black, ExtraBold)

## Documentation
- **[Story Guidelines](docs/STORY_GUIDELINES.md)** - Rules for creating stories (content, style, technical requirements)
- **[Personalization System](docs/PERSONALIZATION.md)** - Quiz, preferences, tag system, and feed algorithms

## Project Structure
```
MagazineScroll/
├── App/
│   └── MagazineScrollApp.swift      # App entry point
├── Features/
│   ├── Home/
│   │   ├── HomeView.swift           # Homepage with featured + card list
│   │   └── HomeViewModel.swift      # Home data logic
│   ├── Reader/
│   │   ├── ReaderView.swift         # Container with swipe navigation
│   │   └── ArticleView.swift        # Paginated article view
│   ├── Saved/
│   │   └── SavedView.swift          # Saved articles view
│   ├── Onboarding/
│   │   ├── OnboardingView.swift     # Quiz UI
│   │   └── OnboardingViewModel.swift # Quiz flow and preferences
│   └── Navigation/
│       └── MainTabView.swift        # Tab container with middle button
├── Models/
│   ├── Story.swift                  # Story data model (includes tags)
│   ├── Slide.swift                  # ContentBlock model
│   ├── NavigationState.swift        # App navigation state
│   ├── UserPreferences.swift        # User quiz answers and preferences
│   ├── ReadingStats.swift           # Reading history tracking
│   └── QuizQuestion.swift           # Quiz questions including follow-ups
├── DesignSystem/
│   ├── Typography.swift             # Font helpers (Inter)
│   ├── Colors.swift                 # Color palette with hex
│   └── Spacing.swift                # Layout constants
├── Services/
│   ├── APIClient.swift              # Supabase API client
│   ├── SupabaseClient.swift         # Supabase connection
│   ├── ImageCache.swift             # Image caching
│   ├── SavedStoriesManager.swift    # Persists saved/liked stories
│   ├── PersonalizationEngine.swift  # Story scoring and ranking
│   └── CloudKitManager.swift        # iCloud sync for preferences
├── Resources/
│   └── Fonts/
│       ├── Inter_18pt-Black.ttf
│       └── Inter_18pt-ExtraBold.ttf
├── Preview Content/
│   └── SampleData.swift             # Sample stories (development only)
└── docs/
    ├── STORY_GUIDELINES.md          # Story creation guidelines
    └── PERSONALIZATION.md           # Personalization system docs
```

## Key Components

### HomeView (Bold Editorial Design)
The homepage uses a category-based color system with varied card styles:

**Layout Structure:**
- **Category pills** - Horizontal scrolling filter tabs at top
- **Featured card** (280pt) - First story as large hero with title + description
- **Article list** - Mixed card styles for visual variety:
  - **Tall cards** (160pt) - Full color background, every 5th item
  - **Compact cards** (64pt) - Dark background with category color stripe
  - **Two-column squares** (120pt) - Side-by-side color blocks

**Category Color System:**
| Category | Color | Hex |
|----------|-------|-----|
| Economics | Rich blue | #2E5090 |
| Ancient World | Terracotta | #C45B28 |
| Medieval | Royal purple | #6B4C9A |
| 20th Century | Forest green | #2D6A4F |
| 19th Century | Saddle brown | #8B5A2B |
| Science | Bright blue | #1976D2 |
| Art | Crimson | #B33951 |
| Crime | Dark brown | #5D4037 |
| Exploration | Dark teal | #00695C |
| War | Muted brown | #8D6E63 |

### ArticleView (Reader)
Paginated article reader with:
- **Title page** - Story title with unique colors
- **Text pages** - 38pt Inter Black font, fills top to bottom
- **Automatic pagination** - Text flows across pages using UIKit text measurement
- **Dynamic navbar** - Exit button adapts color based on page background
- **Double-tap to save** - Heart animation appears, story saved to favorites
- **Smooth paging scroll** - Instagram-style vertical scrolling with snap-to-page

## Navigation
- **Home**: Tap story card to open reader
- **Reader**: Scroll vertically through pages (snap-to-page)
- **Story switching**: Horizontal swipe left/right
- **Save story**: Double-tap anywhere to save/like article
- **Close**: Tap back arrow button
- **Category filter**: Tap category pills to filter stories

## Current Stories (330)

All stories are stored in Supabase and loaded on app launch.

| Category | Count |
|----------|-------|
| Art | 36 |
| 20th Century | 35 |
| Crime | 34 |
| Exploration | 34 |
| Medieval | 34 |
| 19th Century | 33 |
| Ancient World | 33 |
| Economics | 31 |
| Science | 30 |
| War | 30 |

## Supabase Integration

**Stories are always loaded from Supabase** - no local fallback.

### Configuration
- **URL**: https://egfwisgqdyhzpmeoracb.supabase.co
- **Keys**: Stored in `SupabaseClient.swift` (anon key) and `magazine-content/.env` (service key)

### API Client (`Services/APIClient.swift`)
```swift
// Fetch all published stories
func fetchStories() async -> [Story]

// Fetch single story by ID or slug
func fetchStory(id: UUID) async -> Story?
func fetchStory(slug: String) async -> Story?

// Fetch available categories
func fetchCategories() async -> [String]
```

### Upload Scripts
Located in `magazine-content/scripts/`:
- `upload.mjs` - Node.js script to upload stories
- `bulk-upload.ts` - Deno version
- `auto-tag.mjs` - Claude API script to auto-tag stories with sub-categories

## Adding New Stories

1. Create story content following [Story Guidelines](docs/STORY_GUIDELINES.md)
2. Upload to Supabase using upload scripts
3. Set `published: true` in Supabase
4. Story will appear in app on next launch

**Note:** Stories are managed in Supabase, not in code. SampleData.swift is for development only.

## Adding New Categories

1. Add category color to `CategoryColors` enum in `HomeView.swift`:
```swift
case "NewCategory": return "#HEXCODE"
```

2. Upload stories with the new category to Supabase

## Fonts
Inter font files in `Resources/Fonts/`:
- `Inter_18pt-Black.ttf` (primary text)
- `Inter_18pt-ExtraBold.ttf`

Registered in Info.plist under UIAppFonts.

## Running
1. Open `MagazineScroll.xcodeproj` in Xcode
2. Select iPhone simulator
3. Build and run (Cmd+R)
4. Requires internet connection for Supabase

## Design Principles
- Text always starts at top of page, fills downward
- Category colors provide visual organization
- Featured hero card draws attention to top story
- Varied card styles create visual rhythm
- Dark background (#1A1A1A) for article list contrast
- Typography-focused reader experience

## Content Strategy: "Zoom Narration"
A progressive detail approach where each scroll takes readers deeper. Users can stop at any point and feel satisfied.

**Story Structure:**
| Pages | Section | Content |
|-------|---------|---------|
| 1 | Hook | Single most surprising fact |
| 2-3 | Context | When, where, who |
| 4-6 | Story | What happened, narrative beats |
| 7-9 | Details | Specifics most people don't know |
| 10-11 | Aftermath | Resolution and consequences |
| 12 | Echo | Modern relevance or final twist |

## Pagination System

**Location:** `MagazineScroll/Features/Reader/ArticleView.swift`

Uses UIKit text measurement for accurate page breaks:
- `measureTextWidth(_:font:)` - Measures actual text width
- `measureTextHeight(_:font:width:lineSpacing:)` - Measures text height
- `calculatePages(story:screenSize:)` - Builds pages word-by-word

**Key Constants:**
| Constant | Value |
|----------|-------|
| fontSize | 38pt |
| lineSpacing | 13.3pt |
| horizontalPadding | 24pt |
| topPadding | 80pt + 3% screen height |

---

## Recent Changes (January 2026)
- **330 stories** - Mass content expansion from 96 to 330 stories across all 10 categories
- **Homepage redesign** - Bold colorful cards with featured hero section
- **Category color system** - Each category has distinct color
- **Supabase-only** - Removed SampleData fallback, always loads from Supabase
- **Varied card styles** - Featured, tall, compact, and two-column layouts
- **Dark theme** - Article list uses dark background (#1A1A1A)
- **Personalization system** - Quiz-based preferences with up to 15 questions
- **Tag system** - Sub-category tags for fine-grained content matching
- **Dynamic homepage** - Sections adapt to user preferences
- **Discovery section** - "Try Something New" shows content outside preferences
- **30-minute refresh** - Feed regenerates after returning to app
- **READ labels** - Visual indicator for already-read articles
- **Infinite scroll** - Reader loads more stories when approaching feed end
- **Left-swipe fix** - Reader now starts at index 0 for bidirectional swiping

## Content Upload Scripts

Located in `magazine-content/scripts/`:
- `upload.mjs` - Base upload script
- `auto-tag.mjs` - Claude API script to auto-tag stories (requires ANTHROPIC_API_KEY)
- `new-content/*.mjs` - Category-specific upload scripts used for mass content creation
