# MagazineScroll Personalization System

This document describes the personalization system that customizes the reading experience based on user preferences and behavior.

## Overview

The personalization system consists of:
1. **Onboarding Quiz** - Collects user preferences through an interactive questionnaire
2. **Tag System** - Sub-category tags for fine-grained content matching
3. **PersonalizationEngine** - Scores and ranks stories based on preferences
4. **Dynamic Homepage** - Adapts content presentation to user preferences
5. **Hybrid Infinite Scroll** - Continuously loads personalized content in the reader

---

## Quiz Flow

### Question Structure

The quiz has a dynamic structure with 5-15 questions depending on user selections:

| Question | ID | Type | Always Shown |
|----------|-----|------|--------------|
| Topic Selection | 1 | categoryGrid | Yes |
| Era Preference | 2 | singleChoice | Yes |
| Content Tone | 3 | singleChoice | Yes |
| Economics vs Art | 4 | comparison | Only if both selected in Q1 |
| Medieval vs 20th Century | 5 | comparison | Only if both selected in Q1 |
| Ancient vs 19th Century | 6 | comparison | Only if both selected in Q1 |
| Discovery Mode | 7 | singleChoice | Yes |
| Exploration vs War | 8 | comparison | Only if both selected in Q1 |
| Crime vs Science | 9 | comparison | Only if both selected in Q1 |
| Category Follow-ups | 101-110 | categoryGrid | One per selected category |
| Reading Goal | 10 | singleChoice | Yes (last) |

### Category Follow-up Questions (Q101-Q110)

Each category has a dedicated follow-up question with 4-6 tag options:

| Question ID | Category | Example Tags |
|-------------|----------|--------------|
| 101 | Art | renaissance, modern, sculpture, art-heists |
| 102 | Crime | heists, serial-killers, unsolved, espionage |
| 103 | Economics | crashes, trade, currency, markets |
| 104 | Science | physics, medicine, space, inventions |
| 105 | War | battles, generals, naval, resistance |
| 106 | Exploration | arctic, ocean, lost-cities, survival |
| 107 | Ancient World | rome, greece, egypt, mythology |
| 108 | Medieval | crusades, castles, plague, monarchy |
| 109 | 19th Century | industrial, colonial, victorian, disasters |
| 110 | 20th Century | wwi, wwii, cold-war, space-race |

### Question Count Logic

- **Minimum:** 5 questions (Q1, Q2, Q3, Q7, Q10)
- **Maximum:** 15 questions (5 core + up to 10 category follow-ups)
- **Typical:** 8-10 questions (3-5 categories selected)

---

## User Preferences Model

```swift
struct UserPreferences: Codable, Equatable {
    // Core quiz answers
    var selectedCategories: [String]       // From Q1
    var eraPreference: EraPreference       // From Q2
    var contentTone: ContentTone           // From Q3
    var discoveryMode: DiscoveryMode       // From Q7
    var readingGoal: ReadingGoal           // From Q10

    // Comparison answers (Q4-Q9)
    var economicsVsArt: ContentPreference
    var medievalVs20th: ContentPreference
    var ancientVs19th: ContentPreference
    var explorationVsWar: ContentPreference
    var crimeVsScience: ContentPreference

    // Tag preferences from follow-ups
    var selectedTags: [String]

    var hasCompletedOnboarding: Bool
    var lastUpdated: Date
}
```

### Computed Properties

- **preferredCategories** - All categories derived from quiz answers
- **categoryWeight(for:)** - Returns 0.0-1.0 weight for a category
- **tagWeight(for:)** - Returns 0.0-1.0 weight for a tag
- **varietyFactor** - How much randomness to inject (based on discoveryMode)

---

## Tag System

### Story Tags

Stories in Supabase have a `tags` array field containing 2-4 sub-category tags:

```sql
ALTER TABLE stories ADD COLUMN tags TEXT[] DEFAULT '{}';
```

### Auto-Tagging Script

The `magazine-content/scripts/auto-tag.mjs` script uses Claude API to automatically tag stories:

```bash
ANTHROPIC_API_KEY=your_key node scripts/auto-tag.mjs
```

### Predefined Tags per Category

| Category | Available Tags |
|----------|---------------|
| Art | renaissance, modern, classical, sculpture, painting, architecture, famous-artists, art-heists, forgeries, lost-works, film, photography, design |
| Crime | heists, serial-killers, unsolved, fraud, espionage, organized-crime, trials, cold-cases |
| Economics | markets, crashes, trade, currency, corporations, inflation, banking, bubbles |
| Science | physics, biology, space, inventions, medicine, chemistry, discoveries, expeditions |
| War | battles, generals, naval, air-combat, resistance, strategy, weapons, sieges |
| Exploration | arctic, ocean, space, lost-cities, expeditions, mapping, survival, mountaineering |
| Ancient World | rome, greece, egypt, mesopotamia, mythology, archaeology, empires, disasters |
| Medieval | crusades, castles, plague, knights, monarchy, religion, byzantium, vikings |
| 19th Century | industrial, colonial, victorian, revolution, westward, disasters, inventions |
| 20th Century | wwi, wwii, cold-war, civil-rights, technology, space-race, disasters, mysteries |

