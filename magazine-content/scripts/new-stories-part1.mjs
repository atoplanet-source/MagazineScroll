/**
 * New Stories Part 1 - Exploration Category (10 stories)
 * Usage: SUPABASE_URL=... SUPABASE_SERVICE_KEY=... node scripts/new-stories-part1.mjs
 */

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_KEY");
  process.exit(1);
}

const stories = [
  {
    slug: "race-south-pole",
    title: "The Race to the South Pole",
    description: "Two explorers, one frozen finish line",
    category: "Exploration",
    thumbnail_color: "#1565C0",
    body_text: "In 1911, two expeditions raced across Antarctica toward the same goal: the South Pole. Norwegian Roald Amundsen led one team. British naval officer Robert Falcon Scott led the other. Only one would return triumphant. Amundsen had spent years living with Inuit peoples, learning to drive dog sleds and survive polar conditions. Scott believed in man-hauling—teams of men dragging their own supplies across the ice. It was a matter of honor, he felt, to suffer for glory. Amundsen reached the pole on December 14, 1911. His team was healthy, well-fed, and ahead of schedule. They planted the Norwegian flag and left a tent with a letter for Scott, just in case. Scott arrived thirty-four days later, on January 17, 1912. The Norwegian flag was already there. 'Great God!' he wrote in his diary. 'This is an awful place.' The return journey destroyed Scott's team. They ran low on food. Temperatures plunged to forty below. Frostbite claimed fingers and toes. One man walked into a blizzard rather than slow down his companions. Scott and his last two men died in their tent, eleven miles from a supply depot. Their bodies were found eight months later, along with Scott's diaries. Britain mourned him as a hero who embodied noble failure. Amundsen, who had actually succeeded, received a cooler reception. The world preferred tragedy to competence. Today, both men are remembered—Scott for his courage, Amundsen for his skill. The pole they fought to reach is now home to a permanent research station with heated buildings and internet access.",
    design_config: {"thumbnailColor":"#1565C0","titlePage":{"backgroundColor":"#1565C0","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#1565C0","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#1565C0"},{"background":"#E8E8E8","text":"#000000"},{"background":"#37474F","text":"#FFFFFF"}],"imagePlaceholderColors":["#1565C0","#37474F","#E8E8E8"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "kon-tiki-expedition",
    title: "The Kon-Tiki Expedition",
    description: "A balsa wood raft across the Pacific",
    category: "Exploration",
    thumbnail_color: "#FF8F00",
    body_text: "In 1947, Thor Heyerdahl set out to prove that ancient South Americans could have settled Polynesia. The scientific establishment called his theory impossible—the Pacific was too vast, the technology too primitive. Heyerdahl decided to demonstrate it himself. He built a raft from balsa wood logs, using only materials and techniques available to pre-Columbian peoples. No nails, no modern cordage, no engine. The raft was named Kon-Tiki after an Incan sun god. On April 28, six men pushed off from the coast of Peru. The experts predicted they would sink within weeks. For 101 days, the Kon-Tiki drifted west across 4,300 miles of open ocean. The crew caught fish, collected rainwater, and fought off sharks that circled the raft at night. They had no way to steer—they simply went where the currents and winds took them. On August 7, the raft struck a reef in French Polynesia. All six men survived. The voyage proved that the journey was physically possible, though it didn't prove that ancient peoples had actually made it. Archaeologists and geneticists later confirmed that Polynesians came from Asia, not South America. Heyerdahl was wrong about the history. But the Kon-Tiki expedition captured the world's imagination. The documentary film won an Academy Award. The raft itself sits in a museum in Oslo, a testament to what determination and balsa wood can achieve.",
    design_config: {"thumbnailColor":"#FF8F00","titlePage":{"backgroundColor":"#FF8F00","textColor":"#000000"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#FF8F00","text":"#000000"},{"background":"#FFFFFF","text":"#FF8F00"},{"background":"#1565C0","text":"#FFFFFF"},{"background":"#4E342E","text":"#FFFFFF"}],"imagePlaceholderColors":["#FF8F00","#1565C0","#4E342E"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "tutankhamun-tomb",
    title: "The Discovery of Tutankhamun's Tomb",
    description: "The boy king who waited 3,000 years",
    category: "Exploration",
    thumbnail_color: "#FFD700",
    body_text: "Howard Carter had been searching the Valley of the Kings for six years when his patron, Lord Carnarvon, announced he was cutting off funding. Carter begged for one more season. Carnarvon reluctantly agreed to finance a final dig. On November 4, 1922, a water boy stumbled upon a stone step buried in the sand. Carter's team excavated carefully, revealing a staircase descending into the bedrock. At the bottom was a sealed door covered in ancient plaster. Carter made a small hole and held up a candle. 'Can you see anything?' Carnarvon asked. 'Yes,' Carter replied. 'Wonderful things.' The tomb of Tutankhamun was the most intact royal burial ever found in Egypt. Robbers had entered in antiquity but had been interrupted before taking much. The chambers overflowed with treasures: golden shrines, jeweled thrones, alabaster vessels, chariots, beds, and the famous golden death mask weighing twenty-four pounds. The excavation took ten years. Each object had to be photographed, cataloged, and preserved before removal. Carter worked with obsessive care, knowing he had one chance to record everything properly. The discovery made Tutankhamun the most famous pharaoh in history, though in his own time he was a minor king who died at nineteen. His tomb's survival was an accident of geography—later construction buried the entrance, hiding it from robbers for three millennia.",
    design_config: {"thumbnailColor":"#FFD700","titlePage":{"backgroundColor":"#FFD700","textColor":"#000000"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"},{"background":"#4E342E","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#4E342E"},{"background":"#1A237E","text":"#FFFFFF"}],"imagePlaceholderColors":["#FFD700","#4E342E","#1A237E"],"imageAspectRatios":[1.3,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "lewis-clark-expedition",
    title: "The Lewis and Clark Expedition",
    description: "Mapping the unknown American West",
    category: "Exploration",
    thumbnail_color: "#2E7D32",
    body_text: "In 1804, Meriwether Lewis and William Clark led thirty-three men into territory no American had ever mapped. President Jefferson had just purchased the Louisiana Territory from France—828,000 square miles of wilderness that doubled the nation's size. Nobody knew what was out there. The Corps of Discovery traveled by boat up the Missouri River, then crossed the Rocky Mountains on foot and horseback. They encountered grizzly bears, nearly starved in the mountains, and depended on the guidance of Sacagawea, a teenage Shoshone woman who had been kidnapped by a rival tribe years earlier. She recognized landmarks and translated when the expedition met her people. The journey took two years and four months. Lewis and Clark filled journals with observations about plants, animals, and native peoples that Europeans had never documented. They discovered 178 plant species and 122 animal species unknown to Western science. Only one man died during the expedition, probably from appendicitis. When they returned to St. Louis in September 1806, people assumed they had perished. The expedition had been out of contact for so long that newspapers had printed their obituaries. Their maps and journals opened the West to American expansion, for better and worse. Within decades, settlers would flood across the same routes, transforming the landscape and displacing the peoples who had guided Lewis and Clark to safety.",
    design_config: {"thumbnailColor":"#2E7D32","titlePage":{"backgroundColor":"#2E7D32","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#2E7D32","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#2E7D32"},{"background":"#4E342E","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"}],"imagePlaceholderColors":["#2E7D32","#4E342E","#FFD700"],"imageAspectRatios":[1.6,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "first-everest-summit",
    title: "The First Everest Summit",
    description: "29,032 feet and nowhere left to climb",
    category: "Exploration",
    thumbnail_color: "#37474F",
    body_text: "At 11:30 a.m. on May 29, 1953, Edmund Hillary and Tenzing Norgay became the first humans to stand on the summit of Mount Everest. They stayed for fifteen minutes, just long enough to take photographs and bury some chocolates in the snow as an offering. The mountain had killed eleven climbers in previous attempts. Hillary, a New Zealand beekeeper, and Tenzing, a Nepali Sherpa, were part of a massive British expedition with over four hundred porters and tons of equipment. They established camps progressively higher on the mountain, waiting for weather windows and acclimatizing to the thin air. The final push began from a camp at 27,900 feet. Hillary and Tenzing climbed through the night with bottled oxygen, facing temperatures of forty below zero. Near the summit, they encountered a forty-foot rock face that seemed impassable. Hillary found a crack between the rock and ice, wedged himself in, and inched upward. That obstacle is still called the Hillary Step. When they reached the top, Tenzing unfurled flags of Britain, Nepal, India, and the United Nations. Hillary took photographs of Tenzing posing with his ice axe—but Tenzing didn't know how to operate the camera, so no photograph exists of Hillary on the summit. News of their success reached London on the morning of Queen Elizabeth II's coronation, adding to the celebration. Hillary was knighted; Tenzing received the George Medal. Both refused to say who had actually stepped on the summit first. 'We reached it together,' they insisted until they died.",
    design_config: {"thumbnailColor":"#37474F","titlePage":{"backgroundColor":"#37474F","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#37474F","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#37474F"},{"background":"#1565C0","text":"#FFFFFF"},{"background":"#E8E8E8","text":"#000000"}],"imagePlaceholderColors":["#37474F","#1565C0","#E8E8E8"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "magellan-circumnavigation",
    title: "Magellan's Circumnavigation",
    description: "Around the world, though he didn't survive it",
    category: "Exploration",
    thumbnail_color: "#1A237E",
    body_text: "Ferdinand Magellan set out to find a western route to the Spice Islands. He ended up proving the Earth was round—though he died before completing the journey. In 1519, five ships and 270 men left Spain sailing west. Magellan was Portuguese, but Portugal had rejected his proposal, so he sailed under the Spanish flag. The voyage was brutal from the start. One ship was lost in a storm. Another turned back. The remaining three spent thirty-eight days navigating the treacherous strait at South America's southern tip that now bears Magellan's name. They emerged into a vast, calm ocean Magellan named the Pacific. He thought Asia was nearby. He was wrong. For ninety-eight days they sailed without sight of land, drinking putrid water and eating sawdust and leather. Nineteen men died of scurvy. When they finally reached the Philippines in 1521, Magellan intervened in a local conflict and was killed in battle. The survivors pressed on. Of the original five ships and 270 men, one ship and eighteen men returned to Spain in September 1522, becoming the first humans to circumnavigate the globe. The spices they carried in their hold were valuable enough to make the entire expedition profitable despite the catastrophic losses. Magellan became famous for a voyage he never completed, while Juan Sebastián Elcano, who actually brought the ship home, remains largely forgotten.",
    design_config: {"thumbnailColor":"#1A237E","titlePage":{"backgroundColor":"#1A237E","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#1A237E","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#1A237E"},{"background":"#FF8F00","text":"#000000"},{"background":"#4E342E","text":"#FFFFFF"}],"imagePlaceholderColors":["#1A237E","#FF8F00","#4E342E"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "northwest-passage",
    title: "The Search for the Northwest Passage",
    description: "Centuries of frozen failure",
    category: "Exploration",
    thumbnail_color: "#4FC3F7",
    body_text: "For four centuries, explorers sought a sea route through the Arctic connecting the Atlantic and Pacific oceans. They called it the Northwest Passage, and its discovery promised to revolutionize global trade. Instead, it consumed ships and lives by the hundreds. The search began in 1497 when John Cabot sailed west from England. Each expedition probed further into the frozen labyrinth of Canada's Arctic islands, mapping dead ends and leaving graves on desolate shores. The worst disaster came in 1845 when Sir John Franklin led 129 men into the Arctic aboard two ships equipped with the latest technology. They vanished completely. Search parties spent years looking for survivors, eventually finding evidence of starvation, disease, and cannibalism. Every man had perished. The passage was finally navigated in 1906 by Roald Amundsen in a small fishing boat with a crew of six. It took three years. The route was commercially useless—too shallow, too frozen, too dangerous. For all those deaths, the Northwest Passage remained a curiosity rather than a shipping lane. Climate change is writing a different ending. As Arctic ice melts, the passage opens for longer periods each year. Ships now transit routinely in summer. The route that killed hundreds of explorers is becoming a normal shipping lane, though the bodies of Franklin's crew remain where they fell, preserved in permafrost.",
    design_config: {"thumbnailColor":"#4FC3F7","titlePage":{"backgroundColor":"#4FC3F7","textColor":"#000000"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#4FC3F7","text":"#000000"},{"background":"#FFFFFF","text":"#1565C0"},{"background":"#1A237E","text":"#FFFFFF"},{"background":"#37474F","text":"#FFFFFF"}],"imagePlaceholderColors":["#4FC3F7","#1A237E","#37474F"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "voyage-of-beagle",
    title: "The Voyage of the Beagle",
    description: "The trip that changed biology forever",
    category: "Exploration",
    thumbnail_color: "#8D6E63",
    body_text: "Charles Darwin was twenty-two years old and violently seasick when HMS Beagle set sail in 1831. He had signed on as a gentleman companion for the captain, with permission to collect specimens along the way. The voyage was supposed to last two years. It lasted five. The Beagle charted the coast of South America while Darwin explored on land, collecting fossils, birds, plants, and insects. In Argentina he found the bones of giant ground sloths. In Chile he experienced an earthquake that raised the coastline several feet. In the Galápagos Islands he noticed that finches on different islands had differently shaped beaks. Darwin didn't understand what he was seeing at first. The theory of evolution by natural selection took years to develop after his return. He filled notebooks with ideas, consulted with pigeon breeders and botanists, and delayed publication for two decades. When 'On the Origin of Species' finally appeared in 1859, it transformed our understanding of life on Earth. The voyage of the Beagle gave Darwin the evidence he needed to overturn centuries of belief about creation and the fixity of species. The seasick young man had seen the world with fresh eyes and returned with questions that changed science forever. His specimen collections remain in museums, still studied by researchers working out the implications of what he observed.",
    design_config: {"thumbnailColor":"#8D6E63","titlePage":{"backgroundColor":"#8D6E63","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#8D6E63","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#8D6E63"},{"background":"#2E7D32","text":"#FFFFFF"},{"background":"#4E342E","text":"#FFFFFF"}],"imagePlaceholderColors":["#8D6E63","#2E7D32","#4E342E"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "discovery-machu-picchu",
    title: "The Discovery of Machu Picchu",
    description: "The lost city that was never lost",
    category: "Exploration",
    thumbnail_color: "#6D4C41",
    body_text: "When Hiram Bingham III reached Machu Picchu in 1911, he thought he had discovered a lost city. Local farmers had been growing crops among the ruins for generations. The Incan citadel had never been truly forgotten—just overlooked by outsiders. Bingham was a Yale professor searching for Vilcabamba, the last refuge of the Incan resistance against Spanish conquest. A local farmer mentioned ruins on a nearby ridge and offered to guide him up. Bingham climbed through thick jungle and emerged onto terraces of precisely fitted stone. A resident family served him lunch. Machu Picchu wasn't what Bingham was looking for. Built around 1450, it was likely a royal estate for the Incan emperor Pachacuti, abandoned before the Spanish conquest for reasons unknown. Its location—on a narrow ridge between two peaks, invisible from below—had protected it from Spanish destruction. Bingham cleared the vegetation, mapped the site, and brought artifacts back to Yale. He wrote articles and books that made Machu Picchu famous worldwide. The 'lost city of the Incas' became one of the world's most recognizable archaeological sites. Peru later sued Yale to recover the artifacts, finally succeeding in 2011. Today nearly a million tourists visit annually, so many that the government has imposed strict limits. The city that was never truly lost is now in danger of being loved to death.",
    design_config: {"thumbnailColor":"#6D4C41","titlePage":{"backgroundColor":"#6D4C41","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#6D4C41","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#6D4C41"},{"background":"#2E7D32","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"}],"imagePlaceholderColors":["#6D4C41","#2E7D32","#FFD700"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "apollo-11-moon-landing",
    title: "The Apollo 11 Moon Landing",
    description: "One giant leap, 238,900 miles from home",
    category: "Exploration",
    thumbnail_color: "#212121",
    body_text: "On July 20, 1969, Neil Armstrong and Buzz Aldrin became the first humans to walk on the Moon. Michael Collins orbited above, alone in the command module, the loneliest human in history—cut off from radio contact with Earth each time he passed behind the lunar surface. The landing almost didn't happen. As the lunar module Eagle descended, alarms blared. The onboard computer was overloaded. Mission control had seconds to decide whether to abort. A twenty-six-year-old engineer recognized the alarm as non-critical and called 'Go.' Armstrong took manual control when the designated landing site turned out to be a boulder field. He flew horizontally, searching for clear ground, while fuel ran low. When Eagle finally touched down, only twenty-five seconds of fuel remained. 'Houston, Tranquility Base here. The Eagle has landed.' Six hundred million people watched on television as Armstrong climbed down the ladder. 'That's one small step for man, one giant leap for mankind.' He and Aldrin spent two and a half hours on the surface, planting a flag, collecting rocks, and taking photographs. The plaque they left reads: 'We came in peace for all mankind.' Five more Apollo missions landed on the Moon. Twelve men walked on its surface. Then the program ended, and no human has returned since 1972. The footprints Armstrong and Aldrin left are still there, undisturbed in the airless vacuum, waiting.",
    design_config: {"thumbnailColor":"#212121","titlePage":{"backgroundColor":"#212121","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#212121","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#212121"},{"background":"#1565C0","text":"#FFFFFF"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#212121","#1565C0","#4A4A4A"],"imageAspectRatios":[1.6,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  }
];

async function uploadStory(story) {
  const response = await fetch(`${SUPABASE_URL}/rest/v1/stories`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "apikey": SUPABASE_KEY,
      "Authorization": `Bearer ${SUPABASE_KEY}`,
      "Prefer": "return=minimal"
    },
    body: JSON.stringify(story)
  });
  if (!response.ok) {
    const error = await response.text();
    throw new Error(`${response.status}: ${error}`);
  }
}

async function main() {
  console.log(`Uploading ${stories.length} Exploration stories...\n`);
  let succeeded = 0, failed = 0;
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

main();
