/**
 * Auto-Tag Script - Uses Claude API to tag stories with sub-categories
 * Usage: ANTHROPIC_API_KEY=your_key node scripts/auto-tag.mjs
 */

import { config } from 'dotenv';
config();

const SUPABASE_URL = process.env.SUPABASE_URL || "https://egfwisgqdyhzpmeoracb.supabase.co";
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY;
const ANTHROPIC_API_KEY = process.env.ANTHROPIC_API_KEY;

if (!ANTHROPIC_API_KEY) {
  console.error("Error: ANTHROPIC_API_KEY environment variable is required");
  console.error("Usage: ANTHROPIC_API_KEY=your_key node scripts/auto-tag.mjs");
  process.exit(1);
}

// Predefined tags per category
const CATEGORY_TAGS = {
  "Art": ["renaissance", "modern", "classical", "sculpture", "painting", "architecture", "famous-artists", "art-heists", "forgeries", "lost-works", "film", "photography", "design"],
  "Crime": ["heists", "serial-killers", "unsolved", "fraud", "espionage", "organized-crime", "trials", "cold-cases"],
  "Economics": ["markets", "crashes", "trade", "currency", "corporations", "inflation", "banking", "bubbles"],
  "Science": ["physics", "biology", "space", "inventions", "medicine", "chemistry", "discoveries", "expeditions"],
  "War": ["battles", "generals", "naval", "air-combat", "resistance", "strategy", "weapons", "sieges"],
  "Exploration": ["arctic", "ocean", "space", "lost-cities", "expeditions", "mapping", "survival", "mountaineering"],
  "Ancient World": ["rome", "greece", "egypt", "mesopotamia", "mythology", "archaeology", "empires", "disasters"],
  "Medieval": ["crusades", "castles", "plague", "knights", "monarchy", "religion", "byzantium", "vikings"],
  "19th Century": ["industrial", "colonial", "victorian", "revolution", "westward", "disasters", "inventions"],
  "20th Century": ["wwi", "wwii", "cold-war", "civil-rights", "technology", "space-race", "disasters", "mysteries"]
};

async function fetchAllStories() {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/stories?select=id,title,slug,category,body_text,tags&published=eq.true`, {
    headers: {
      "apikey": SUPABASE_KEY,
      "Authorization": `Bearer ${SUPABASE_KEY}`
    }
  });

  if (!response.ok) {
    throw new Error(`Failed to fetch stories: ${response.status}`);
  }

  return response.json();
}

async function tagStoryWithClaude(story) {
  const category = story.category || "Unknown";
  const availableTags = CATEGORY_TAGS[category] || [];

  if (availableTags.length === 0) {
    console.log(`  No tags defined for category: ${category}`);
    return [];
  }

  const prompt = `You are tagging a magazine article for a personalization system. Based on the title and first 500 characters of content, select 2-4 tags that best describe the article's specific focus.

Category: ${category}
Available tags for this category: ${availableTags.join(", ")}

Title: ${story.title}
Content preview: ${(story.body_text || "").substring(0, 500)}

Return ONLY a JSON array of 2-4 tags from the available list. Example: ["tag1", "tag2", "tag3"]
Do not include any explanation, just the JSON array.`;

  const response = await fetch("https://api.anthropic.com/v1/messages", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "x-api-key": ANTHROPIC_API_KEY,
      "anthropic-version": "2023-06-01"
    },
    body: JSON.stringify({
      model: "claude-3-5-haiku-20241022",
      max_tokens: 100,
      messages: [
        { role: "user", content: prompt }
      ]
    })
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Claude API error: ${response.status} - ${text}`);
  }

  const result = await response.json();
  const content = result.content[0].text.trim();

  try {
    const tags = JSON.parse(content);
    // Validate tags are from available list
    return tags.filter(tag => availableTags.includes(tag));
  } catch {
    console.log(`  Failed to parse tags: ${content}`);
    return [];
  }
}

async function updateStoryTags(storyId, tags) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/stories?id=eq.${storyId}`, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      "apikey": SUPABASE_KEY,
      "Authorization": `Bearer ${SUPABASE_KEY}`,
      "Prefer": "return=minimal"
    },
    body: JSON.stringify({
      tags: tags,
      updated_at: new Date().toISOString()
    })
  });

  if (!response.ok) {
    const text = await response.text();
    throw new Error(`Failed to update story: ${response.status} - ${text}`);
  }
}

async function main() {
  console.log("Fetching stories from Supabase...\n");

  const stories = await fetchAllStories();
  console.log(`Found ${stories.length} stories\n`);

  // Filter to stories without tags
  const untaggedStories = stories.filter(s => !s.tags || s.tags.length === 0);
  console.log(`${untaggedStories.length} stories need tagging\n`);

  let success = 0;
  let failed = 0;

  for (const story of untaggedStories) {
    try {
      process.stdout.write(`Tagging: ${story.title.substring(0, 40)}... `);

      const tags = await tagStoryWithClaude(story);

      if (tags.length > 0) {
        await updateStoryTags(story.id, tags);
        console.log(`[${tags.join(", ")}]`);
        success++;
      } else {
        console.log("(no tags found)");
      }

      // Rate limiting - wait 200ms between requests
      await new Promise(r => setTimeout(r, 200));

    } catch (error) {
      console.log(`Error: ${error.message}`);
      failed++;
    }
  }

  console.log(`\nComplete! ${success} tagged, ${failed} failed.`);
}

main().catch(console.error);
