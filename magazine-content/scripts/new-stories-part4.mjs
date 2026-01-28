/**
 * New Stories Part 4 - Additional stories for Economics, Ancient World, Medieval, 20th Century
 * Usage: SUPABASE_URL=... SUPABASE_SERVICE_KEY=... node scripts/new-stories-part4.mjs
 */

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_KEY");
  process.exit(1);
}

const stories = [
  // ECONOMICS (+4)
  {
    slug: "panic-1907",
    title: "The Panic of 1907",
    description: "When one man saved Wall Street",
    category: "Economics",
    thumbnail_color: "#1565C0",
    body_text: "In October 1907, the American financial system nearly collapsed. Banks failed by the dozen. The stock market lost half its value. Mobs besieged financial institutions demanding their money. There was no Federal Reserve to intervene—it wouldn't exist for another six years. One man stood between America and complete financial ruin: J.P. Morgan, the most powerful banker in the country. Morgan was seventy years old, retired, and attending a church convention when the crisis erupted. He rushed back to New York and took personal command of the rescue effort from his library on Madison Avenue. For three weeks, Morgan worked eighteen-hour days, summoning bankers to his library and refusing to let them leave until they agreed to pool their resources. He locked a group of trust company presidents in his study until 4 a.m., when they finally signed a $25 million rescue package. At one point, Morgan personally pledged his own fortune to save the New York Stock Exchange from closing. The crisis passed. Morgan had saved the financial system through sheer force of will and personal wealth. But the experience convinced Congress that America needed a central bank. No democracy should depend on a private citizen to prevent economic catastrophe. The Federal Reserve Act passed in 1913, creating the institution that would handle future crises. Morgan died the same year, his final act a transformation of American finance.",
    design_config: {"thumbnailColor":"#1565C0","titlePage":{"backgroundColor":"#1565C0","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#1565C0","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#1565C0"},{"background":"#FFD700","text":"#000000"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#1565C0","#FFD700","#4A4A4A"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "wall-street-crash-1929",
    title: "The Wall Street Crash of 1929",
    description: "The week that started the Great Depression",
    category: "Economics",
    thumbnail_color: "#212121",
    body_text: "On Thursday, October 24, 1929, the New York Stock Exchange opened to a wave of selling that no one could stop. By noon, panic had set in. Crowds gathered outside the exchange, watching in horror as their wealth evaporated. Police were called to maintain order. The 1920s had been an era of boundless optimism. Stock prices had quadrupled in five years. Everyone was in the market—shoeshine boys gave stock tips, and housewives bought on margin. Economists declared that prosperity would continue forever. Then came Black Thursday. Leading bankers met and pledged to support the market, temporarily stabilizing prices. But on Monday and Tuesday of the following week, the collapse resumed with terrifying force. The Dow Jones fell 13% on Monday and another 12% on Tuesday. Investors who had borrowed to buy stocks faced margin calls they couldn't meet. Fortunes vanished in hours. Some investors jumped from windows; at least two suicides were confirmed, though legend multiplied the number. The crash wiped out $25 billion in wealth—equivalent to $396 billion today. It was the beginning of the Great Depression, a decade of economic misery that wouldn't end until World War II. Banks failed by the thousands. Unemployment reached 25%. The American Dream, it seemed, had been a delusion. The crash didn't cause the Depression alone—poor policy responses deepened and prolonged it. But Black Thursday marked the end of an era of innocence about markets and money.",
    design_config: {"thumbnailColor":"#212121","titlePage":{"backgroundColor":"#212121","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#212121","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#212121"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#212121","#B71C1C","#4A4A4A"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "asian-financial-crisis",
    title: "The Asian Financial Crisis",
    description: "When the Tiger economies crashed",
    category: "Economics",
    thumbnail_color: "#D32F2F",
    body_text: "In July 1997, Thailand's currency collapsed. Within months, the crisis spread to Indonesia, South Korea, Malaysia, and the Philippines—the 'Tiger economies' that had been celebrated as models of rapid development. Decades of growth vanished in weeks. The crisis began with excessive borrowing in foreign currencies. Asian companies and governments had taken out billions in dollar-denominated loans, assuming their own currencies would remain stable. When confidence cracked, investors fled. Currencies fell 50-80% against the dollar, making those foreign debts unpayable. Thailand devalued the baht on July 2. Indonesia's rupiah collapsed so completely that the country's economy shrank by 13% in a single year. South Korea, the world's eleventh largest economy, required a $58 billion bailout from the International Monetary Fund. The IMF's conditions were brutal: spending cuts, high interest rates, and structural reforms that deepened the immediate pain. Critics argued the medicine was worse than the disease. Indonesia's President Suharto, after thirty-two years in power, was forced to resign amid riots and ethnic violence. The crisis revealed the fragility of the Asian miracle. Growth built on borrowed money and overvalued currencies could evaporate overnight. Many Asian countries learned the lesson, building massive foreign exchange reserves to protect against future crises. Those reserves would prove crucial when the next global crisis hit in 2008.",
    design_config: {"thumbnailColor":"#D32F2F","titlePage":{"backgroundColor":"#D32F2F","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#D32F2F","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#D32F2F"},{"background":"#FFD700","text":"#000000"},{"background":"#1A237E","text":"#FFFFFF"}],"imagePlaceholderColors":["#D32F2F","#FFD700","#1A237E"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "dot-com-bubble",
    title: "The Dot-Com Bubble",
    description: "When the internet promised everything",
    category: "Economics",
    thumbnail_color: "#7B1FA2",
    body_text: "In March 2000, the NASDAQ stock index peaked at 5,048. Two years later, it had fallen to 1,114—a loss of 78%. The dot-com bubble had burst, destroying $5 trillion in market value and hundreds of companies that had promised to revolutionize the world. The bubble inflated throughout the late 1990s. The internet was new, its potential seemingly limitless. Investors poured money into any company with '.com' in its name. Startups without revenue or business plans went public and saw their stock prices triple on the first day. Pets.com spent $2 million on a Super Bowl ad and went bankrupt nine months later. Webvan raised $375 million to deliver groceries and never made a profit. Boo.com burned through $135 million in eighteen months trying to sell fashion online. The mania reached its peak in early 2000. Then the selling began. Companies that had been worth billions became worthless. Silicon Valley emptied out as startups folded and workers scattered. The recession that followed was mild by historical standards, but the psychological damage was severe. Investors who had believed in a new economy discovered that bubbles are timeless. Yet the skeptics were only half right. Many dot-com ideas were simply ahead of their time. Online pet supplies, grocery delivery, and fashion e-commerce all became billion-dollar businesses—just not for the companies that tried them first. The internet did change everything. It just took longer, and cost more, than anyone imagined.",
    design_config: {"thumbnailColor":"#7B1FA2","titlePage":{"backgroundColor":"#7B1FA2","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#7B1FA2","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#7B1FA2"},{"background":"#00BCD4","text":"#000000"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#7B1FA2","#00BCD4","#4A4A4A"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },

  // ANCIENT WORLD (+4)
  {
    slug: "trojan-war",
    title: "The Trojan War",
    description: "Ten years for a face that launched a thousand ships",
    category: "Ancient World",
    thumbnail_color: "#BF360C",
    body_text: "For centuries, scholars believed the Trojan War was pure myth—Homer's imagination run wild. Then Heinrich Schliemann, a wealthy German businessman, dug into a hill in northwestern Turkey and found the ruins of a great city. Troy was real. The war, or something like it, may have been too. According to Homer, the war began when Paris, a prince of Troy, abducted Helen, the most beautiful woman in the world, from her husband Menelaus, king of Sparta. A thousand Greek ships sailed for Troy to bring her back. The siege lasted ten years. The Greek heroes—Achilles, Odysseus, Ajax—fought legendary duels with Trojan champions. The gods themselves took sides. Achilles killed Hector, Troy's greatest warrior, and dragged his body behind a chariot. The war ended with deception. The Greeks pretended to sail away, leaving a giant wooden horse outside the gates. The Trojans, despite warnings, dragged it inside. That night, Greek soldiers hidden in the horse emerged and opened the gates. Troy burned. Helen returned to Sparta. The archaeological evidence suggests a real city was destroyed around 1180 BCE, roughly when Greeks dated the war. Whether it fell to Greeks, and whether any Helen was involved, remains unknown. The Trojan War may be history transformed by centuries of storytelling, or storytelling wrapped around a kernel of truth. Either way, it gave Western civilization its foundational epic, a story of heroism, tragedy, and the terrible cost of beauty.",
    design_config: {"thumbnailColor":"#BF360C","titlePage":{"backgroundColor":"#BF360C","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#BF360C","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#BF360C"},{"background":"#FFD700","text":"#000000"},{"background":"#4E342E","text":"#FFFFFF"}],"imagePlaceholderColors":["#BF360C","#FFD700","#4E342E"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "death-alexander-great",
    title: "The Death of Alexander the Great",
    description: "The conqueror who ran out of worlds",
    category: "Ancient World",
    thumbnail_color: "#6A1B9A",
    body_text: "By age thirty-two, Alexander the Great had conquered the largest empire the world had ever seen, stretching from Greece to India. He had never lost a battle. He called himself a god. Then, in Babylon on June 10, 323 BCE, he died. What killed him remains one of history's great mysteries. The ancient sources describe a two-week illness following a drinking party. Alexander developed fever, weakness, and excruciating pain. He lost the ability to speak. His generals gathered around his bed, and when they asked to whom he left his empire, he reportedly whispered 'to the strongest.' Theories about his death have multiplied for two millennia. Some historians believe it was typhoid fever, compounded by the primitive medical treatments of the time. Others suggest poisoning—his generals had reasons to want him dead, and several prospered from his demise. Alcohol poisoning has been proposed; Alexander drank legendary quantities of wine. Recent analysis suggests Guillain-Barré syndrome, an autoimmune disorder that causes progressive paralysis. One theory claims he wasn't actually dead when he was declared dead—that the preservative effects of the syndrome made him appear lifeless while he was still conscious. Alexander's body was eventually displayed in a golden coffin in Alexandria. His empire, having no clear successor, immediately fragmented into warring kingdoms ruled by his generals. The man who had conquered the world left no world to inherit.",
    design_config: {"thumbnailColor":"#6A1B9A","titlePage":{"backgroundColor":"#6A1B9A","textColor":"#FFD700"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#6A1B9A","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"},{"background":"#FFFFFF","text":"#6A1B9A"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#6A1B9A","#FFD700","#4A4A4A"],"imageAspectRatios":[1.3,0.9],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "eruption-thera",
    title: "The Eruption of Thera",
    description: "The volcano that may have sunk Atlantis",
    category: "Ancient World",
    thumbnail_color: "#E65100",
    body_text: "Around 1600 BCE, the volcanic island of Thera in the Aegean Sea exploded with a force four times greater than Krakatoa. It was one of the largest volcanic eruptions in human history, and it may have destroyed a civilization. Thera was home to a prosperous Minoan settlement called Akrotiri. Excavations have revealed a sophisticated city with multi-story buildings, indoor plumbing, and stunning frescoes. The inhabitants apparently had warning—no bodies have been found, suggesting evacuation. But they left behind a frozen moment in time, preserved under volcanic ash like a Bronze Age Pompeii. The eruption generated tsunamis that devastated coastlines throughout the eastern Mediterranean. Ash fell across thousands of miles. The climate cooled as volcanic debris blocked the sun. Some historians believe the disaster contributed to the collapse of Minoan civilization on Crete, weakening it for later Mycenaean conquest. A bolder theory connects Thera to the legend of Atlantis. Plato described a wealthy island civilization destroyed by natural catastrophe and swallowed by the sea. The timing, location, and circumstances of Thera's destruction match eerily well. Perhaps the story of Atlantis is a distant memory of Thera, distorted by centuries of retelling. The caldera left by the eruption is now one of the most photographed spots in Greece—the cliffs of Santorini, white buildings perched above the sea where an island used to be.",
    design_config: {"thumbnailColor":"#E65100","titlePage":{"backgroundColor":"#E65100","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#E65100","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#E65100"},{"background":"#1565C0","text":"#FFFFFF"},{"background":"#4E342E","text":"#FFFFFF"}],"imagePlaceholderColors":["#E65100","#1565C0","#4E342E"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "battle-marathon",
    title: "The Battle of Marathon",
    description: "The run that saved democracy",
    category: "Ancient World",
    thumbnail_color: "#2E7D32",
    body_text: "In 490 BCE, the Persian Empire—the largest the world had ever seen—sent an army to punish Athens for supporting a rebellion in Persian territory. The Athenians were outnumbered at least two to one. If they lost, their experiment in democracy would end, and Greece would become a Persian province. The armies met on the plain of Marathon, twenty-six miles from Athens. The Athenian generals debated whether to wait for Spartan reinforcements or attack immediately. Miltiades convinced them to fight. The Athenians charged at a run, closing the distance before Persian archers could decimate them. The center bent but held while the wings enveloped the Persian flanks. The battle became a rout. Athens lost 192 men. Persia lost 6,400. The remaining Persians sailed for Athens, hoping to reach the city before the army could return. According to legend, Pheidippides ran the entire distance from Marathon to Athens to announce the victory, gasping 'We have won' before collapsing dead. The story inspired the modern marathon race, though ancient sources tell different versions. What matters is that Marathon saved Athens. The Persians would return ten years later with a larger army, but by then the Greeks had time to prepare. Marathon proved that Persian armies could be beaten, that free citizens fighting for their homes could defeat professional soldiers serving a king. The battle became a founding myth of Western civilization—the moment democracy proved it could survive.",
    design_config: {"thumbnailColor":"#2E7D32","titlePage":{"backgroundColor":"#2E7D32","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#2E7D32","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#2E7D32"},{"background":"#BF360C","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"}],"imagePlaceholderColors":["#2E7D32","#BF360C","#FFD700"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":1,"imagePositionSeed":3}
  },

  // MEDIEVAL (+4)
  {
    slug: "peasants-revolt",
    title: "The Peasants' Revolt of 1381",
    description: "When England's poor demanded freedom",
    category: "Medieval",
    thumbnail_color: "#5D4037",
    body_text: "In June 1381, a peasant army marched on London. They were angry about a poll tax that fell hardest on the poor, but their grievances ran deeper—generations of serfdom, labor laws that kept wages low, lords who treated them like property. For a few terrifying days, they held the kingdom hostage. The revolt began in Essex when a tax collector was killed. It spread to Kent, where Wat Tyler emerged as leader. The rebels opened prisons, burned legal records that documented their servitude, and killed anyone they associated with the hated taxes—including the Archbishop of Canterbury, whose head they displayed on London Bridge. King Richard II was fourteen years old. With most of his army in France, he had no choice but to negotiate. He met the rebels at Mile End and agreed to abolish serfdom, granting them their freedom. But the next day, at a second meeting at Smithfield, Wat Tyler was stabbed to death by the mayor of London. Richard rode among the rebels, claimed their cause as his own, and convinced them to disperse. Then he broke every promise he had made. The revolt was crushed with systematic brutality. Its leaders were hunted down and executed. The poll tax was abandoned, but serfdom continued. Yet something had changed. The English peasantry had proven they could challenge the social order. Over the following century, serfdom gradually disappeared—not because lords grew generous, but because they learned to fear what might happen if they pushed too hard.",
    design_config: {"thumbnailColor":"#5D4037","titlePage":{"backgroundColor":"#5D4037","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#5D4037","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#5D4037"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"}],"imagePlaceholderColors":["#5D4037","#B71C1C","#FFD700"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "sack-constantinople-1204",
    title: "The Sack of Constantinople in 1204",
    description: "When crusaders destroyed Christendom",
    category: "Medieval",
    thumbnail_color: "#C62828",
    body_text: "The Fourth Crusade was supposed to recapture Jerusalem from the Muslims. Instead, it destroyed Constantinople—the greatest Christian city in the world—and dealt a wound from which the Byzantine Empire never recovered. The crusaders needed ships to reach the Holy Land. Venice agreed to provide them, but the crusaders couldn't pay. Venice offered a deal: help restore a deposed Byzantine emperor, and he would pay their debts. The crusaders agreed. When the emperor couldn't deliver on his promises, the crusaders decided to take Constantinople by force. On April 12, 1204, they breached the walls. What followed was three days of pillage that horrified even medieval observers. Crusaders who had taken vows to fight for Christ spent those days looting churches, raping nuns, and melting down sacred objects for their gold. The bronze horses that now stand in Venice were stolen from Constantinople's hippodrome. Countless manuscripts, relics, and artworks were destroyed or carried off. The crusaders set up their own Latin Empire in Constantinople. It lasted fifty-seven years before the Byzantines reclaimed their capital, but the city never regained its former glory. The eastern and western churches, already estranged, became permanent enemies. The Byzantine Empire, fatally weakened, would eventually fall to the Ottoman Turks in 1453. The Fourth Crusade achieved nothing for Christianity. It only proved that greed could wear any disguise.",
    design_config: {"thumbnailColor":"#C62828","titlePage":{"backgroundColor":"#C62828","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#C62828","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#C62828"},{"background":"#FFD700","text":"#000000"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#C62828","#FFD700","#4A4A4A"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "trial-joan-arc",
    title: "The Trial of Joan of Arc",
    description: "The teenager who heard voices from God",
    category: "Medieval",
    thumbnail_color: "#7B1FA2",
    body_text: "In 1431, a nineteen-year-old French peasant girl was burned at the stake for heresy. She had claimed that saints spoke to her, telling her to drive the English from France. Against all probability, she had done exactly that—leading armies, crowning a king, and becoming the most famous woman in Europe. Then her enemies caught her. Joan of Arc first heard the voices at thirteen. They told her she was chosen by God to save France, which was losing the Hundred Years' War. She convinced the uncrowned French king to give her armor and an army. At Orléans, she broke an English siege that had lasted for months. She led Charles VII to his coronation at Reims. She was captured by Burgundian forces in 1430 and sold to the English. The trial was a political execution disguised as religious inquiry. English-allied churchmen needed to prove that Joan's victories came from the devil, not God. Over five months, they interrogated her relentlessly, looking for heresy. Joan, illiterate and alone, defended herself with remarkable wit. When asked if she was in God's grace, she replied: 'If I am not, may God put me there; if I am, may God keep me there.' On May 30, 1431, she was burned in the marketplace of Rouen. Her ashes were thrown into the Seine. Twenty-five years later, a papal court overturned her conviction. In 1920, she was declared a saint. The voices she heard remain unexplained. Whether divine inspiration, mental illness, or something else entirely, they changed history.",
    design_config: {"thumbnailColor":"#7B1FA2","titlePage":{"backgroundColor":"#7B1FA2","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#7B1FA2","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#7B1FA2"},{"background":"#FFD700","text":"#000000"},{"background":"#1565C0","text":"#FFFFFF"}],"imagePlaceholderColors":["#7B1FA2","#FFD700","#1565C0"],"imageAspectRatios":[1.3,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "mongol-invasion-europe",
    title: "The Mongol Invasion of Europe",
    description: "The terror that came from the East",
    category: "Medieval",
    thumbnail_color: "#FF6F00",
    body_text: "In 1241, a Mongol army swept into Europe and destroyed everything in its path. In a single year, they conquered more territory than the Roman legions had in four centuries. Then, just as suddenly, they turned around and left. Europe never knew how close it came to conquest. The Mongols had already conquered China, Persia, and Russia when they entered Poland and Hungary. European knights, the most formidable warriors in Christendom, charged the Mongol cavalry and were annihilated. At Legnica, a combined Polish-German army was destroyed; the Mongols collected nine sacks of ears from the dead. At Mohi, the Hungarian army was surrounded and massacred. The Mongols used tactics Europe had never seen—feigned retreats, mounted archery, coordinated movements over vast distances. Their intelligence network was superior; they knew more about Europe than Europe knew about itself. They left devastation in their wake, depopulating entire regions. Then Ögedei Khan, Genghis Khan's son and successor, died in Mongolia. The princes of the blood had to return home to elect a new khan. The invasion simply stopped. The Mongols never returned in force. Europe was saved by a succession crisis on the other side of the world. The experience left lasting trauma. For centuries, 'Tartar' was a byword for terror. The fear of invasion from the east became embedded in European consciousness, influencing everything from defensive architecture to the very concept of European identity.",
    design_config: {"thumbnailColor":"#FF6F00","titlePage":{"backgroundColor":"#FF6F00","textColor":"#000000"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#FF6F00","text":"#000000"},{"background":"#FFFFFF","text":"#FF6F00"},{"background":"#B71C1C","text":"#FFFFFF"},{"background":"#4E342E","text":"#FFFFFF"}],"imagePlaceholderColors":["#FF6F00","#B71C1C","#4E342E"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },

  // 20TH CENTURY (+4)
  {
    slug: "triangle-shirtwaist-fire",
    title: "The Triangle Shirtwaist Fire",
    description: "The disaster that changed American labor",
    category: "20th Century",
    thumbnail_color: "#D84315",
    body_text: "On March 25, 1911, a fire broke out on the eighth floor of the Triangle Shirtwaist Factory in New York City. Within eighteen minutes, 146 workers were dead—most of them young immigrant women. The doors had been locked to prevent theft and unauthorized breaks. The fire escapes collapsed. The fire department's ladders couldn't reach above the sixth floor. Witnesses watched in horror as workers jumped from the windows rather than burn. The sidewalks were covered with bodies. The youngest victim was fourteen years old. The factory's owners were charged with manslaughter but acquitted—the jury couldn't prove they knew the doors were locked. They later paid $75 per victim to settle civil suits, less than the $400 per victim they received from insurance. But the outrage over the fire transformed American labor law. New York passed dozens of regulations covering fire safety, working conditions, and factory inspections. Frances Perkins, who witnessed the fire, went on to become Secretary of Labor under FDR and architect of the New Deal. The International Ladies' Garment Workers' Union, which had been trying to organize the factory, grew into a major force. The Triangle fire didn't end workplace exploitation. Sweatshops still exist, in New York and around the world. But it established the principle that governments had a duty to protect workers, that employers could not prioritize profits over human lives. The building still stands, now part of New York University.",
    design_config: {"thumbnailColor":"#D84315","titlePage":{"backgroundColor":"#D84315","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#D84315","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#D84315"},{"background":"#4A4A4A","text":"#FFFFFF"},{"background":"#FFD700","text":"#000000"}],"imagePlaceholderColors":["#D84315","#4A4A4A","#FFD700"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "spanish-flu-pandemic",
    title: "The Spanish Flu Pandemic",
    description: "The virus that killed more than the war",
    category: "20th Century",
    thumbnail_color: "#4A148C",
    body_text: "In 1918, as World War I drew to a close, a pandemic swept the globe and killed between 50 and 100 million people—more than the war itself. It struck with terrifying speed. A person could feel fine at breakfast and be dead by nightfall. The virus was called the Spanish flu, though it probably didn't originate in Spain. Wartime censorship suppressed news of the outbreak in belligerent countries; only neutral Spain reported freely, making it seem like the disease started there. The true origin remains unknown—Kansas, France, and China have all been suggested. The flu killed differently than most diseases. It was deadliest among healthy young adults, whose robust immune systems overreacted to the infection, essentially drowning victims in their own fluids. Cities that imposed early quarantines and social distancing saw lower death rates; those that held parades and public gatherings paid a terrible price. Philadelphia, which held a parade during the outbreak, saw thousands die in the following weeks. Bodies piled up faster than they could be buried. The pandemic came in three waves, the second being the most deadly. It retreated as suddenly as it arrived, possibly because the virus mutated into a less lethal form. By 1920, it was over. The world emerged traumatized but strangely silent—the pandemic was quickly forgotten, overshadowed by the war. It would take another pandemic, a century later, to remind humanity how vulnerable it remained.",
    design_config: {"thumbnailColor":"#4A148C","titlePage":{"backgroundColor":"#4A148C","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#4A148C","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#4A148C"},{"background":"#D84315","text":"#FFFFFF"},{"background":"#E8E8E8","text":"#000000"}],"imagePlaceholderColors":["#4A148C","#D84315","#E8E8E8"],"imageAspectRatios":[1.5,0.85],"imageColorOffset":1,"imagePositionSeed":3}
  },
  {
    slug: "chernobyl-disaster",
    title: "The Chernobyl Disaster",
    description: "The explosion that poisoned a continent",
    category: "20th Century",
    thumbnail_color: "#FBC02D",
    body_text: "On April 26, 1986, at 1:23 a.m., reactor number four at the Chernobyl Nuclear Power Plant exploded during a safety test gone catastrophically wrong. It was the worst nuclear disaster in history, releasing four hundred times more radiation than the Hiroshima bomb. The explosion killed two workers instantly. Firefighters arrived without protective equipment, not knowing what they faced. Many received lethal doses of radiation in the first hours. Thirty-one people would die within three months from acute radiation syndrome. The long-term death toll remains disputed—estimates range from a few thousand to hundreds of thousands. The Soviet government initially tried to conceal the disaster. Only when Swedish monitors detected abnormal radiation levels did the truth emerge. Three days after the explosion, the nearby city of Pripyat was evacuated. Fifty thousand people left their homes, expecting to return soon. They never did. The immediate area around the reactor became the Exclusion Zone, abandoned to radiation and wildlife. A hastily built concrete sarcophagus covered the destroyed reactor, but it was never meant to be permanent. Radioactive contamination spread across Belarus, Ukraine, and parts of Europe. Forests turned red and died. Contaminated milk and vegetables entered the food supply. The cleanup lasted years and involved 600,000 workers. Chernobyl accelerated the collapse of the Soviet Union by exposing the system's failures. The town of Pripyat remains frozen in 1986, a monument to the atom's terrible power.",
    design_config: {"thumbnailColor":"#FBC02D","titlePage":{"backgroundColor":"#FBC02D","textColor":"#000000"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#FBC02D","text":"#000000"},{"background":"#FFFFFF","text":"#000000"},{"background":"#4A148C","text":"#FFFFFF"},{"background":"#4A4A4A","text":"#FFFFFF"}],"imagePlaceholderColors":["#FBC02D","#4A148C","#4A4A4A"],"imageAspectRatios":[1.4,0.9],"imageColorOffset":0,"imagePositionSeed":2}
  },
  {
    slug: "challenger-explosion",
    title: "The Challenger Explosion",
    description: "Seventy-three seconds into flight",
    category: "20th Century",
    thumbnail_color: "#01579B",
    body_text: "On January 28, 1986, the Space Shuttle Challenger broke apart seventy-three seconds after launch, killing all seven crew members. Millions of Americans watched live, including schoolchildren who had tuned in to see Christa McAuliffe, a teacher, become the first ordinary citizen in space. The cause was a failed O-ring seal in one of the solid rocket boosters. The night before launch had been unusually cold for Florida. Engineers at Morton Thiokol, which built the boosters, warned that the O-rings might not seal properly in cold weather. NASA managers overruled them. They had already delayed the launch several times and were under pressure to maintain the schedule. At 11:39 a.m., Challenger lifted off into a clear blue sky. Within seconds, hot gases began leaking through the compromised O-ring. At seventy-three seconds, the external fuel tank ruptured. The shuttle didn't technically explode—it was torn apart by aerodynamic forces as it veered off course. The crew cabin survived relatively intact and continued rising before falling into the Atlantic Ocean. Evidence suggests some crew members were conscious after the breakup, though they likely lost consciousness before impact. The disaster grounded the shuttle program for nearly three years. The Rogers Commission, which investigated the accident, revealed a culture at NASA that had normalized risk and ignored warnings. Physicist Richard Feynman dramatically demonstrated the O-ring's failure by dropping a piece of the material into ice water during a televised hearing. NASA changed, but seventeen years later, Columbia would disintegrate on reentry, killing seven more astronauts.",
    design_config: {"thumbnailColor":"#01579B","titlePage":{"backgroundColor":"#01579B","textColor":"#FFFFFF"},"colorPalette":[{"background":"#000000","text":"#FFFFFF"},{"background":"#01579B","text":"#FFFFFF"},{"background":"#FFFFFF","text":"#01579B"},{"background":"#E8E8E8","text":"#000000"},{"background":"#D84315","text":"#FFFFFF"}],"imagePlaceholderColors":["#01579B","#D84315","#E8E8E8"],"imageAspectRatios":[1.6,0.85],"imageColorOffset":1,"imagePositionSeed":3}
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
  console.log(`Uploading ${stories.length} stories...\n`);
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
