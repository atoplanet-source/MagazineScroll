/**
 * Update Titles Script - Updates story titles in Supabase
 * Usage: SUPABASE_URL=... SUPABASE_SERVICE_KEY=... node scripts/update-titles.mjs
 */

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_KEY");
  process.exit(1);
}

const titleUpdates = [
  { slug: "dutch-tulip-bubble", title: "When Tulips Cost More Than Houses" },
  { slug: "south-sea-bubble", title: "Britain's Great Fraud of 1720" },
  { slug: "mississippi-bubble", title: "How One Man Bankrupted France" },
  { slug: "library-of-alexandria", title: "Alexandria's Lost Library" },
  { slug: "bronze-age-collapse", title: "When Civilization Collapsed" },
  { slug: "destruction-carthage", title: "Rome's Final Revenge on Carthage" },
  { slug: "siege-masada", title: "Masada's Last Stand" },
  { slug: "dancing-plague-1518", title: "400 People Danced to Death" },
  { slug: "childrens-crusade", title: "Children Who Marched to Jerusalem" },
  { slug: "black-death-arrives", title: "Europe's Deadliest Year" },
  { slug: "fall-constantinople", title: "Constantinople's Final Hours" },
  { slug: "great-emu-war", title: "Australia Lost a War to Birds" },
  { slug: "hindenburg-disaster", title: "37 Seconds That Ended an Era" },
  { slug: "dyatlov-pass", title: "Nine Hikers, No Answers" },
  { slug: "year-without-summer", title: "1816: Summer Never Came" },
  { slug: "london-beer-flood", title: "Death by Beer Tsunami" },
  { slug: "molasses-flood", title: "Boston's Strangest Disaster" },
  { slug: "carrington-event", title: "When the Sun Nearly Fried Earth" },
  { slug: "krakatoa-eruption", title: "Krakatoa: Loudest Sound in History" },
  { slug: "first-heart-transplant", title: "18 Days with a New Heart" },
  { slug: "discovery-penicillin", title: "A Moldy Dish Saved Millions" },
  { slug: "mona-lisa-theft", title: "How the Mona Lisa Got Famous" },
  { slug: "banksy-shredded-painting", title: "Banksy's Painting Shredded Itself" },
  { slug: "hays-code", title: "Hollywood's 34 Years of Censorship" },
  { slug: "nazi-art-theft", title: "History's Greatest Art Heist" },
  { slug: "apocalypse-now-making", title: "Apocalypse Now Nearly Killed Coppola" },
  { slug: "bauhaus-school", title: "14 Years That Shaped Modern Design" },
  { slug: "buddhas-bamiyan", title: "1,500 Years of History, Destroyed" },
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
  console.log(`Updating ${titleUpdates.length} story titles...\\n`);

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

  console.log(`\\nComplete! ${succeeded} succeeded, ${failed} failed.`);
}

main();
