/**
 * Bulk Upload Script - Uploads all stories to Supabase (Node.js version)
 *
 * Usage:
 *   cd magazine-content
 *   SUPABASE_URL=... SUPABASE_SERVICE_KEY=... node scripts/bulk-upload.mjs
 */

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error("Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_KEY");
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

// All stories data
const stories = [
  // ECONOMICS
  {
    slug: "dutch-tulip-bubble",
    title: "The Dutch Tulip Bubble",
    description: "The world's first speculative crash",
    category: "Economics",
    thumbnail_color: "#000000",
    body_text: `In February 1637, a single tulip bulb sold for more than ten times a skilled craftsman's annual salary. The flower had arrived in Europe only decades earlier, carried from the Ottoman Empire by diplomats and merchants who recognized its strange beauty. By the time it reached the Netherlands, the tulip had become something more than a flower. It was a status symbol, a marker of wealth and taste among Amsterdam's rising merchant class. The rarest varieties commanded prices that seem absurd even today. A single Semper Augustus bulb, with its distinctive crimson streaks on white petals, could purchase a grand house on Amsterdam's most fashionable canal. Speculators began trading futures contracts on bulbs still buried in the ground, buying and selling flowers that wouldn't bloom for months. Taverns became trading floors. Fortunes changed hands over drinks. Then, on February 3rd, at a routine auction in Haarlem, something unprecedented happened. The buyers simply didn't show up. Within hours, panic spread through every trading house in the country. Prices collapsed by ninety percent in a matter of days. Men who had been wealthy at breakfast found themselves ruined by dinner. The tulip crash became history's first recorded speculative bubble, a template for every financial mania that would follow. We've seen the pattern repeat with South Sea shares, railway stocks, dot-com companies, and cryptocurrency. The lesson, it seems, is one we're destined to learn again and again.`,
    design_config: {
      thumbnailColor: "#000000",
      titlePage: { backgroundColor: "#000000", textColor: "#FFD60A" },
      colorPalette: [
        { background: "#14213D", text: "#FFFFFF" },
        { background: "#FFD60A", text: "#000000" },
        { background: "#000000", text: "#FFFFFF" },
        { background: "#C4B39A", text: "#000000" },
        { background: "#E63946", text: "#FFFFFF" },
      ],
      imagePlaceholderColors: ["#FFD60A", "#E63946", "#C4B39A"],
      imageAspectRatios: [1.4, 0.75],
      imageColorOffset: 0,
      imagePositionSeed: 2,
    },
  },
  {
    slug: "south-sea-bubble",
    title: "The South Sea Bubble",
    description: "The fraud that fooled a nation",
    category: "Economics",
    thumbnail_color: "#1A237E",
    body_text: `In 1720, the British government handed a private company the exclusive right to trade with South America. The South Sea Company had no ships, no trade routes, and no realistic prospects of profit. What it did have was a brilliant scheme to convert government debt into company shares, enriching its directors while promising investors impossible returns. The company's stock price rose from £128 in January to over £1,000 by August. Servants became wealthy. Duchesses mortgaged their estates to buy more shares. Isaac Newton, the greatest scientific mind of his era, invested heavily, lost twenty thousand pounds, and reportedly said he could calculate the motion of heavenly bodies but not the madness of people. The mania spawned imitators. Companies formed to trade in human hair, to manufacture perpetual motion machines, to pursue an undertaking of great advantage but nobody to know what it is. That last one raised two thousand pounds in a single morning before its promoter fled the country. When the bubble burst in September, fortunes evaporated overnight. Suicides followed. Parliament launched an investigation that revealed systematic bribery of government officials, including the Chancellor of the Exchequer. The South Sea directors were arrested and their estates confiscated. Britain passed the Bubble Act, restricting the formation of joint-stock companies for the next century. The crash taught a harsh lesson about the dangers of speculation untethered from reality, though future generations would prove equally eager to forget it.`,
    design_config: {
      thumbnailColor: "#1A237E",
      titlePage: { backgroundColor: "#1A237E", textColor: "#FFD60A" },
      colorPalette: [
        { background: "#000000", text: "#FFFFFF" },
        { background: "#1A237E", text: "#FFFFFF" },
        { background: "#FFD60A", text: "#000000" },
        { background: "#FFFFFF", text: "#1A237E" },
        { background: "#E63946", text: "#FFFFFF" },
      ],
      imagePlaceholderColors: ["#1A237E", "#FFD60A", "#E63946"],
      imageAspectRatios: [1.4, 0.9],
      imageColorOffset: 0,
      imagePositionSeed: 2,
    },
  },
  // ... continuing with all other stories (abbreviated for this file)
];

// Full stories array - using fetch to upload
async function uploadStory(story) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/stories`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "apikey": SUPABASE_SERVICE_KEY,
      "Authorization": `Bearer ${SUPABASE_SERVICE_KEY}`,
      "Prefer": "resolution=merge-duplicates"
    },
    body: JSON.stringify({
      slug: story.slug,
      title: story.title,
      description: story.description,
      category: story.category,
      thumbnail_color: story.thumbnail_color,
      published: true,
      published_at: new Date().toISOString(),
      design_config: story.design_config,
      body_text: story.body_text,
      updated_at: new Date().toISOString(),
    })
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`${response.status}: ${text}`);
  }

  return response;
}

async function main() {
  console.log(`Starting upload of ${stories.length} stories...\n`);

  let succeeded = 0;
  let failed = 0;

  for (const story of stories) {
    process.stdout.write(`Uploading: ${story.title}... `);
    try {
      await uploadStory(story);
      console.log("Done!");
      succeeded++;
    } catch (error) {
      console.log(`Error: ${error.message}`);
      failed++;
    }
  }

  console.log(`\nComplete! ${succeeded} succeeded, ${failed} failed.`);
}

main().catch(console.error);
