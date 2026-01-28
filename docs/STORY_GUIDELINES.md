# Story Guidelines

This document defines the rules and guidelines for creating stories in MagazineScroll. All stories must follow these standards for both content and technical implementation.

---

## Content Guidelines

### Story Selection Criteria

Stories should be:
- **Historically significant** - Real events that shaped history or culture
- **Surprising or unusual** - Events that feel almost too strange to be true
- **Self-contained** - Complete narratives that don't require prior knowledge
- **Emotionally engaging** - Stories with human drama, tragedy, or wonder

Good story topics include:
- Historical disasters and catastrophes
- Strange mass phenomena (plagues, manias, unexplained events)
- Economic bubbles and collapses
- Scientific discoveries gone wrong
- Forgotten historical events
- Unusual wars or conflicts
- Mysterious occurrences with multiple eyewitnesses

### Writing Style: "Zoom Narration"

A progressive detail approach where each scroll takes readers deeper—like Google Earth zooming from space to street level. Users can stop at any point and feel satisfied, while those who continue are rewarded with richer detail.

#### Voice and Tone
- **Narrative journalism style** - Write like a magazine feature, not a textbook
- **Present tension** - Make historical events feel immediate and urgent
- **Show, don't tell** - Use specific details rather than abstract statements
- **No hedging** - State facts confidently; avoid "perhaps" or "maybe"

#### Progressive Structure

| Pages | Section | Content | Detail Level |
|-------|---------|---------|--------------|
| 1 | **Hook** | The single most surprising fact. No context. | Minimal |
| 2-3 | **Context** | When, where, who. Set the scene. | Broad |
| 4-6 | **Story** | What happened. Narrative beats. | Building |
| 7-9 | **Details** | Specifics most people don't know. | Deep |
| 10-11 | **Aftermath** | Resolution and consequences. | Full |
| 12 | **Echo** (optional) | Modern relevance or final twist. | Reflective |

**Example progression:**
- Page 1: *"In 1518, a woman started dancing in the streets. She didn't stop for six days."*
- Page 2-3: *"It was July in Strasbourg. Her name was Frau Troffea. Within a week, thirty more had joined her."*
- Page 4-6: *"The authorities' solution was counterintuitive. They built a stage. They hired musicians."*
- Page 7-9: *"Medical records describe the symptoms. The dancers' feet bled. They begged for help but couldn't stop."*
- Page 10-11: *"By September, it was over. The dancers simply stopped. 400 afflicted. Dozens dead."*
- Page 12: *"The square where she first danced still exists. It's now a parking lot."*

#### Sentence Progression
| Story Phase | Sentence Style |
|-------------|----------------|
| Hook | Punchy, surprising, standalone |
| Context | Simple, short, clear |
| Story | Action-oriented, building |
| Details | Can be longer, more complex |
| Resolution | Definitive, satisfying |

#### Information Density
| Story Phase | Density |
|-------------|---------|
| Page 1 | One fact only |
| Pages 2-5 | One fact per 2-3 sentences |
| Pages 6+ | Denser—readers are committed |

### Word Count

- **Target**: 600-900 words per story
- **Minimum**: 500 words
- **Maximum**: 1,200 words

This length ensures:
- 8-12 pages when paginated at 38pt font
- Room for progressive detail structure
- Deep enough to reward committed readers
- Short enough for a single reading session

### Categories

Stories must belong to one category:
- `Economics` - Financial events, bubbles, crashes
- `Ancient World` - Events before 500 CE
- `Medieval` - 500-1500 CE
- `19th Century` - 1800-1899
- `20th Century` - 1900-1999
- `Science` - Scientific discoveries, experiments
- `Art` - Visual art, film, design, architecture
- `War` - Military conflicts, battles
- `Crime` - True crime, heists, famous trials, scandals
- `Exploration` - Expeditions, discoveries, adventures

---

## Technical Guidelines

### Data Model

Each story requires:

```swift
Story(
    title: String,           // Display title (max 40 chars)
    slug: String,            // URL-safe identifier (lowercase, hyphens)
    description: String,     // One-line hook (max 60 chars)
    category: String,        // One of the defined categories
    thumbnailColor: String,  // Hex color for home page card
    sections: [ContentBlock] // Story content
)
```

