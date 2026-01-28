/**
 * Fix Titles Script - Updates story titles to keep subjects clear
 * Usage: SUPABASE_URL=... SUPABASE_SERVICE_KEY=... node scripts/fix-titles.mjs
 */

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_KEY");
  process.exit(1);
}

const titleUpdates = [
  { slug: "dutch-tulip-bubble", title: "The Dutch Tulip Bubble" },
  { slug: "south-sea-bubble", title: "The South Sea Bubble" },
  { slug: "mississippi-bubble", title: "The Mississippi Bubble" },
  { slug: "library-of-alexandria", title: "The Library of Alexandria" },
  { slug: "bronze-age-collapse", title: "The Bronze Age Collapse" },
  { slug: "destruction-carthage", title: "The Destruction of Carthage" },
  { slug: "siege-masada", title: "The Siege of Masada" },
  { slug: "dancing-plague-1518", title: "The Dancing Plague of 1518" },
  { slug: "childrens-crusade", title: "The Children's Crusade" },
  { slug: "black-death-arrives", title: "The Black Death Arrives" },
  { slug: "fall-constantinople", title: "The Fall of Constantinople" },
  { slug: "great-emu-war", title: "The Great Emu War" },
  { slug: "hindenburg-disaster", title: "The Hindenburg Disaster" },
  { slug: "dyatlov-pass", title: "The Dyatlov Pass Incident" },
  { slug: "year-without-summer", title: "The Year Without a Summer" },
  { slug: "london-beer-flood", title: "The London Beer Flood" },
  { slug: "molasses-flood", title: "The Great Molasses Flood" },
  { slug: "carrington-event", title: "The Carrington Event" },
  { slug: "krakatoa-eruption", title: "The Eruption of Krakatoa" },
  { slug: "first-heart-transplant", title: "The First Heart Transplant" },
  { slug: "discovery-penicillin", title: "The Discovery of Penicillin" },
  { slug: "mona-lisa-theft", title: "The Mona Lisa Theft" },
  { slug: "banksy-shredded-painting", title: "Banksy's Shredded Painting" },
  { slug: "hays-code", title: "The Hays Code" },
  { slug: "nazi-art-theft", title: "The Nazi Art Theft" },
  { slug: "apocalypse-now-making", title: "The Making of Apocalypse Now" },
  { slug: "bauhaus-school", title: "The Bauhaus School" },
  { slug: "buddhas-bamiyan", title: "The Buddhas of Bamiyan" },
];

async function updateTitle(slug, title) {
  const response = await fetch(
    `${SUPABASE_URL}/rest/v1/stories?slug=eq.${slug}`,
    {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "apikey": SUPABASE_KEY,
        "Authorization": `Bearer ${SUPABASE_KEY}`,
        "Prefer": "return=minimal"
      },
      body: JSON.stringify({ title })
    }
  );

  if (!response.ok) {
    const error = await response.text();
    throw new Error(`${response.status}: ${error}`);
  }
}

async function main() {
  console.log(`Fixing ${titleUpdates.length} story titles...\n`);

  let succeeded = 0;
  let failed = 0;

  for (const { slug, title } of titleUpdates) {
    process.stdout.write(`Updating: ${slug}... `);
    try {
      await updateTitle(slug, title);
      console.log("Done!");
      succeeded++;
    } catch (error) {
      console.log(`Error: ${error.message}`);
      failed++;
    }
  }

  console.log(`\nComplete! ${succeeded} succeeded, ${failed} failed.`);
}

main();
