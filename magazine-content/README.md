# Magazine Content

This folder contains all story content for MagazineScroll. Stories are written in Markdown and synced to Supabase.

## Quick Start

### 1. Set up Supabase
1. Create a project at [supabase.com](https://supabase.com)
2. Run the schema SQL (see `schema.sql` in this folder)
3. Create a storage bucket called `story-images` (public)
4. Copy `.env.example` to `.env` and add your credentials

### 2. Create a New Story
```bash
# Option 1: Copy template manually
cp -r templates/story-template stories/my-new-story/
# Then edit story.md and design.json

# Option 2: Use the script (coming soon)
deno task new my-new-story
```

### 3. Sync to Supabase
```bash
# Sync all stories
deno task sync

# Sync a specific story
deno task sync:story my-new-story
```

## Folder Structure

```
magazine-content/
├── stories/
│   └── [story-slug]/
│       ├── story.md        # Content with frontmatter
│       ├── design.json     # Colors and layout
│       └── images/         # Story images
├── templates/
│   ├── story-template.md
│   └── design-template.json
├── scripts/
│   └── sync.ts
├── .env                    # Your Supabase credentials (gitignored)
└── deno.json              # Script configuration
```

## Story Format

### story.md
```markdown
---
title: "Story Title"
slug: "story-slug"
description: "One-line description"
category: "Economics"
published: true
---

Your story content here...

![alt-text](images/photo.jpg "framed")

More content...
```

### Frontmatter Fields
| Field | Required | Description |
|-------|----------|-------------|
| title | Yes | Display title (max 40 chars) |
| slug | Yes | URL-safe identifier (lowercase, hyphens) |
| description | Yes | One-line hook (max 60 chars) |
| category | Yes | One of: Economics, Ancient World, Medieval, 19th Century, 20th Century, Science, Art, Crime, Exploration, War |
| published | Yes | Set to `true` when ready to publish |

### Image Syntax
```markdown
![alt-text](images/filename.jpg "style")
```
Styles: `framed`, `editorial`, `full`

### design.json
```json
{
  "thumbnailColor": "#000000",
  "titlePage": {
    "backgroundColor": "#000000",
    "textColor": "#FFD60A"
  },
  "colorPalette": [
    { "background": "#14213D", "text": "#FFFFFF" },
    { "background": "#FFD60A", "text": "#000000" }
  ],
  "imagePlaceholderColors": ["#FFD60A", "#E63946"],
  "imageAspectRatios": [1.4, 0.75],
  "imagePositionSeed": 2,
  "imageColorOffset": 0
}
```

## Categories
- `Economics` - Financial events, bubbles, crashes
- `Ancient World` - Events before 500 CE
- `Medieval` - 500-1500 CE
- `19th Century` - 1800-1899
- `20th Century` - 1900-1999
- `Science` - Scientific discoveries
- `Art` - Visual art, film, design, architecture
- `Crime` - True crime, heists, famous trials, scandals
- `Exploration` - Expeditions, discoveries, adventures
- `War` - Military conflicts

## Recommended Colors

**Dark backgrounds** (use white text):
- `#000000` Black
- `#14213D` Navy
- `#1B4332` Forest green
- `#6F4E37` Coffee
- `#E63946` Crimson
- `#7209B7` Purple

**Light backgrounds** (use dark text):
- `#FFFFFF` White
- `#FFD60A` Golden yellow
- `#C4B39A` Tan
- `#00D9FF` Cyan