### Slug Format

- Lowercase letters and hyphens only
- No spaces, underscores, or special characters
- Should be readable and memorable
- Examples: `dutch-tulip-bubble`, `dancing-plague-1518`

### Content Block

Stories use a single ContentBlock containing the full text:

```swift
ContentBlock(
    position: 0,
    blockType: .text,
    textContent: "Full story text here...",
    textColor: "#FFFFFF",      // Text color (usually white or black)
    backgroundColor: "#000000"  // Background color
)
```

### Color Guidelines

#### Thumbnail Colors
Choose colors that:
- Represent the story's mood or theme
- Have sufficient contrast for white text overlay
- Are visually distinct from other stories

#### Story Design Colors
Each story needs a unique design in `ArticleView.storyDesign()`:

```swift
StoryDesign(
    titleBackground: String,           // Title page background
    titleText: String,                 // Title text color
    colorPalette: [(bg, text)],       // 5 color pairs for content pages
    imagePlaceholderColors: [String], // 3 colors for image rectangles
    imageAspectRatios: [CGFloat],     // 2 aspect ratios (landscape/portrait)
    imageColorOffset: Int,             // Offset for image color selection
    imagePositionSeed: Int             // Seed for image page positions
)
```

#### Color Palette Rules
- Use 5 background/text color pairs per story
- Ensure high contrast between background and text
- Include variety: dark, light, and accent colors
- Avoid repeating the exact same palette between stories

#### Recommended Colors

**Dark backgrounds** (use white text):
- `#000000` - Pure black
- `#14213D` - Navy blue
- `#1B4332` - Forest green
- `#4A4A4A` - Dark gray
- `#6F4E37` - Coffee brown
- `#7209B7` - Purple
- `#8B4513` - Saddle brown
- `#E63946` - Crimson red
- `#E76F51` - Burnt orange
- `#2D6A4F` - Teal green
- `#5C6BC0` - Indigo
- `#8D6E63` - Taupe

**Light backgrounds** (use dark text):
- `#FFFFFF` - White
- `#FFD60A` - Golden yellow
- `#FFB800` - Amber
- `#C4B39A` - Tan/beige
- `#00D9FF` - Cyan
- `#E8E8E8` - Light gray

### Pagination

The app automatically paginates stories using UIKit text measurement for accuracy:
- **Font size**: 38pt (fixed for all stories)
- **Line spacing**: 35% of font size (13.3pt)
- **Padding**: 24pt horizontal, dynamic top (~80pt + 3% screen height), 40pt bottom
- **Safety buffer**: 10pt to prevent text overflow
- Text flows naturally across pages using word-level splitting
- No manual page breaks needed
- See `ArticleView.swift:calculatePages()` for implementation details

### Image Placeholders

- 2-3 colored rectangles per story
- Automatically placed based on `imagePositionSeed`
- Vary between landscape (>1.0) and portrait (<1.0) aspect ratios
- Colors pulled from `imagePlaceholderColors` array

---

## Adding a New Story

### Step 1: Write the Content

1. Choose a topic following the selection criteria
2. Write 600-900 words in narrative style (see Word Count section)
3. Craft a compelling title (max 40 chars)
4. Write a one-line description (max 60 chars)
5. Assign a category

### Step 2: Add to SampleData.swift

```swift
Story(
    title: "Story Title",
    slug: "story-slug",
    description: "One-line hook",
    category: "Category",
    thumbnailColor: "#HexColor",
    sections: [
        ContentBlock(
            position: 0,
            blockType: .text,
            textContent: """
            Your story text here...
            """,
            textColor: "#FFFFFF",
            backgroundColor: "#000000"
        )
    ]
)
```

### Step 3: Add Story Design

In `ArticleView.swift`, add a case to `storyDesign(for:)`:

```swift
case "story-slug":
    return StoryDesign(
        titleBackground: "#HexColor",
        titleText: "#HexColor",
        colorPalette: [
            ("#Hex1", "#Hex2"),
            ("#Hex3", "#Hex4"),
            ("#Hex5", "#Hex6"),
            ("#Hex7", "#Hex8"),
            ("#Hex9", "#Hex10"),
        ],
        imagePlaceholderColors: ["#Hex1", "#Hex2", "#Hex3"],
        imageAspectRatios: [1.4, 0.8],
        imageColorOffset: 0,
        imagePositionSeed: 2
    )
```

