/**
 * New Stories Part 3 - Crime Category (10 stories)
 * Usage: SUPABASE_URL=... SUPABASE_SERVICE_KEY=... node scripts/new-stories-part3.mjs
 */

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_KEY");
  process.exit(1);
}

const stories = [
  {
    slug: "great-train-robbery",
    title: "The Great Train Robbery",
    description: "Britain's heist of the century",
    category: "Crime",
    thumbnail_color: "#4A148C",
    body_text: "On August 8, 1963, fifteen men stopped a Royal Mail train in rural England and escaped with £2.6 million—roughly £60 million in today's money. It was the largest robbery in British history, and it captivated the nation. The gang had inside information about a shipment of used banknotes being transported from Glasgow to London. They tampered with signals to stop the train at a remote spot, then overwhelmed the crew. The operation took fifteen minutes. They transferred 120 mailbags to a waiting truck and drove to a nearby farmhouse to divide the loot. The police found the farmhouse within days. The robbers had tried to wipe it down but left fingerprints everywhere. Within months, most of the gang was caught and sentenced to thirty years—unprecedented for robbery. The severity of the sentences sparked public debate. Some saw the robbers as folk heroes who had harmed no ordinary people. Others noted that the train driver had been badly beaten. Ronnie Biggs escaped from prison in 1965 and spent decades as a fugitive in Brazil, becoming a minor celebrity. He returned voluntarily in 2001, old and ill, to die in Britain. Most of the money was never recovered. The Great Train Robbery entered British folklore as the ultimate heist—audacious, meticulously planned, and just barely unsuccessful.",
    design_config: {"thumbnailColor":"#4A148C","titlePage":{"backgroundColor":"#4A148C","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#4A148C","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#4A148C"},{"background":"#FFD700","text":"#000000"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#4A148C","#FFD700","#4A4A4A"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "db-cooper-disappearance",
    title: "D.B. Cooper's Disappearance",
    description: "The hijacker who vanished into thin air",
    category: "Crime",
    thumbnail_color: "#37474F",
    body_text: "On November 24, 1971, a man calling himself Dan Cooper boarded a Northwest Orient flight from Portland to Seattle. He was wearing a business suit and carrying a briefcase. Shortly after takeoff, he handed a note to a flight attendant: he had a bomb, and he wanted $200,000 in cash and four parachutes. The plane landed in Seattle. Cooper released the passengers in exchange for the money and parachutes. He ordered the crew to take off again, heading for Mexico City at low altitude with the rear door open. Somewhere over the wilderness of southwestern Washington, Cooper jumped into the night with the money strapped to his body. He was never seen again. The FBI conducted one of the longest and most exhaustive investigations in its history. They found nothing. No body, no parachute, no conclusive evidence of what happened to D.B. Cooper. In 1980, a boy found $5,800 of the ransom money buried on a riverbank, but the discovery raised more questions than it answered. Cooper became a folk hero—the only hijacker in American history to escape completely. Theories about his identity and fate have multiplied for decades. Some believe he died in the jump; others think he lived out his days in anonymity. The FBI officially closed the case in 2016 without solving it. Whoever D.B. Cooper was, he took his secret with him.",
    design_config: {"thumbnailColor":"#37474F","titlePage":{"backgroundColor":"#37474F","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#37474F","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#37474F"},{"background":"#4A148C","text":"#FFFFFF"},{"background":"#E8E8E8","text":"#000000"}],"imagePlaceholderColors":["#37474F","#4A148C","#E8E8E8"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "lindbergh-kidnapping",
    title: "The Lindbergh Baby Kidnapping",
    description: "The crime of the century",
    category: "Crime",
    thumbnail_color: "#5D4037",
    body_text: "On March 1, 1932, someone climbed a ladder to the second-floor nursery of Charles Lindbergh's New Jersey home and took his twenty-month-old son. The kidnapper left a ransom note demanding $50,000. Lindbergh was the most famous man in America, having made the first solo transatlantic flight five years earlier. The kidnapping became an international sensation. Police, federal agents, and amateur detectives swarmed the investigation. A retired school principal served as intermediary, passing ransom money to a mysterious figure in a Bronx cemetery. The baby was never returned. Two months later, a truck driver found the child's body in woods near the Lindbergh home. The toddler had been killed shortly after the kidnapping, probably by a blow to the head. The ransom money began appearing in circulation. Police traced it to Bruno Richard Hauptmann, a German immigrant carpenter. They found $14,000 of the ransom hidden in his garage. Wood from the kidnap ladder matched lumber in his attic. The trial was a circus. Hauptmann maintained his innocence to the end, claiming the money had been left by a friend who had since died. He was convicted and executed in April 1936. The case led directly to the Federal Kidnapping Act, making kidnapping a federal crime. The Lindberghs, hounded by publicity, fled to Europe. Some doubts about Hauptmann's guilt persist, but most historians consider the case closed.",
    design_config: {"thumbnailColor":"#5D4037","titlePage":{"backgroundColor":"#5D4037","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#5D4037","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#5D4037"},{"background":"#4A148C","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"}],"imagePlaceholderColors":["#5D4037","#4A148C","#FFD700"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "gardner-museum-heist",
    title: "The Gardner Museum Heist",
    description: "The largest unsolved art theft in history",
    category: "Crime",
    thumbnail_color: "#6A1B9A",
    body_text: "In the early hours of March 18, 1990, two men dressed as police officers talked their way into Boston's Isabella Stewart Gardner Museum. They handcuffed the guards, disconnected the alarm, and spent eighty-one minutes methodically removing thirteen works of art worth an estimated $500 million. They took three Rembrandts, a Vermeer, a Manet, five Degas drawings, a Chinese bronze beaker, and a Napoleonic flag finial. They left behind other works of equal or greater value. Their selection was baffling—they cut paintings from frames, damaging some, and ignored more valuable works hanging nearby. Then they vanished. The FBI believes the theft was committed by members of Boston organized crime, but no one has ever been charged. The statute of limitations for the theft itself has expired; only someone who currently possesses the works could be prosecuted. The museum still displays empty frames where the paintings once hung. A $10 million reward remains unclaimed. Isabella Stewart Gardner's will forbids any changes to the museum's display, so the frames must stay. They are monuments to absence, reminders of masterpieces that may have been destroyed, hidden, or sold into the black market's shadows. Periodically, someone claims to know where the paintings are. So far, every lead has been a dead end.",
    design_config: {"thumbnailColor":"#6A1B9A","titlePage":{"backgroundColor":"#6A1B9A","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#6A1B9A","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#6A1B9A"},{"background":"#FFD700","text":"#000000"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#6A1B9A","#FFD700","#4A4A4A"],"imageAspectRatios":[1.3,0.9],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "zodiac-killer",
    title: "The Zodiac Killer",
    description: "The cipher killer who was never caught",
    category: "Crime",
    thumbnail_color: "#212121",
    body_text: "Between December 1968 and October 1969, a serial killer terrorized the San Francisco Bay Area. He shot couples in lovers' lanes and stabbed a man and woman at a lake. He called police to report his own crimes and sent taunting letters to newspapers, signing them with a crossed-circle symbol. He called himself the Zodiac. The Zodiac's letters contained cryptograms that he claimed would reveal his identity. The first cipher was solved by a high school teacher and his wife within a week. It contained no useful information—just boasting about the thrill of killing. Another cipher remained unsolved for fifty-one years until amateur codebreakers cracked it in 2020. It also revealed nothing helpful. The killer claimed thirty-seven victims, though police confirmed only seven. He seemed to enjoy the attention more than the killing. His letters mocked investigators, threatened to bomb school buses, and demanded that people wear Zodiac buttons or he would kill again. He never did. The last confirmed Zodiac letter arrived in 1974. The killer, whoever he was, simply stopped. Or died. Or was imprisoned for something else. Suspects have ranged from convicted murderers to a man whose own children accused him. DNA evidence has excluded some suspects but identified no one. The Zodiac case remains officially open. The man who wanted so desperately to be famous achieved it—he became one of America's most notorious serial killers, and we still don't know who he was.",
    design_config: {"thumbnailColor":"#212121","titlePage":{"backgroundColor":"#212121","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#212121","text":"#FFFFFF"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#212121"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#212121","#B71C1C","#4A4A4A"],"imageAspectRatios":[1.4,0.85],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "brinks-mat-robbery",
    title: "The Brink's-Mat Robbery",
    description: "The gold heist that poisoned everyone it touched",
    category: "Crime",
    thumbnail_color: "#FFD700",
    body_text: "On November 26, 1983, six armed men broke into the Brink's-Mat warehouse near London's Heathrow Airport expecting to find £3 million in cash. They found £26 million in gold bullion, diamonds, and cash—one of the largest robberies in British history. The gang had inside help. Security guard Anthony Black had provided keys, codes, and schedules. When they realized the scale of what they'd stolen, the robbers had a problem: how do you sell three tons of gold without attracting attention? They recruited a chain of handlers to smelt and launder the gold. The operation touched dozens of people—criminals, businessmen, lawyers, corrupt officers. Money flowed into property development, nightclubs, and drug trafficking. The curse of Brink's-Mat became notorious. Over the following decades, at least a dozen people connected to the robbery or its proceeds were murdered. Others died in suspicious accidents or committed suicide. The gold itself scattered into the British economy, untraceable. Investigators believe it was melted down and sold through legitimate channels. Some suggest that anyone who has bought gold jewelry in Britain since 1983 might own a piece of Brink's-Mat. Only a fraction of the gold was ever recovered. Most of the gang was caught and imprisoned, but the mastermind was never conclusively identified. The robbery transformed British organized crime, providing capital for drug networks that flourished through the 1980s and 1990s.",
    design_config: {"thumbnailColor":"#FFD700","titlePage":{"backgroundColor":"#FFD700","textColor":"#000000"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"},{"background":"#FFFFFF","text":"#000000"},{"background":"#4A148C","text":"#FFFFFF"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#FFD700","#4A148C","#4A4A4A"],"imageAspectRatios":[1.5,0.9],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "black-dahlia-murder",
    title: "The Black Dahlia Murder",
    description: "Hollywood's most infamous unsolved killing",
    category: "Crime",
    thumbnail_color: "#1A237E",
    body_text: "On January 15, 1947, a woman walking with her daughter in a Los Angeles vacant lot saw what she thought was a broken mannequin. It was the body of Elizabeth Short, a twenty-two-year-old aspiring actress. She had been cut in half at the waist, drained of blood, and posed with her arms above her head and legs spread. The killer had washed the body and possibly kept it refrigerated before dumping it. Elizabeth Short became the Black Dahlia, a name newspapers gave her for her dark hair and fondness for black clothes. Her murder sparked the largest investigation in LAPD history, with hundreds of suspects questioned and more than fifty people confessing falsely. The killer appeared to enjoy the attention, mailing Short's belongings to a newspaper along with a message: 'Here is Dahlia's belongings. Letter to follow.' No letter came. The case became a obsession for generations of investigators and amateur sleuths. Theories have implicated doctors, filmmakers, gangsters, and even Orson Welles. Books have accused specific men, and family members of suspects have come forward with deathbed confessions. None has been proven. The mutilation suggested surgical skill. The posing suggested a message. The identity of the Black Dahlia's killer remains unknown. Elizabeth Short, who came to Hollywood dreaming of stardom, achieved the fame she sought—but only in death, as the victim of a murder that will likely never be solved.",
    design_config: {"thumbnailColor":"#1A237E","titlePage":{"backgroundColor":"#1A237E","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#1A237E","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#1A237E"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#1A237E","#B71C1C","#4A4A4A"],"imageAspectRatios":[1.4,0.85],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "antwerp-diamond-heist",
    title: "The Antwerp Diamond Heist",
    description: "The 'heist of the century' in the diamond capital",
    category: "Crime",
    thumbnail_color: "#00BCD4",
    body_text: "Over the weekend of February 15-16, 2003, thieves broke into the Antwerp Diamond Centre's vault—considered one of the most secure in the world—and stole an estimated $100 million in diamonds, gold, and jewelry. It was the largest diamond heist in history. The vault was protected by ten layers of security, including infrared heat detectors, a magnetic field, a seismic sensor, and a lock with 100 million possible combinations. The thieves defeated them all. They had rented an office in the building and spent months studying the security systems. They used aluminum to block the heat sensors, hairspray to disable the motion detectors, and custom-built tools to open the vault. The robbery was nearly perfect. But one thief made a fatal mistake. Leonardo Notarbartolo, the gang's leader, discarded evidence in a forest outside Antwerp, including a half-eaten salami sandwich. A farmer found the garbage and called police. DNA from the sandwich led investigators to Notarbartolo. Most of the gang was caught within a year. Notarbartolo was sentenced to ten years. But most of the diamonds were never recovered. Notarbartolo has always maintained that the heist was an inside job—that the vault's owner staged the theft for insurance money, and that far less was actually stolen than was reported. The diamonds themselves have vanished into the world market, impossible to trace.",
    design_config: {"thumbnailColor":"#00BCD4","titlePage":{"backgroundColor":"#00BCD4","textColor":"#000000"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#00BCD4","text":"#000000"},{"background":"#FFFFFF","text":"#00BCD4"},{"background":"#4A148C","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"}],"imagePlaceholderColors":["#00BCD4","#4A148C","#FFD700"],"imageAspectRatios":[1.3,0.9],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "escape-from-alcatraz",
    title: "The Escape from Alcatraz",
    description: "Did they survive the freezing waters?",
    category: "Crime",
    thumbnail_color: "#455A64",
    body_text: "On the night of June 11, 1962, three men vanished from Alcatraz Federal Penitentiary—the prison that was supposed to be escape-proof. Frank Morris and brothers John and Clarence Anglin left papier-mâché dummy heads in their beds, crawled through ventilation shafts they had widened with stolen spoons over months, and climbed to the roof. From there, they descended to the shore and paddled into San Francisco Bay on a makeshift raft of raincoats. They were never seen again. The FBI concluded they drowned in the frigid waters. The currents around Alcatraz are treacherous, and the water temperature can kill in minutes. No bodies were ever found—but bodies often aren't recovered from the bay. The official position remains that they died. But tantalizing evidence suggests otherwise. The Anglins' family received Christmas cards for years afterward in handwriting that appeared to be John's. A 2013 letter to the San Francisco Police, allegedly from John Anglin, claimed he and his brother survived and lived out their lives in South America. The FBI tested the letter but couldn't confirm or deny its authenticity. In 2015, a photo emerged that appeared to show the Anglin brothers in Brazil in 1975. Facial recognition analysis was inconclusive. The case officially remains open. Alcatraz closed as a prison in 1963. Whether Morris and the Anglins beat it—whether anyone ever truly escaped from the Rock—remains one of American crime's most enduring mysteries.",
    design_config: {"thumbnailColor":"#455A64","titlePage":{"backgroundColor":"#455A64","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#455A64","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#455A64"},{"background":"#37474F","text":"#FFFFFF"},{"background":"#E8E8E8","text":"#000000"}],"imagePlaceholderColors":["#455A64","#37474F","#E8E8E8"],"imageAspectRatios":[1.4,0.85],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "french-connection-bust",
    title: "The French Connection Bust",
    description: "The drug case that spawned a legend",
    category: "Crime",
    thumbnail_color: "#E65100",
    body_text: "In 1961, two New York detectives began following a small-time nightclub owner whose spending habits didn't match his income. The investigation they started would become the largest heroin bust in American history and inspire one of the greatest films ever made. Eddie Egan and Sonny Grosso tailed their suspect through Brooklyn and eventually connected him to a massive heroin smuggling operation. The French Connection, as they named it, shipped Turkish heroin through Marseille to New York, where it supplied eighty percent of the American market. The drugs were hidden in cars—packed into fenders, door panels, and frames. A single shipment could be worth $32 million on the street. The operation was run by Jean Jehan, a Corsican crime boss, and his American partners. The detectives spent months building the case, often following suspects through the freezing New York winter. On January 18, 1962, they seized 112 pounds of pure heroin—the largest single drug seizure up to that time. The bust disrupted heroin supplies across the country. Fifty-seven people were arrested, though Jehan escaped to France, which refused to extradite him. The case made Egan and Grosso celebrities. The 1971 film 'The French Connection,' based on their investigation, won five Academy Awards including Best Picture. Gene Hackman's portrayal of 'Popeye Doyle,' based on Egan, became iconic. The real detectives appeared in the film as extras.",
    design_config: {"thumbnailColor":"#E65100","titlePage":{"backgroundColor":"#E65100","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#E65100","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#E65100"},{"background":"#4A148C","text":"#FFFFFF"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#E65100","#4A148C","#4A4A4A"],"imageAspectRatios":[1.5,0.9],"imageColorOffset":1,"imagePositionSeed":3}
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
  console.log(`Uploading ${stories.length} Crime stories...\n`);
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
