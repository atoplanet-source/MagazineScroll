/**
 * New Stories Part 2 - War Category (10 stories)
 * Usage: SUPABASE_URL=... SUPABASE_SERVICE_KEY=... node scripts/new-stories-part2.mjs
 */

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_KEY");
  process.exit(1);
}

const stories = [
  {
    slug: "battle-thermopylae",
    title: "The Battle of Thermopylae",
    description: "300 Spartans against an empire",
    category: "War",
    thumbnail_color: "#B71C1C",
    body_text: "In 480 BCE, three hundred Spartans held a narrow mountain pass against the largest army the world had ever seen. King Xerxes of Persia had assembled perhaps 100,000 soldiers to conquer Greece. Standing in his way were King Leonidas and his royal guard at the pass of Thermopylae—the Hot Gates. The pass was barely wide enough for a wagon. Persian numbers meant nothing in such confined space. For two days, wave after wave of Persian soldiers crashed against the Spartan shield wall and broke. Xerxes reportedly watched in fury as his elite Immortals were cut down like common infantry. Then a Greek traitor showed the Persians a mountain path that bypassed the pass. Leonidas learned of the betrayal and dismissed most of his army, keeping only his three hundred Spartans and a few hundred allies. They knew they would die. They fought anyway. On the final day, their spears broken, they fought with swords, then daggers, then bare hands and teeth. Leonidas fell early. The Spartans fought over his body to prevent its capture. When their weapons were gone, they were buried under arrows. A monument later marked the spot: 'Go tell the Spartans, stranger passing by, that here obedient to their laws we lie.' The battle was a defeat. The Persians marched on and burned Athens. But the delay at Thermopylae allowed the Greek fleet to prepare. At Salamis a month later, that fleet destroyed Persian naval power, turning the tide of the war.",
    design_config: {"thumbnailColor":"#B71C1C","titlePage":{"backgroundColor":"#B71C1C","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#B71C1C"},{"background":"#FFD700","text":"#000000"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#B71C1C","#FFD700","#4A4A4A"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "charge-light-brigade",
    title: "The Charge of the Light Brigade",
    description: "Glory, blunder, and 600 horsemen",
    category: "War",
    thumbnail_color: "#5D4037",
    body_text: "On October 25, 1854, during the Crimean War, 670 British cavalrymen charged directly into the mouths of Russian artillery. It was one of the most famous military blunders in history—and one of its most celebrated acts of courage. The order was a mistake. Lord Raglan wanted the Light Brigade to capture some Russian guns that were being withdrawn. But the message was garbled in transmission, and the officer who delivered it gestured vaguely toward the wrong guns—a battery at the end of a valley, flanked on three sides by Russian cannon. Lord Cardigan, commanding the Light Brigade, knew a frontal charge was suicide. But orders were orders. 'Here goes the last of the Brudenells,' he said, and drew his sword. For a mile and a quarter, the cavalry rode through a storm of artillery and rifle fire. Horses and men fell constantly. The survivors reached the Russian guns and fought hand-to-hand before being driven back. Of the 670 men who began the charge, 118 were killed and 127 wounded. Nearly 400 horses died. The charge accomplished nothing militarily. But Tennyson's poem, published six weeks later, transformed disaster into legend. 'Theirs not to reason why, theirs but to do and die.' The Light Brigade became a symbol of doomed heroism, of soldiers obeying impossible orders with perfect discipline. The blunder was forgotten; the courage remembered.",
    design_config: {"thumbnailColor":"#5D4037","titlePage":{"backgroundColor":"#5D4037","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#5D4037","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#5D4037"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"}],"imagePlaceholderColors":["#5D4037","#B71C1C","#FFD700"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "christmas-truce-1914",
    title: "The Christmas Truce of 1914",
    description: "When enemies sang carols together",
    category: "War",
    thumbnail_color: "#1B5E20",
    body_text: "On Christmas Eve 1914, German soldiers in the trenches of World War I began decorating their parapets with candles and singing carols. Across no man's land, British soldiers heard 'Stille Nacht' drifting through the frozen air. Someone started singing 'Silent Night' in English. Then men began climbing out of their trenches. It happened along two-thirds of the British-German front line. Soldiers who had been trying to kill each other walked into no man's land unarmed. They exchanged cigarettes, chocolate, and addresses. They showed photographs of families back home. In some sectors, they played football with improvised balls. They buried the dead who had lain in no man's land for months. Officers mostly looked the other way. Some participated. For one day, the war stopped. The truce couldn't last. On December 26, the killing resumed. The armies had changed; the war had not. High command on both sides was furious. Orders came down forbidding fraternization. Artillery barrages were scheduled for future Christmases to prevent any recurrence. The truce of 1914 was never repeated on such a scale. But for one day, ordinary soldiers had refused to be enemies. They had recognized each other as human beings celebrating the same holiday, far from home, cold, scared, and tired of war. The generals called it a disgrace. The soldiers who were there called it a miracle.",
    design_config: {"thumbnailColor":"#1B5E20","titlePage":{"backgroundColor":"#1B5E20","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#1B5E20","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#1B5E20"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#E8E8E8","text":"#000000"}],"imagePlaceholderColors":["#1B5E20","#B71C1C","#E8E8E8"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "battle-stalingrad",
    title: "The Battle of Stalingrad",
    description: "The turning point of World War II",
    category: "War",
    thumbnail_color: "#37474F",
    body_text: "The Battle of Stalingrad lasted five months and killed nearly two million people. It was the bloodiest battle in human history, and it broke the back of the German army. In August 1942, German forces reached Stalingrad, a major Soviet industrial city on the Volga River. Hitler was obsessed with capturing the city that bore Stalin's name. Stalin was equally determined to hold it. The result was urban warfare of unprecedented savagery. German and Soviet soldiers fought room to room, floor to floor, sometimes sharing buildings—Germans on one floor, Soviets on another. The average life expectancy for a Soviet soldier in Stalingrad was twenty-four hours. Snipers hunted from the ruins. Bodies piled in the streets. Neither side could evacuate their wounded. In November, the Soviets launched a massive counteroffensive, encircling the entire German 6th Army. Hitler forbade surrender or retreat. German soldiers starved and froze through December and January, eating horses, dogs, and finally rats. When Field Marshal Paulus finally surrendered on February 2, 1943, only 91,000 of his original 300,000 men remained alive. Fewer than 6,000 would survive Soviet captivity to see Germany again. The German army never recovered from Stalingrad. From that point forward, the Soviets advanced westward, slowly, bloodily, inexorably, until they reached Berlin.",
    design_config: {"thumbnailColor":"#37474F","titlePage":{"backgroundColor":"#37474F","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#37474F","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#37474F"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#37474F","#B71C1C","#4A4A4A"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "siege-leningrad",
    title: "The Siege of Leningrad",
    description: "872 days of starvation and defiance",
    category: "War",
    thumbnail_color: "#1A237E",
    body_text: "For 872 days, German and Finnish forces besieged Leningrad, attempting to starve three million people into submission. It was the longest and most destructive siege in modern history. Hitler had ordered that Leningrad be erased—not captured, but annihilated. The city was surrounded in September 1941. All land routes were cut. The only supply line was across Lake Ladoga, frozen in winter, bombed in summer. The 'Road of Life' across the ice saved thousands but couldn't feed a city. In the first winter, the bread ration fell to 125 grams per person per day—four thin slices. People ate wallpaper paste, boiled leather belts, and sawdust. They ate pets, then rats, then nothing. Bodies piled on the streets because no one had strength to bury them. Approximately one million civilians died, mostly from starvation. Yet Leningrad held. Factories continued producing tanks and ammunition. The city's symphony orchestra, starved to skeletons, performed Shostakovich's Seventh Symphony—written during the siege and broadcast on loudspeakers so the Germans could hear. Defiance was all they had left. The siege was finally broken in January 1944. Soviet forces pushed the Germans back, and the starving city could finally be fed. Leningrad had refused to fall. The cost was almost incomprehensible—more civilians died in Leningrad than all British and American deaths in the entire war combined.",
    design_config: {"thumbnailColor":"#1A237E","titlePage":{"backgroundColor":"#1A237E","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#1A237E","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#1A237E"},{"background":"#37474F","text":"#FFFFFF"},{"background":"#E8E8E8","text":"#000000"}],"imagePlaceholderColors":["#1A237E","#37474F","#E8E8E8"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "d-day-normandy",
    title: "D-Day: The Normandy Invasion",
    description: "The largest amphibious invasion in history",
    category: "War",
    thumbnail_color: "#2E7D32",
    body_text: "On June 6, 1944, 156,000 Allied troops stormed the beaches of Normandy in the largest amphibious invasion ever attempted. Operation Overlord had been years in planning. Its success would open a second front against Nazi Germany; its failure might prolong the war indefinitely. The invasion was supposed to begin on June 5, but storms forced a delay. General Eisenhower had a small window of acceptable weather. If he waited longer, tides and moonlight wouldn't align again for weeks. He made the call: 'OK, let's go.' Before dawn, 24,000 airborne troops parachuted behind German lines. At 6:30 a.m., the first waves hit the beaches—Utah, Omaha, Gold, Juno, and Sword. Omaha was a bloodbath. German defenders in fortified positions cut down Americans by the hundreds as they waded through waist-deep water. Bodies floated in the surf. Tanks sank. Radios failed. For hours, the outcome hung in balance. Gradually, small groups of soldiers fought their way off the beach. By nightfall, the Allies held all five beaches. The cost was approximately 10,000 casualties, including 4,414 confirmed dead. The Germans were caught off guard. Hitler believed Normandy was a feint and that the real invasion would come at Calais. He held back reinforcements. By the time he realized his mistake, it was too late. The Allies had a foothold in France. Eleven months later, the war in Europe would be over.",
    design_config: {"thumbnailColor":"#2E7D32","titlePage":{"backgroundColor":"#2E7D32","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#2E7D32","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#2E7D32"},{"background":"#5D4037","text":"#FFFFFF"},{"background":"#1A237E","text":"#FFFFFF"}],"imagePlaceholderColors":["#2E7D32","#5D4037","#1A237E"],"imageAspectRatios":[1.6,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "battle-midway",
    title: "The Battle of Midway",
    description: "Five minutes that changed the Pacific War",
    category: "War",
    thumbnail_color: "#0277BD",
    body_text: "In June 1942, six months after Pearl Harbor, the Japanese navy seemed invincible. They had swept across the Pacific, conquering everything in their path. Then they sailed toward Midway Atoll, intending to destroy what remained of the American fleet. American codebreakers had decrypted Japanese communications. Admiral Nimitz knew where the Japanese fleet would be and when. He set a trap. On June 4, American torpedo bombers attacked the Japanese carriers. It was a massacre—nearly every American plane was shot down without scoring a single hit. The Japanese fighters had descended to sea level to intercept the slow torpedo planes. Their decks were crowded with aircraft being refueled and rearmed. At that moment, American dive bombers arrived from above. The Japanese fighters were too low to intercept them. In five minutes, three Japanese carriers were mortally wounded, their flight decks turned to infernos by exploding bombs and fuel. A fourth carrier was sunk hours later. Japan lost four aircraft carriers and their irreplaceable veteran pilots. America lost one carrier. The balance of power in the Pacific shifted permanently. Japan would never again go on the offensive. The decisive battle of the Pacific War lasted five minutes—the time between the first bomb hitting the Akagi and the last hitting the Soryu.",
    design_config: {"thumbnailColor":"#0277BD","titlePage":{"backgroundColor":"#0277BD","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#0277BD","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#0277BD"},{"background":"#37474F","text":"#FFFFFF"},{"background":"#FF8F00","text":"#000000"}],"imagePlaceholderColors":["#0277BD","#37474F","#FF8F00"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "tet-offensive",
    title: "The Tet Offensive",
    description: "The battle that turned America against a war",
    category: "War",
    thumbnail_color: "#33691E",
    body_text: "On January 30, 1968, during the Vietnamese New Year ceasefire, 80,000 North Vietnamese and Viet Cong troops launched simultaneous attacks on more than 100 cities and towns across South Vietnam. It was the largest military operation of the Vietnam War. American commanders had been assuring the public that victory was near, that the enemy was weakening. The Tet Offensive shattered that illusion. Viet Cong commandos breached the walls of the U.S. Embassy in Saigon. Fighting raged in the streets of cities that had been considered safe. Television cameras captured it all—American soldiers fighting house to house, the chaos and confusion, the famous photograph of a South Vietnamese general executing a prisoner in the street. Militarily, Tet was a disaster for the North. The attacks were repelled. The Viet Cong were nearly destroyed as an effective fighting force. But the strategic damage to America was irreparable. The credibility gap became a chasm. If the enemy could launch such an offensive after years of optimistic reports, what were Americans dying for? Walter Cronkite, the most trusted newsman in America, declared the war unwinnable. President Johnson's approval rating collapsed. Seven weeks after Tet, he announced he would not seek reelection. The war would continue for seven more years, but American public support never recovered.",
    design_config: {"thumbnailColor":"#33691E","titlePage":{"backgroundColor":"#33691E","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#33691E","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#33691E"},{"background":"#4E342E","text":"#FFFFFF"},{"background":"#E8E8E8","text":"#000000"}],"imagePlaceholderColors":["#33691E","#4E342E","#E8E8E8"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "fall-of-saigon",
    title: "The Fall of Saigon",
    description: "The last helicopter out of Vietnam",
    category: "War",
    thumbnail_color: "#BF360C",
    body_text: "On April 30, 1975, a North Vietnamese tank crashed through the gates of the Presidential Palace in Saigon. The Vietnam War was over. The evacuation had been chaos. President Ford had ordered Operation Frequent Wind two days earlier when North Vietnamese forces reached the outskirts of the city. Helicopters shuttled from the embassy compound to ships offshore, carrying Americans and Vietnamese who had worked with them. The U.S. had promised to evacuate all its Vietnamese allies. It was a promise that couldn't be kept. The airport was under fire. Crowds mobbed the embassy gates. Marines pushed desperate people away from overloaded helicopters. Some Vietnamese allies were left behind; many would spend years in reeducation camps. The iconic photograph shows a helicopter on a rooftop—not the embassy, but a CIA officer's apartment building—with people climbing a ladder to escape. It captured the desperation of those final hours. Ambassador Graham Martin was among the last Americans out, carrying the embassy flag. He had delayed the evacuation, refusing to believe Saigon would fall. When his helicopter lifted off at 5 a.m. on April 30, roughly 400 Vietnamese were still waiting in the compound. They would not be rescued. The war that had killed 58,000 Americans and millions of Vietnamese ended not with a peace treaty but with frantic helicopters and broken promises.",
    design_config: {"thumbnailColor":"#BF360C","titlePage":{"backgroundColor":"#BF360C","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#BF360C","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#BF360C"},{"background":"#33691E","text":"#FFFFFF"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#BF360C","#33691E","#4A4A4A"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "six-day-war",
    title: "The Six-Day War",
    description: "Israel's lightning victory",
    category: "War",
    thumbnail_color: "#FFA000",
    body_text: "In June 1967, Israel faced the prospect of coordinated attack by Egypt, Syria, and Jordan. Their combined forces outnumbered Israel's by more than two to one. Arab leaders openly discussed driving the Jews into the sea. Israel struck first. On the morning of June 5, Israeli jets flew low over the Mediterranean, then turned and attacked Egyptian airfields. In three hours, they destroyed nearly the entire Egyptian air force on the ground—300 aircraft, including all of Egypt's bombers. The Arab armies suddenly had no air cover. What followed was a rout. Israeli forces captured the Sinai Peninsula and Gaza Strip from Egypt, the West Bank and East Jerusalem from Jordan, and the Golan Heights from Syria. Israeli paratroopers reached the Western Wall, Judaism's holiest site, which had been under Jordanian control since 1948. Soldiers who had never seen it wept. By June 10, it was over. Israel had tripled its territory in six days. The military victory was so complete that it seemed miraculous. But the political consequences proved intractable. Israel now occupied lands with millions of Palestinians who had no desire to be ruled by Israel. The territories captured in those six days remain at the center of Middle Eastern conflict more than half a century later. The war that took six days to win has never truly ended.",
    design_config: {"thumbnailColor":"#FFA000","titlePage":{"backgroundColor":"#FFA000","textColor":"#000000"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#FFA000","text":"#000000"},{"background":"#FFFFFF","text":"#FFA000"},{"background":"#1A237E","text":"#FFFFFF"},{"background":"#4E342E","text":"#FFFFFF"}],"imagePlaceholderColors":["#FFA000","#1A237E","#4E342E"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":1,"imagePositionSeed":3}
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
  console.log(`Uploading ${stories.length} War stories...\n`);
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