### Step 4: Upload to Supabase

Run the upload script to sync with the backend:

```bash
cd magazine-content
node scripts/upload.mjs
```

### Step 5: Test

1. Build and run the app
2. Verify the story appears in the home page
3. Check category filtering works
4. Read through all pages to verify pagination
5. Ensure colors have sufficient contrast
6. Confirm no text is cut off

---

## Quality Checklist

Before submitting a new story:

### Content Quality
- [ ] Title is 40 characters or less
- [ ] Description is 60 characters or less
- [ ] Slug is lowercase with hyphens only
- [ ] Word count is 500-1,200 words
- [ ] Story follows "Zoom Narration" structure
- [ ] Category is correctly assigned
- [ ] Story is historically accurate

### Hook Quality
- [ ] First sentence creates "wait, what?" reaction
- [ ] Works as standalone social media post
- [ ] No unnecessary setup or context

### Pacing Quality
- [ ] Each page reveals something new
- [ ] No page feels like filler
- [ ] Tension builds through middle section
- [ ] Progressive detail structure is evident

### Resolution Quality
- [ ] Story has clear ending
- [ ] Reader feels satisfied, not abandoned
- [ ] No major questions left unanswered

### Technical Quality
- [ ] Thumbnail color is appropriate
- [ ] Story design has unique color palette
- [ ] All colors have sufficient contrast
- [ ] No text truncation when paginated

---

## Examples of Good Stories

### Strong Opening Hooks (One Fact Only)

**Good:**
- "In 1518, a woman started dancing in the streets. She didn't stop for six days."
- "The Australian government declared war on emus. They lost."
- "A twenty-two-foot wall of beer killed eight people in London."

**Avoid:**
- "The Dancing Plague of 1518 was a case of dancing mania that occurred in Strasbourg..." (too academic)
- "In this story, we'll explore..." (breaking fourth wall)
- "Many historians believe..." (hedging)

### Progressive Detail Example

**Page 1 (Hook):**
> "In 1986, engineers discovered that the Leaning Tower of Pisa was falling faster than expected. It would collapse within decades."

**Page 2-3 (Context):**
> "The tower had been leaning since construction began in 1173. But by the 20th century, the tilt was accelerating. Something had to be done."

**Page 4-6 (Story):**
> "Engineers proposed a radical solution: they would make the tower lean *more* before straightening it. Critics called it insane."

**Page 7-9 (Details):**
> "They extracted 38 cubic meters of soil from the north side. The process took 11 years. The tower moved millimeter by millimeter."

**Page 10-11 (Aftermath):**
> "By 2001, the tower had been stabilized. It was straighter than it had been in 200 years—but still leaning enough for tourists."

**Page 12 (Echo):**
> "Engineers estimate it will remain stable for another 200 years. The lean is now protected by law."

### Category Assignment
- Tulip bubble → Economics (financial event)
- Pompeii → Ancient World (79 CE)
- Dancing Plague → Medieval (1518)
- Radium Girls → 20th Century (1920s)
- Discovery of Penicillin → Science
- D.B. Cooper hijacking → Crime (unsolved case)
- Shackleton's Endurance → Exploration (expedition)

---

## Topic Selection Guide

### Perfect Topics
- Single events with clear drama
- Forgotten history that feels like a secret
- "The story behind the thing you know"
- First/last/only events
- Survival stories with resolution
- Unintended consequences

### Avoid
- Topics too broad (no focus)
- Topics requiring expertise (not accessible)
- Topics without narrative arc (no ending)
- Ongoing/unresolved events
- Abstract concepts without human stories

### Topic Checklist
Before writing, verify the topic has:
- [ ] A surprising hook (one "wait, what?" sentence)
- [ ] A clear narrative (beginning, middle, end)
- [ ] Specific details available (names, numbers, quotes)
- [ ] Universal accessibility (no expertise needed)
- [ ] Emotional resonance (reason to care)

---

*Last updated: January 2026*
