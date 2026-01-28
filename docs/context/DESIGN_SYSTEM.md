# Design System

## Typography

### Font Family
- **Inter Black** (900): Primary text for slides
- **Inter ExtraBold** (800): Secondary labels

### Dynamic Sizing
Base size: 7.5% of screen height

| Word Count | Multiplier | Example Size (844pt height) |
|------------|------------|------------------------------|
| 1-3 words  | 1.6x       | ~101pt                       |
| 4-8 words  | 1.3x       | ~82pt                        |
| 9-15 words | 1.0x       | ~63pt                        |
| 16-22 words| 0.85x      | ~54pt                        |
| 23+ words  | 0.7x       | ~44pt                        |

### Letter Spacing
- Short text (≤5 words): 0.8% of screen width
- Longer text: No additional tracking

## Colors

### Bold Palette
| Name   | Hex     | Usage                    |
|--------|---------|--------------------------|
| Red    | #E63946 | High impact statements   |
| Blue   | #1D3557 | Calm, trustworthy        |
| Green  | #2D6A4F | Nature, growth           |
| Orange | #E76F51 | Energy, warmth           |
| Purple | #7209B7 | Creative, premium        |

### Neutral Palette
| Name      | Hex     | Usage                  |
|-----------|---------|------------------------|
| Black     | #0D0D0D | Primary dark           |
| White     | #FAFAFA | Primary light          |
| Warm Gray | #8D8D8D | Subtle elements        |
| Cool Gray | #6C757D | Secondary elements     |

### Earthy Palette
| Name   | Hex     | Usage                    |
|--------|---------|--------------------------|
| Brown  | #6F4E37 | Grounded, organic        |
| Forest | #1B4332 | Deep, natural            |
| Navy   | #14213D | Professional, serious    |

### Text Colors
- On dark backgrounds: Pure white (#FFFFFF)
- On light backgrounds: Near black (#0D0D0D)
- Automatic detection based on luminance

## Spacing

### Base Unit
8pt grid system

| Token | Value | Usage                |
|-------|-------|----------------------|
| xxs   | 4pt   | Tight spacing        |
| xs    | 8pt   | Default small        |
| sm    | 12pt  | Medium small         |
| md    | 16pt  | Default medium       |
| lg    | 24pt  | Default large        |
| xl    | 32pt  | Extra large          |
| xxl   | 48pt  | Maximum spacing      |

### Slide Padding
Horizontal: 6% of screen width

### Grid Spacing
- Column gap: 16pt
- Row gap: 16pt
- Card padding: 20pt

## Layout

### Slide Aspect Ratio
Full viewport (1:1 with screen)

### Card Aspect Ratio
3:4 (portrait)

### Image Layouts
- **Full Bleed**: Edge to edge, fills frame
- **Editorial**: 65% width, centered, rounded corners
- **Inset**: 80% max width, maintains aspect ratio