---

## PersonalizationEngine

### Scoring Formula

Stories are scored using weighted factors (must sum to 100):

| Factor | Weight | Description |
|--------|--------|-------------|
| Category Match | 25% | How well story category matches preferences |
| Tag Match | 15% | How many story tags match selected tags |
| Era Match | 15% | Alignment with ancient/modern preference |
| Tone | 10% | Content tone matching (placeholder) |
| Recency | 10% | Newer stories get a boost |
| Variety | 10% | Underexplored categories get a boost |
| Like Boost | 15% | Categories user has liked get priority |

### Tag Match Scoring

```swift
private static func tagMatchScore(story: Story, preferences: UserPreferences) -> Double {
    let storyTags = story.tags ?? []
    let matchCount = storyTags.filter { preferences.selectedTags.contains($0) }.count

    if matchCount == 0 { return 0.3 }  // No matches
    if matchCount == 1 { return 0.7 }  // One match
    return 1.0  // 2+ matches
}
```

### Read Article Penalty

Already-read articles receive a 70% score penalty (`score *= 0.3`) to prioritize unread content while keeping them accessible.

### Variety Injection

Based on `discoveryMode`:
- **Comfort Zone:** 10% chance of random selection from top 10
- **Balanced:** 25% chance
- **Surprise Me:** 40% chance

---

## Homepage Generation

### Dynamic Sections

1. **Featured Card** - Top personalized story (excludes read)
2. **Article List** - Remaining personalized stories with varied card styles
3. **Discovery Section** - 5 stories OUTSIDE user preferences
4. **Category Section** - Horizontal scroll of user's top preferred category

### 30-Minute Refresh

The homepage regenerates the feed if 30+ minutes have passed since the last refresh:

```swift
private func checkAndRefresh() {
    let timeSinceLastRefresh = Date().timeIntervalSince(lastRefreshTime)
    if timeSinceLastRefresh >= 1800 {  // 30 minutes
        lastRefreshTime = Date()
        generatePersonalizedFeed()
    }
}
```

### READ Labels

All card components display a "READ" label overlay for previously read stories:
- FeaturedCard
- TallCard
- MediumCard
- SquareCard
- WideCard

---

## Reader Feed Population

### Initial Feed

When opening from homepage:
- Uses personalized feed from homepage
- Starts at the tapped story's index

When using "Read" button (middle tab):
- Generates fresh personalized feed of 20 stories
- Always starts at index 0 (first story)
- Ensures content available for swiping in both directions

### Hybrid Infinite Scroll

When user approaches end of feed (2 stories remaining):

```swift
private func loadMoreStories() {
    // Get more personalized stories excluding current feed
    var moreStories = PersonalizationEngine.personalizedFeed(
        stories: allStories.filter { !currentFeed.contains($0) },
        limit: 10,
        excludeRead: false
    )

    // Mix in discovery for "surprise me" users
    if preferences.discoveryMode == .surpriseMe {
        let discovery = stories.outside(preferences).shuffled().prefix(3)
        moreStories.append(contentsOf: discovery)
        moreStories.shuffle()
    }

    feedStories.append(contentsOf: moreStories)
}
```

---

## CloudKit Sync

User preferences and reading stats sync to iCloud:

### Synced Data
- `UserPreferences` - Quiz answers and tag selections
- `ReadingStats` - Read/liked articles, category counts, streaks
- `savedStoryIDs` - Bookmarked stories

### Sync Behavior
- Local-first with async cloud sync
- Debounced saves (0.5s) to prevent excessive writes
- Merge on cloud fetch (newer preferences win, stats union)

---

## Implementation Files

| File | Purpose |
|------|---------|
| `Models/UserPreferences.swift` | Preferences data model |
| `Models/QuizQuestion.swift` | Quiz questions including follow-ups |
| `Models/ReadingStats.swift` | Reading history tracking |
| `Models/Story.swift` | Story model with tags |
| `Features/Onboarding/OnboardingViewModel.swift` | Quiz flow logic |
| `Services/PersonalizationEngine.swift` | Scoring and ranking |
| `Services/CloudKitManager.swift` | Preference persistence |
| `Features/Home/HomeView.swift` | Dynamic homepage |
| `Features/Reader/ReaderView.swift` | Infinite scroll reader |

---

## Verification Checklist

1. **Quiz** - Delete app, reinstall, select 3 categories → see follow-up questions
2. **Tags** - Query Supabase, confirm stories have tags array
3. **Homepage** - Horizontal section shows preferred category, not hardcoded
4. **Discovery** - "Try Something New" shows non-preferred content
5. **Refresh** - Leave app 30+ min, return → feed regenerated
6. **READ labels** - Read an article → "READ" badge visible on card
7. **Infinite scroll** - Swipe through 10+ articles → more load automatically
8. **Surprise users** - Set "surprise me" → discovery content in reader feed
