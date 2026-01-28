import Foundation

// MARK: - Sample Data for Testing

@MainActor
enum SampleData {
    static let stories: [Story] = [

        // MARK: - ECONOMICS

        // STORY 1: When Tulips Cost More Than Houses
        Story(
            title: "When Tulips Cost More Than Houses",
            slug: "dutch-tulip-bubble",
            description: "The world's first speculative crash",
            category: "Economics",
            thumbnailColor: "#000000",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In February 1637, a single tulip bulb sold for more than ten times a skilled craftsman's annual salary. The flower had arrived in Europe only decades earlier, carried from the Ottoman Empire by diplomats and merchants who recognized its strange beauty. By the time it reached the Netherlands, the tulip had become something more than a flower. It was a status symbol, a marker of wealth and taste among Amsterdam's rising merchant class. The rarest varieties commanded prices that seem absurd even today. A single Semper Augustus bulb, with its distinctive crimson streaks on white petals, could purchase a grand house on Amsterdam's most fashionable canal. Speculators began trading futures contracts on bulbs still buried in the ground, buying and selling flowers that wouldn't bloom for months. Taverns became trading floors. Fortunes changed hands over drinks. Then, on February 3rd, at a routine auction in Haarlem, something unprecedented happened. The buyers simply didn't show up. Within hours, panic spread through every trading house in the country. Prices collapsed by ninety percent in a matter of days. Men who had been wealthy at breakfast found themselves ruined by dinner. The tulip crash became history's first recorded speculative bubble, a template for every financial mania that would follow. We've seen the pattern repeat with South Sea shares, railway stocks, dot-com companies, and cryptocurrency. The lesson, it seems, is one we're destined to learn again and again.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#000000"
                )
            ]
        ),

        // STORY 2: Britain's Great Fraud of 1720
        Story(
            title: "Britain's Great Fraud of 1720",
            slug: "south-sea-bubble",
            description: "The fraud that fooled a nation",
            category: "Economics",
            thumbnailColor: "#1A237E",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In 1720, the British government handed a private company the exclusive right to trade with South America. The South Sea Company had no ships, no trade routes, and no realistic prospects of profit. What it did have was a brilliant scheme to convert government debt into company shares, enriching its directors while promising investors impossible returns. The company's stock price rose from £128 in January to over £1,000 by August. Servants became wealthy. Duchesses mortgaged their estates to buy more shares. Isaac Newton, the greatest scientific mind of his era, invested heavily, lost twenty thousand pounds, and reportedly said he could calculate the motion of heavenly bodies but not the madness of people. The mania spawned imitators. Companies formed to trade in human hair, to manufacture perpetual motion machines, to pursue an undertaking of great advantage but nobody to know what it is. That last one raised two thousand pounds in a single morning before its promoter fled the country. When the bubble burst in September, fortunes evaporated overnight. Suicides followed. Parliament launched an investigation that revealed systematic bribery of government officials, including the Chancellor of the Exchequer. The South Sea directors were arrested and their estates confiscated. Britain passed the Bubble Act, restricting the formation of joint-stock companies for the next century. The crash taught a harsh lesson about the dangers of speculation untethered from reality, though future generations would prove equally eager to forget it.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#1A237E"
                )
            ]
        ),

        // STORY 3: How One Man Bankrupted France
        Story(
            title: "How One Man Bankrupted France",
            slug: "mississippi-bubble",
            description: "The scheme that bankrupted France",
            category: "Economics",
            thumbnailColor: "#4A148C",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    John Law was a Scottish gambler, a convicted murderer, and the man who accidentally destroyed the French economy. In 1716, he convinced the regent of France to let him establish a national bank that could issue paper money. It was a radical idea in an age when currency meant gold and silver coins. Law's bank succeeded beyond anyone's expectations, so he was given control of the Mississippi Company, which held exclusive trading rights to France's Louisiana territory. Law promised investors untold riches from the New World. Gold and silver mines, he claimed, awaited discovery. Fertile lands would produce boundless harvests. The shares soared. By 1719, the Mississippi Company's market value exceeded all the gold and silver in France combined. Commoners became millionaires. The word millionaire itself was coined during this mania. A servant reportedly made a hundred million livres. Parisians rioted trying to buy shares. Law printed more money to meet demand, and the money supply quintupled in a single year. Then investors began trying to convert their paper profits into actual gold. Law's bank didn't have enough metal to honor the notes. Confidence collapsed. The currency became worthless. Prices for basic goods increased by thousands of percent. Law fled France disguised as a woman, dying in Venice nine years later, broken and nearly penniless. France wouldn't trust paper money again for almost a century. The Mississippi Bubble proved that financial innovation, without proper constraints, can devastate an entire nation.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#4A148C"
                )
            ]
        ),

        // STORY 4: The Railway Mania
        Story(
            title: "The Railway Mania",
            slug: "railway-mania",
            description: "Victorian Britain's great speculation",
            category: "Economics",
            thumbnailColor: "#3E2723",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    Between 1844 and 1846, the British Parliament approved the construction of 9,500 miles of new railway track. The existing network totaled barely two thousand miles. Investors poured money into railway shares with an enthusiasm that bordered on religious fervor. Servants invested their savings. Clergymen speculated with church funds. Charlotte Bronte bought shares in the York and North Midland Railway. The logistics were impossible from the start. Britain simply lacked enough engineers, iron, and workers to build all the proposed lines. Many routes duplicated each other or served areas with no commercial potential. Promoters cared more about selling shares than building railways. Some companies existed only on paper. When the bubble burst in late 1846, share prices collapsed. The Bank of England raised interest rates to protect the currency, accelerating the crash. By 1850, railway shares had lost over eighty percent of their peak value. Thousands of middle-class families were ruined. Some had pledged their homes as collateral for share purchases. The human cost was staggering. Yet something remarkable emerged from the wreckage. Many of the railways were actually built. The speculative excess had financed a genuine revolution in transportation. By 1855, Britain had more railway track per capita than any other nation. The mania destroyed countless individual fortunes but accidentally created the infrastructure for an industrial empire. Progress, it seems, sometimes arrives through chaos.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#3E2723"
                )
            ]
        ),

        // MARK: - ANCIENT WORLD

        // STORY 5: Alexandria's Lost Library
        Story(
            title: "Alexandria's Lost Library",
            slug: "library-of-alexandria",
            description: "When humanity's knowledge burned",
            category: "Ancient World",
            thumbnailColor: "#6F4E37",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    The Library of Alexandria held an estimated four hundred thousand scrolls, representing nearly everything the ancient world had ever written down. Founded in the third century BCE under the Ptolemaic dynasty, it was designed to be the repository of all human knowledge. Ships entering Alexandria's harbor were searched by royal decree. Any scrolls found aboard were confiscated and copied. The originals went to the library. The copies were returned to their owners. Scholars from across the Mediterranean made pilgrimages to its reading rooms. Euclid wrote his Elements there, establishing the foundations of geometry that would endure for millennia. Eratosthenes calculated the circumference of the Earth using nothing but shadows and simple mathematics, arriving at a figure remarkably close to modern measurements. Aristarchus proposed that the Earth revolved around the sun, an idea that wouldn't gain acceptance for another eighteen hundred years. The library's destruction wasn't the sudden catastrophe we often imagine. It died slowly, over centuries, through a combination of fires, funding cuts, and shifting priorities. Julius Caesar's troops accidentally burned part of it during a siege. Christian mobs damaged the connected temple complex during religious riots. The Muslim conquest may have finished what remained, though historians still debate the details. What haunts us isn't just the loss of books. It's the loss of books we don't even know existed. Entire philosophical schools, complete histories of vanished civilizations, scientific treatises that might have accelerated human progress by centuries. All gone, leaving only fragments and references in texts that survived by accident.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#6F4E37"
                )
            ]
        ),

        // STORY 6: Pompeii's Last Day
        Story(
            title: "Pompeii's Last Day",
            slug: "pompeii-last-day",
            description: "24 hours that froze a city in time",
            category: "Ancient World",
            thumbnailColor: "#E76F51",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On the morning of August 24, 79 CE, Pompeii was an ordinary Roman city of perhaps twenty thousand people. Merchants opened their shops. Bakers fired their ovens. Children played in the streets while their parents went about the business of daily life. By nightfall, Pompeii would cease to exist. Mount Vesuvius had been rumbling for days, but the residents weren't alarmed. Earthquakes were common in the region. They had no way of knowing that pressure had been building beneath the mountain for centuries, that the stone plug sealing the volcano's throat was about to give way. At approximately one in the afternoon, Vesuvius exploded with the force of a hundred thousand atomic bombs. A column of superheated ash and pumice shot nineteen miles into the sky, spreading like a vast umbrella over the bay. Day became absolute darkness. The first phase of the eruption lasted eighteen hours. Pumice rained down on Pompeii at a rate of six inches per hour, collapsing roofs under its weight. Those who fled early, carrying what they could, survived. Those who stayed to protect their property, or simply waited too long to decide, found themselves trapped. At six-thirty the following morning, the eruption entered its final, deadliest phase. A pyroclastic surge, a ground-hugging avalanche of superheated gas and ash traveling at over a hundred miles per hour, swept down the mountainside and through the city. Death came in seconds. The temperature was high enough to instantly boil blood and vaporize flesh. When the ash finally settled, Pompeii lay buried under twenty feet of volcanic debris, perfectly preserved for seventeen centuries until workers digging a canal rediscovered its ruins.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#E76F51"
                )
            ]
        ),

        // STORY 7: The Bronze Age Collapse
        Story(
            title: "When Civilization Collapsed",
            slug: "bronze-age-collapse",
            description: "When civilization itself fell apart",
            category: "Ancient World",
            thumbnailColor: "#5D4037",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    Around 1200 BCE, the ancient world ended. Within a single generation, nearly every major civilization in the Eastern Mediterranean collapsed. The Hittite Empire vanished completely. Mycenaean Greece fell into a dark age that lasted four centuries. Egypt survived but never recovered its former glory. Cities that had stood for thousands of years burned and were abandoned. The cause remains one of history's great mysteries. Ancient sources speak of invaders called the Sea Peoples, raiders who swept across the Mediterranean destroying everything in their path. Egyptian records describe massive naval battles against these mysterious attackers. But modern scholars suspect the Sea Peoples were a symptom, not a cause. The Bronze Age world was interconnected in ways that made it vulnerable. Cyprus provided copper. Afghanistan supplied tin. These metals, combined to make bronze, were the basis of all advanced technology. Trade routes stretched from Britain to Mesopotamia. When the system worked, everyone prospered. When it failed, everyone fell together. Climate data suggests severe droughts struck the region around 1200 BCE. Crop failures would have caused famines. Famines would have sparked migrations. Migrations would have disrupted trade. Disrupted trade would have caused more famines. The cascade may have been unstoppable once it began. What emerged from the ruins was fundamentally different. Iron replaced bronze. Alphabets replaced syllabaries. New peoples, including the Greeks and Israelites, rose to prominence. The collapse was catastrophic for those who lived through it, but it cleared space for the civilizations that would shape the modern world.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#5D4037"
                )
            ]
        ),

        // STORY 8: The Destruction of Carthage
        Story(
            title: "Rome's Final Revenge on Carthage",
            slug: "destruction-carthage",
            description: "Rome's final revenge",
            category: "Ancient World",
            thumbnailColor: "#B71C1C",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In 146 BCE, Roman soldiers went door to door through Carthage, killing everyone they found. The city had resisted siege for three years. Now it burned for seventeen days. When the fires finally died, the Romans demolished what remained, stone by stone. Ancient sources claim they plowed salt into the earth so nothing would ever grow there again. Carthage had been Rome's greatest rival. For over a century, the two powers had fought for control of the Mediterranean. Hannibal had marched elephants across the Alps and nearly destroyed Rome itself. The Romans never forgot the terror of that invasion, the years when Hannibal roamed the Italian countryside, winning battle after battle while Rome's allies abandoned her. Even after Hannibal's defeat, the fear remained. Cato the Elder ended every speech in the Roman Senate with the same words: Carthago delenda est. Carthage must be destroyed. It didn't matter that Carthage had been disarmed after the Second Punic War, that it posed no military threat, that it had faithfully paid its war indemnities for fifty years. Rome wanted annihilation. The Third Punic War was manufactured from a pretext. Carthage defended itself against an aggressive neighbor. Rome declared this a treaty violation and demanded impossible concessions. When Carthage refused to surrender unconditionally, the siege began. Of a population that may have reached half a million, only fifty thousand survived to be sold into slavery. A civilization that had traded with every corner of the known world, that had invented new forms of navigation and agriculture, that had produced libraries of literature in a language now almost entirely lost, was erased from history. The site remained empty for a century until Julius Caesar founded a new Roman colony on its ruins.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#B71C1C"
                )
            ]
        ),

        // STORY 9: The Siege of Masada
        Story(
            title: "Masada's Last Stand",
            slug: "siege-masada",
            description: "The fortress that chose death over slavery",
            category: "Ancient World",
            thumbnailColor: "#FF8F00",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In 73 CE, nine hundred and sixty Jewish rebels held a fortress on a mountain in the Judean Desert. Below them, fifteen thousand Roman soldiers prepared for the final assault. The siege had lasted two years. Masada was nearly impregnable. King Herod had built it decades earlier as a refuge of last resort, perched atop a plateau with sheer cliffs on every side. The only access was a narrow path called the Snake, winding up the mountainside where defenders could easily pick off attackers. The Romans responded with characteristic engineering. They built a massive ramp of earth and stone up the western face of the mountain, a project that took months and cost countless lives. Jewish prisoners were forced to carry the materials, ensuring the defenders couldn't attack without killing their own people. On the night before the final assault, the rebel leader Eleazar ben Ya'ir gathered his people. According to the historian Josephus, he argued that death was preferable to the slavery and torture that awaited them. Ten men were chosen by lot to kill the others. Then one of the ten killed the remaining nine before taking his own life. When Roman soldiers breached the walls the next morning, they found only corpses and silence. Two women and five children had hidden in a cistern and survived to tell the story. Modern archaeology has complicated this narrative. Excavations found only twenty-eight skeletons on the mountain, far fewer than the account describes. Perhaps some rebels surrendered. Perhaps the mass suicide was smaller than claimed. What remains undisputed is the fortress itself, still standing two thousand years later, a monument to desperate resistance against overwhelming force.
                    """,
                    textColor: "#000000",
                    backgroundColor: "#FF8F00"
                )
            ]
        ),

        // MARK: - MEDIEVAL

        // STORY 10: The Dancing Plague of 1518
        Story(
            title: "400 People Danced to Death",
            slug: "dancing-plague-1518",
            description: "When a city danced itself to death",
            category: "Medieval",
            thumbnailColor: "#E63946",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In July 1518, a woman named Frau Troffea stepped into a narrow street in Strasbourg and began to dance. There was no music. No celebration. She simply danced, her feet moving in a compulsive rhythm she seemed unable to control. She danced through the afternoon and into the evening. She danced until her shoes wore through and her feet bled. She danced until she collapsed from exhaustion, only to rise and begin again. Within a week, thirty-four people had joined her. Within a month, the number had grown to four hundred. The city council, baffled by the phenomenon, consulted physicians who declared that the afflicted were suffering from overheated blood. The cure, they decided, was more dancing. Musicians were hired to play faster and louder. A wooden stage was constructed so the dancers could perform more freely. Guildhalls were opened around the clock to accommodate the growing crowds. It only made things worse. Historical records suggest dozens died before the plague mysteriously ended in September, nearly two months after it began. The dancers simply stopped, as suddenly as they had started, and returned to their normal lives. Modern historians believe the dancing plague was a case of mass psychogenic illness, a physical manifestation of extreme psychological stress. Strasbourg had suffered years of famine, bitter winters, and outbreaks of smallpox. The people were desperate, traumatized, and searching for any form of release. The dancing plague reminds us that the mind can break the body in ways we still don't fully understand, and that collective trauma can manifest in the strangest possible ways.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#E63946"
                )
            ]
        ),

        // STORY 11: The Defenestration of Prague
        Story(
            title: "The Defenestration of Prague",
            slug: "defenestration-prague",
            description: "The window that started a war",
            category: "Medieval",
            thumbnailColor: "#4A4A4A",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On May 23, 1618, a group of Protestant nobles marched into Prague Castle to confront the Catholic regents appointed by the Habsburg emperor. The meeting did not go well. After a heated argument about religious freedom, the nobles seized two of the regents and their secretary and threw them out of a third-story window. All three men survived the seventy-foot fall. Catholics claimed they were saved by angels or by the Virgin Mary herself. Protestants pointed out that they had landed in a pile of manure. This act of political violence, known as the Defenestration of Prague, triggered the Thirty Years' War, one of the most destructive conflicts in European history. The war would eventually involve most of the major powers on the continent and kill an estimated eight million people, many of them civilians who died from famine and disease. The word defenestration means throwing someone out of a window. Prague has a particular history with this form of protest. An earlier defenestration in 1419 sparked the Hussite Wars. A later one in 1948 killed the Czechoslovak foreign minister Jan Masaryk, possibly murdered by communists. Something about that city and its windows. The 1618 defenestration reminds us how quickly regional disputes can spiral into continental catastrophes. A broken window in Bohemia led to three decades of war that reshaped the political map of Europe and established the principle of state sovereignty that still governs international relations today.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#4A4A4A"
                )
            ]
        ),

        // STORY 12: The Children's Crusade
        Story(
            title: "Children Who Marched to Jerusalem",
            slug: "childrens-crusade",
            description: "The march that ended in tragedy",
            category: "Medieval",
            thumbnailColor: "#1565C0",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In the summer of 1212, thousands of children marched toward the Holy Land, convinced that God would part the Mediterranean Sea and deliver Jerusalem into their innocent hands. The armies of kings had failed to retake the sacred city. These children believed their purity would succeed where military might had not. A shepherd boy named Stephen claimed to have received a letter from Christ himself, commanding him to lead the faithful to Jerusalem. In Germany, a boy named Nicholas gathered his own following with similar visions. The movements merged into a single tide of youthful zealots streaming southward across Europe. The reality was grimmer than the legend. Many of the crusaders were likely teenagers and young adults rather than small children. Some were peasants fleeing difficult conditions. Others were genuine believers caught up in religious fervor. Local authorities tried to stop them. Parents pleaded with their children to return. Most refused. None reached Jerusalem. The Mediterranean did not part. Thousands died of hunger and disease crossing the Alps. Of those who reached Italian ports, some turned back in despair. Others were reportedly sold into slavery by merchants who had promised them passage to the Holy Land. The historical record is fragmentary and contradictory. Some scholars question whether the Children's Crusade happened at all as traditionally described. What's certain is that chroniclers of the time recorded these events with horror and pity, seeing in them a judgment on the corruption of their age. The innocents had tried to accomplish what their elders could not, and had been destroyed by the attempt.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#1565C0"
                )
            ]
        ),

        // STORY 13: The Black Death Arrives
        Story(
            title: "Europe's Deadliest Year",
            slug: "black-death-arrives",
            description: "The plague that killed half of Europe",
            category: "Medieval",
            thumbnailColor: "#212121",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In October 1347, twelve Genoese trading ships docked at the Sicilian port of Messina. The sailors aboard were dying or already dead, their bodies covered with black boils that oozed blood and pus. Harbor authorities ordered the ships out immediately, but it was far too late. The Black Death had arrived in Europe. Within five years, it would kill between thirty and sixty percent of the continent's population. The plague spread along trade routes with terrifying speed. By January 1348, it had reached France. By June, England. By December, Scandinavia. Entire villages were wiped out. Bodies piled in the streets faster than they could be buried. In some cities, the living fled and left the dead unburied entirely. The social fabric tore apart. Physicians could offer no explanation and no cure. Many believed they were witnessing divine punishment for humanity's sins. Flagellants marched through towns, whipping themselves bloody in hopes of appeasing God's wrath. Others blamed Jews, leading to massacres across Germany and France. The psychological impact may have exceeded even the physical devastation. A generation grew up surrounded by death, convinced that the world was ending. Art and literature turned dark and obsessive. The Dance of Death became a common motif, depicting skeletons leading people of all ranks to their graves. When the plague finally retreated, it left a transformed society. Labor shortages gave surviving peasants unprecedented bargaining power. Serfdom began its long decline. The authority of the Church, which had failed to protect its flock, was permanently weakened. Medieval Europe had ended. Something new was struggling to be born.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#212121"
                )
            ]
        ),

        // STORY 14: The Siege of Constantinople
        Story(
            title: "Constantinople's Final Hours",
            slug: "fall-constantinople",
            description: "The end of the Roman Empire",
            category: "Medieval",
            thumbnailColor: "#6A1B9A",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On May 29, 1453, the last Roman Emperor died fighting in a breach in the walls of Constantinople. With him ended an empire that had lasted, in one form or another, for over two thousand years. The Ottoman Sultan Mehmed II had brought an army of perhaps eighty thousand men to besiege a city defended by fewer than seven thousand. Constantinople's massive walls, which had repelled attackers for a millennium, faced a new enemy: gunpowder. Mehmed had commissioned the largest cannons ever built. One of them required two hundred men and sixty oxen to move into position. The bombardment continued for weeks. The walls that had stopped Persians, Arabs, and Crusaders slowly crumbled under the relentless pounding. On the final night, the defenders gathered in the Hagia Sophia for a last service. Orthodox and Catholic, Greek and Italian prayed together, their theological disputes forgotten in the face of annihilation. In the early hours of the morning, Ottoman troops found a small gate left open, possibly by accident, possibly by treachery. They poured through and overwhelmed the exhausted defenders. The Emperor Constantine XI charged into the melee and vanished. His body was never identified. For three days, the victorious soldiers looted the city. Churches became mosques. Libraries were burned or scattered. Scholars fled westward, carrying ancient manuscripts that would help spark the Renaissance. The fall of Constantinople sent shockwaves through Christendom and closed the overland trade routes to Asia. Europeans began looking for new paths eastward. Forty years later, Columbus sailed west.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#6A1B9A"
                )
            ]
        ),

        // MARK: - 20TH CENTURY

        // STORY 15: The Radium Girls
        Story(
            title: "The Radium Girls",
            slug: "radium-girls",
            description: "The women who glowed in the dark",
            category: "20th Century",
            thumbnailColor: "#2D6A4F",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In the factories of New Jersey and Illinois during the 1920s, young women painted watch dials with luminous radium paint, making timepieces that glowed in the dark. The work paid well, three times what a typical factory job offered, and the women considered themselves lucky. Their supervisors taught them a technique called lip-pointing: dip the brush in radium paint, bring it to your lips to shape a fine point, then apply the paint to the tiny dial numbers. Repeat hundreds of times per day. The radium made them shimmer. They painted it on their fingernails for parties. They brushed it on their teeth to surprise their boyfriends with glowing smiles. They had no idea they were poisoning themselves with every stroke. Within a few years, the women began falling ill. Their teeth loosened and fell out. Their jaws crumbled and had to be removed. Their bones honeycombed with holes as the radium replaced calcium in their skeletons. Some developed cancers so aggressive their tumors burst through their skin. The company knew radium was dangerous. Male scientists and executives handled the material with lead screens and protective equipment. But the dial painters were considered expendable. When they got sick, the company blamed them, claiming they had contracted syphilis to discredit their testimony. In 1927, five dying women filed suit against the United States Radium Corporation. The case drew national attention. Newspapers dubbed them the Radium Girls. They won their case, though most died within a few years of their victory. Their fight established the right of workers to sue employers for damages caused by unsafe working conditions, laying the foundation for modern occupational health law.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#2D6A4F"
                )
            ]
        ),

        // STORY 16: The Great Emu War
        Story(
            title: "Australia Lost a War to Birds",
            slug: "great-emu-war",
            description: "When Australia lost a war to birds",
            category: "20th Century",
            thumbnailColor: "#8B4513",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In 1932, the Australian government declared war on emus. This is not a metaphor. The Royal Australian Artillery deployed soldiers armed with Lewis guns to the wheat-farming regions of Western Australia, where an estimated twenty thousand emus were destroying crops. The birds had migrated inland after breeding season, following their ancient routes, only to discover that the land had been transformed into farmland. To them, the wheat fields were an endless buffet. The farmers were desperate. Many were veterans of World War I who had been given land grants as reward for their service. They had struggled through drought and the Great Depression, and now watched helplessly as flocks of six-foot-tall birds devoured their livelihood. The military operation began in November. It was a disaster from the start. Emus, it turns out, are remarkably difficult to kill. They can run at thirty miles per hour and seem almost indifferent to bullets. The birds would scatter at the first shots, regroup, and return from a different direction. After six days, the soldiers had used 2,500 rounds of ammunition and killed perhaps 200 birds. The emus had won. A second attempt later that month fared slightly better but still fell far short of expectations. The official military report noted that the emus had displayed guerrilla tactics and that each pack seemed to have its own leader who kept watch while the others fed. The soldiers withdrew. The farmers were left to build fences. The emus continue to thrive in Australia to this day, a reminder that nature doesn't always cooperate with human plans.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#8B4513"
                )
            ]
        ),

        // STORY 17: The Miracle of the Sun
        Story(
            title: "The Miracle of the Sun",
            slug: "miracle-of-sun",
            description: "When 70,000 people watched the sun dance",
            category: "20th Century",
            thumbnailColor: "#FFB800",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On October 13, 1917, an estimated seventy thousand people gathered in a muddy field near Fatima, Portugal. They had come because three young shepherd children claimed that the Virgin Mary had been appearing to them since May, and had promised a miracle on this date. Most were devout Catholics. Some were skeptics, including journalists who had come to expose what they assumed would be a fraud. It had been raining all morning. The crowd stood in thick mud, many having traveled for days on foot to reach this remote location. At noon, the rain stopped. The clouds parted. And then, according to multiple eyewitness accounts, the sun began to behave impossibly. Witnesses described the sun spinning, zigzagging across the sky, and plunging toward the earth before returning to its normal position. Colors radiated outward, painting the landscape in shifting hues of red, yellow, and violet. People fell to their knees in prayer. Others screamed in terror, convinced the world was ending. The event lasted approximately ten minutes. When it ended, people noticed that their clothes, which had been soaked through, were completely dry. Newspaper accounts from the time corroborate these descriptions, including reports from anticlerical publications that had no interest in promoting religious claims. Scientists have proposed various explanations: atmospheric phenomena, mass hallucination, staring at the sun causing optical effects. None fully account for all the reported details. The Catholic Church investigated for thirteen years before declaring the apparitions worthy of belief. Whatever happened at Fatima that day, seventy thousand people saw something they couldn't explain.
                    """,
                    textColor: "#000000",
                    backgroundColor: "#FFB800"
                )
            ]
        ),

        // STORY 18: The Hindenburg Disaster
        Story(
            title: "37 Seconds That Ended an Era",
            slug: "hindenburg-disaster",
            description: "Thirty-seven seconds that ended an era",
            category: "20th Century",
            thumbnailColor: "#BF360C",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On May 6, 1937, the largest aircraft ever built approached its mooring mast at Lakehurst, New Jersey, completing a transatlantic voyage from Frankfurt. The Hindenburg was eight hundred feet long, filled with seven million cubic feet of hydrogen, a flying luxury hotel that could cross the Atlantic in half the time of the fastest ocean liners. The future of travel, people said, belonged to the airship. At 7:25 PM, as ground crews grabbed the mooring lines, a small flame appeared near the tail. Witnesses would later disagree about what they saw first, a blue flash, a yellow glow, a mushroom-shaped burst of fire. Within thirty-seven seconds, the Hindenburg was a skeleton of burning aluminum, collapsing onto the airfield. The disaster killed thirty-six people, a remarkably low number given the scale of destruction. Many survived by jumping from the gondola as the airship settled to earth. Others rode the wreckage down and walked away from the flames. What made the Hindenburg disaster historic wasn't the death toll but the documentation. Radio reporter Herbert Morrison was recording a routine broadcast when the fire started. His anguished narration, the humanity, oh the humanity, became one of the most famous pieces of audio ever captured. Newsreel cameras filmed the entire catastrophe. For the first time, a technological failure played out in front of millions. The era of the passenger airship ended that evening. The Hindenburg's sister ship never flew again. Within months, the German government abandoned lighter-than-air travel entirely. The airplane, smaller and less elegant but filled with non-flammable air, inherited the skies.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#BF360C"
                )
            ]
        ),

        // STORY 19: The Dyatlov Pass Incident
        Story(
            title: "Nine Hikers, No Answers",
            slug: "dyatlov-pass",
            description: "Nine hikers died. No one knows why.",
            category: "20th Century",
            thumbnailColor: "#37474F",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In February 1959, nine experienced hikers set out to reach Otorten, a mountain in the northern Urals. They never arrived. When rescuers found their tent weeks later, it had been slashed open from the inside. The hikers had fled into the freezing darkness wearing little or no clothing. Their bodies were scattered across the mountainside. Two were found with fractured skulls and broken ribs, injuries consistent with tremendous force but no external wounds. One woman was missing her tongue and eyes. The Soviet investigation concluded with a verdict of death by compelling natural force, explaining nothing. The case was classified and remained secret for decades. When it finally became public in the 1990s, it spawned countless theories. Some blamed an avalanche, though the terrain showed no evidence of one. Others suggested indigenous Mansi people attacked the hikers, but the Mansi had no history of violence against outsiders. The military was conducting secret tests in the region, leading to speculation about weapons experiments gone wrong. Some investigators noted that the hikers' skin had an orange tint and their hair had turned gray, suggesting exposure to something unusual. Others claimed radiation was detected on their clothing. The most exotic theories invoke everything from yeti attacks to alien encounters. More recent analysis suggests a delayed avalanche, possibly triggered by the hikers cutting into the slope to pitch their tent. The slab would have fallen on them as they slept, explaining the blunt force injuries. Panicked and possibly concussed, they fled into the night and died of hypothermia. The tongue and eyes may have been removed by scavengers after death. But certainty remains elusive. The mountain pass now bears the name of the expedition's leader. Dyatlov Pass keeps its secrets.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#37474F"
                )
            ]
        ),

        // STORY 20: The Tunguska Event
        Story(
            title: "The Tunguska Event",
            slug: "tunguska-event",
            description: "The explosion that flattened 800 square miles",
            category: "20th Century",
            thumbnailColor: "#1B5E20",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On June 30, 1908, something exploded over the Siberian wilderness with the force of a thousand Hiroshima bombs. The blast flattened an estimated eighty million trees across eight hundred square miles. People felt the shockwave hundreds of miles away. Seismographs in England registered the impact. For nights afterward, the skies over Europe glowed bright enough to read a newspaper at midnight. No one investigated for nearly two decades. The region was remote, sparsely populated, and in the chaos of war and revolution, mysterious explosions in Siberia attracted little official attention. When Soviet scientists finally reached the site in 1927, they found a landscape of devastation. Trees lay fallen in a vast radial pattern, all pointing away from a central point. But there was no crater. Whatever had caused the explosion had apparently vaporized before reaching the ground. The leading theory today is an asteroid or comet fragment, perhaps sixty meters across, that entered the atmosphere and detonated at an altitude of five to ten kilometers. The airburst would have released enough energy to produce the observed effects without leaving an impact crater. Smaller fragments may have scattered across the region but have never been definitively found. The Tunguska event serves as a reminder of cosmic vulnerability. Had the object arrived a few hours later, Earth's rotation would have placed a major city beneath its path. St. Petersburg, with its millions of residents, might have ceased to exist. The universe, it seems, does not check whether anyone is watching before conducting its experiments.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#1B5E20"
                )
            ]
        ),

        // MARK: - 19TH CENTURY

        // STORY 21: The Year Without Summer
        Story(
            title: "1816: Summer Never Came",
            slug: "year-without-summer",
            description: "When a volcano changed the world",
            category: "19th Century",
            thumbnailColor: "#5C6BC0",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In April 1815, Mount Tambora in Indonesia exploded in the largest volcanic eruption in recorded history. The blast killed an estimated seventy thousand people immediately, but its true impact would unfold over the following year. Tambora ejected so much ash and sulfur dioxide into the stratosphere that it created a global climate catastrophe. The following year, 1816, became known as the Year Without Summer. In New England, frost occurred in every month. Snow fell in June. Crops failed across Europe and North America. Food prices soared. Horses starved because there was no hay. In some regions, people ate rats and grass to survive. The human cost was staggering. Famine spread across the Northern Hemisphere. Typhus epidemics followed in the wake of malnutrition. In Switzerland, the situation was so desperate that the government declared a national emergency. It was in this context that a group of writers gathered at the Villa Diodati near Lake Geneva. Trapped indoors by the endless cold rain, they challenged each other to write ghost stories. Mary Shelley, then eighteen years old, began writing Frankenstein. Her tale of a creature brought to life through science, only to be abandoned by its creator, was shaped by the apocalyptic atmosphere of that strange summer. Lord Byron wrote a poem about darkness consuming the world. The volcanic winter had created the perfect conditions for gothic horror. Sometimes global catastrophe produces unexpected art.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#5C6BC0"
                )
            ]
        ),

        // STORY 22: The London Beer Flood
        Story(
            title: "Death by Beer Tsunami",
            slug: "london-beer-flood",
            description: "When a tsunami of beer destroyed a neighborhood",
            category: "19th Century",
            thumbnailColor: "#8D6E63",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On October 17, 1814, a twenty-two-foot-tall wooden vat of beer ruptured at the Meux and Company Brewery in London. The force of the escaping liquid knocked loose the valve on an adjacent vat. Within minutes, over 135,000 gallons of beer flooded into the streets of the St. Giles rookery, one of London's poorest neighborhoods. The wave of porter, a dark brown ale, reached fifteen feet in height as it crashed through the narrow streets. It demolished two houses and breached the wall of a basement where a family was holding a wake for a two-year-old boy who had died the previous day. The mourners, trapped in the cellar, drowned in beer. In total, eight people died. Seven were women and children. The youngest victim was three years old. In the aftermath, crowds gathered to scoop up the free beer. Some brought pots and pans. Others simply cupped their hands. The brewery was later taken to court but found not guilty of any wrongdoing. The disaster was ruled an act of God. Meux and Company successfully petitioned Parliament for a refund on the taxes they had paid for the lost beer. The wooden vats were eventually replaced with lined concrete vessels. The St. Giles rookery, already one of London's most notorious slums, continued to deteriorate until it was eventually demolished for urban renewal. The beer flood is largely forgotten today, a strange footnote in London's history. But for the families who lost loved ones to a wave of porter on an autumn afternoon, it was a tragedy beyond imagination.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#8D6E63"
                )
            ]
        ),

        // STORY 23: The Great Molasses Flood
        Story(
            title: "Boston's Strangest Disaster",
            slug: "molasses-flood",
            description: "Boston's strangest disaster",
            category: "19th Century",
            thumbnailColor: "#4E342E",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On January 15, 1919, a storage tank in Boston's North End burst open and released 2.3 million gallons of molasses in a wave that moved at thirty-five miles per hour. The steel tank, fifty feet tall and ninety feet in diameter, had been built quickly and poorly to store molasses for industrial alcohol production. On that unusually warm winter day, the rivets failed. The wave of molasses was two stories high. It swept away everything in its path: wagons, horses, automobiles, and people. Buildings were knocked off their foundations. The elevated railway structure buckled. Rescue workers found victims cemented in place by the rapidly cooling syrup. Twenty-one people died. A hundred and fifty were injured. Many victims suffocated, unable to breathe as the thick liquid filled their mouths and noses. Others were crushed by debris carried in the wave. Horses had to be shot where they stood, trapped in molasses too deep and sticky to escape. The cleanup took weeks. Workers used saltwater to dissolve the molasses, but it had already seeped into every crack and crevice of the neighborhood. Residents claimed they could smell molasses on hot summer days for decades afterward. The disaster led to significant changes in building codes and engineering standards. It was one of the first cases where expert witnesses used engineering analysis in court. The tank's owners eventually paid settlements equivalent to millions in today's dollars. Boston still remembers the day that death came as a sticky brown wave through the winter streets.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#4E342E"
                )
            ]
        ),

        // STORY 24: The Carrington Event
        Story(
            title: "When the Sun Nearly Fried Earth",
            slug: "carrington-event",
            description: "The solar storm that could happen again",
            category: "19th Century",
            thumbnailColor: "#F57F17",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On September 1, 1859, amateur astronomer Richard Carrington was sketching sunspots when he witnessed something unprecedented: a massive white flash erupting from the sun's surface. He had just observed the largest solar flare in recorded history. Seventeen hours later, the resulting geomagnetic storm reached Earth. The aurora borealis, normally visible only in polar regions, was seen as far south as Hawaii and Cuba. Telegraph systems around the world went haywire. Operators received electric shocks from their equipment. Some telegraph offices caught fire. In an eerie twist, many systems continued working even after operators disconnected the batteries, powered solely by the electrical currents the storm induced in the wires. The Carrington Event was the most powerful geomagnetic storm ever documented. Modern estimates suggest the associated coronal mass ejection traveled from the sun to Earth in just eighteen hours, roughly four times faster than typical. The energy involved was staggering. In 1859, this caused inconvenience and some minor damage. Today, it would be catastrophic. Our modern infrastructure depends on technologies that didn't exist in Carrington's time. A similar storm now would fry satellites, collapse power grids, and disrupt communications on a global scale. Some estimates suggest the economic damage could reach trillions of dollars. Recovery might take years. Solar physicists believe Carrington-class events occur roughly once every century. The last one missed Earth in 2012, passing through our orbit just a week after our planet had been in that exact position. We were lucky. The sun keeps spinning. Eventually, our luck will run out.
                    """,
                    textColor: "#000000",
                    backgroundColor: "#F57F17"
                )
            ]
        ),

        // STORY 25: The Eruption of Krakatoa
        Story(
            title: "Krakatoa: Loudest Sound in History",
            slug: "krakatoa-eruption",
            description: "The loudest sound in recorded history",
            category: "19th Century",
            thumbnailColor: "#D84315",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On August 27, 1883, the island of Krakatoa in Indonesia exploded with a force equivalent to two hundred megatons of TNT. The sound was heard nearly three thousand miles away in Australia, where residents thought they were hearing distant cannon fire. On the island of Rodrigues, four thousand miles across the Indian Ocean, people reported what sounded like heavy guns in the distance. It remains the loudest sound in recorded human history. The explosion was so powerful it destroyed most of the island itself. Two-thirds of Krakatoa simply ceased to exist, collapsing into the empty magma chamber beneath. The resulting caldera plunged hundreds of feet below sea level. Tsunamis radiating from the collapse reached heights of over a hundred feet, obliterating coastal towns on Java and Sumatra. The death toll exceeded thirty-six thousand. Some victims were found miles inland, carried there by the waves. The eruption injected massive amounts of ash into the stratosphere. For years afterward, the world experienced spectacular red sunsets as particles scattered the light. Global temperatures dropped noticeably. The painter Edvard Munch, witnessing one of these bloody skies in Norway, was inspired to create his famous work The Scream. Krakatoa itself was not finished. In 1927, a new volcanic cone emerged from the caldera. Named Anak Krakatau, Child of Krakatoa, it has been growing steadily ever since, occasionally reminding nearby residents that they live in the shadow of one of Earth's most violent geological features. The child continues to grow.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#D84315"
                )
            ]
        ),

        // MARK: - SCIENCE

        // STORY 26: The Discovery of Radioactivity
        Story(
            title: "The Discovery of Radioactivity",
            slug: "discovery-radioactivity",
            description: "The accident that changed physics forever",
            category: "Science",
            thumbnailColor: "#00695C",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In 1896, Henri Becquerel was trying to prove a theory that turned out to be completely wrong. He believed that phosphorescent materials, substances that glow after exposure to light, might also emit X-rays, which had just been discovered. He planned to expose uranium salts to sunlight, then place them on photographic plates to see if they produced X-ray images. Overcast skies in Paris forced him to postpone the experiment. He stored the uranium salts in a drawer, resting on top of wrapped photographic plates, and waited for better weather. When he finally developed the plates several days later, expecting only faint images, he found they were intensely exposed. The uranium had been emitting something, but it had nothing to do with sunlight or phosphorescence. Becquerel had accidentally discovered radioactivity. The uranium was spontaneously emitting invisible rays capable of penetrating solid materials, something no known substance was supposed to do. Within two years, Marie and Pierre Curie had isolated two new radioactive elements, polonium and radium, proving that radioactivity was a property of certain atoms themselves. The discovery upended physics. Atoms, supposedly the indivisible building blocks of matter, were clearly coming apart. Something inside them was breaking down and releasing energy. This realization led directly to nuclear physics, quantum mechanics, and eventually to both nuclear power and nuclear weapons. Becquerel, the Curies, and other early researchers worked with radioactive materials without protection. Many developed radiation sickness. Marie Curie's notebooks remain so contaminated that they're stored in lead-lined boxes. She died of aplastic anemia, almost certainly caused by decades of radiation exposure. The discovery that changed physics also killed many of its discoverers.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#00695C"
                )
            ]
        ),

        // STORY 27: The Challenger Deep
        Story(
            title: "Journey to Challenger Deep",
            slug: "challenger-deep",
            description: "Humanity's deepest dive",
            category: "Science",
            thumbnailColor: "#0D47A1",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On January 23, 1960, two men descended to the deepest point in the ocean. Jacques Piccard and Don Walsh squeezed into a steel sphere barely large enough to hold them both, attached to a gasoline-filled float called the Trieste. Their destination was Challenger Deep, a slot in the Mariana Trench nearly seven miles below the surface. The pressure at that depth is over sixteen thousand pounds per square inch, enough to crush a conventional submarine like a paper cup. The descent took nearly five hours. Through the tiny porthole, Piccard and Walsh watched the water darken from blue to absolute black. They passed through layers of bioluminescent creatures that flashed in the darkness, the only light in a world that had never seen the sun. At thirty-two thousand feet, a loud cracking sound echoed through the sphere. One of the outer Plexiglas windows had cracked under the pressure. They continued descending. At 1:06 PM, the Trieste settled onto the bottom of Challenger Deep, 35,814 feet below the surface. Through the porthole, Piccard observed what appeared to be a flatfish resting on the seafloor, proof that life existed even at these crushing depths. They stayed for twenty minutes before beginning the three-hour ascent. No human would return to Challenger Deep for over fifty years. In 2012, filmmaker James Cameron made a solo descent in a custom submersible, spending three hours exploring the bottom. Since then, a handful of others have followed. The deepest point on Earth remains less visited than the moon. More humans have walked on the lunar surface than have touched the floor of Challenger Deep.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#0D47A1"
                )
            ]
        ),

        // STORY 28: The First Organ Transplant
        Story(
            title: "18 Days with a New Heart",
            slug: "first-heart-transplant",
            description: "The operation that shocked the world",
            category: "Science",
            thumbnailColor: "#C62828",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On December 3, 1967, in Cape Town, South Africa, a surgeon named Christiaan Barnard removed a dying man's heart and replaced it with the heart of a woman who had been killed in a car accident hours earlier. Louis Washkansky, fifty-four years old, had advanced heart disease. Denise Darvall, twenty-five, had suffered fatal brain injuries. Her father gave permission to use her organs. The operation lasted nine hours. Barnard led a team of thirty, cutting through Washkansky's chest, connecting him to a heart-lung machine, excising his failing heart, and carefully sewing the donor heart into place. When the clamps were released and blood flowed into the new heart, it began beating on its own. Washkansky survived the surgery and lived for eighteen days before dying of pneumonia. His immune system, suppressed to prevent rejection of the foreign organ, couldn't fight off the infection. But he had proven that cardiac transplantation was possible. The news stunned the world. Headlines proclaimed medical miracles. Barnard became an instant celebrity, appearing on magazine covers and talk shows around the globe. More transplants followed rapidly, though early results were grim. Most patients died within weeks or months, their bodies rejecting the foreign tissue. The breakthrough came with improved immunosuppressive drugs. By the 1980s, one-year survival rates exceeded eighty percent. Today, heart transplants are routine, with thousands performed annually worldwide. Washkansky's eighteen days changed medicine forever. A heart, that most symbolic of organs, could be moved from one body to another. Death, it turned out, was more negotiable than anyone had imagined.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#C62828"
                )
            ]
        ),

        // STORY 29: The Discovery of Penicillin
        Story(
            title: "A Moldy Dish Saved Millions",
            slug: "discovery-penicillin",
            description: "The mold that saved millions",
            category: "Science",
            thumbnailColor: "#2E7D32",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In September 1928, Alexander Fleming returned from vacation to find his laboratory in disarray. Petri dishes containing staphylococcus bacteria had been left out while he was away. Most were contaminated with mold, ruined for his experiments. But one dish showed something strange. Around a spot of blue-green mold, the bacteria had died, leaving a clear ring where nothing grew. Fleming could have thrown the dish away. Instead, he investigated. The mold was Penicillium notatum, a common fungus that grows on bread and fruit. Something it produced was killing bacteria on contact. Fleming named the substance penicillin and published his findings, but he lacked the resources to develop it further. The paper attracted little attention. For a decade, penicillin remained a laboratory curiosity. Then World War II created urgent demand for treatments for infected wounds. In 1940, Howard Florey and Ernst Boris Chain at Oxford managed to purify enough penicillin to test on mice, then on humans. The results were miraculous. Infections that had been death sentences could now be cured in days. American pharmaceutical companies scaled up production. By D-Day in 1944, there was enough penicillin to treat every wounded Allied soldier. Diseases that had killed millions throughout history suddenly became manageable. Fleming, Florey, and Chain shared the 1945 Nobel Prize in Medicine. Fleming himself warned that bacteria would eventually develop resistance if antibiotics were overused, a prediction that has proven grimly accurate. Today, antibiotic-resistant bacteria kill over a million people annually worldwide. The miracle drug is losing its power, and the race continues to find what comes next.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#2E7D32"
                )
            ]
        ),

        // MARK: - ART

        // STORY 30: The Theft of the Mona Lisa
        Story(
            title: "How the Mona Lisa Got Famous",
            slug: "mona-lisa-theft",
            description: "The heist that made her famous",
            category: "Art",
            thumbnailColor: "#5D4037",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On August 21, 1911, the Mona Lisa vanished from the Louvre. A museum worker noticed the empty space on the wall and assumed the painting had been removed for photography. It wasn't until the following day that anyone realized Leonardo da Vinci's masterpiece had been stolen. The thief was Vincenzo Peruggia, an Italian handyman who had helped install the painting's protective glass case. He had hidden in a closet overnight, removed the painting from the wall, slipped it under his coat, and walked out the front door. The Louvre had no alarms. The guards hadn't noticed. For over two years, the Mona Lisa sat wrapped in cloth at the bottom of Peruggia's trunk in a Paris boarding house. The theft caused an international sensation. Newspapers ran front-page stories for weeks. The empty wall where the painting had hung became a tourist attraction. Crowds came to stare at the four iron pegs that had held the most famous painting in the world. Police suspected everyone. Pablo Picasso was questioned. The poet Guillaume Apollinaire was arrested and held for a week before being released. Conspiracy theories multiplied. The Kaiser had ordered it stolen. American millionaires had it hidden on a yacht. A shadowy collector had commissioned forgeries and stolen the original to legitimize the fakes. The truth was stranger than fiction. Peruggia, an Italian nationalist, believed he was repatriating a treasure stolen by Napoleon. He was historically wrong—Leonardo himself had brought the painting to France, and it had been acquired legitimately by King Francis I. When Peruggia finally tried to sell the painting to a Florence art dealer in 1913, he was immediately arrested. He served seven months in prison and returned to France as a minor celebrity. The Mona Lisa returned to the Louvre behind bulletproof glass, more famous than ever. Before the theft, it had been one of many masterpieces. After the theft, it was the most recognized painting on Earth. The crime had done what centuries of critical acclaim could not: it had made the Mona Lisa a legend.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#5D4037"
                )
            ]
        ),

        // STORY 31: Banksy's Shredded Painting
        Story(
            title: "Banksy's Painting Shredded Itself",
            slug: "banksy-shredded-painting",
            description: "When a painting self-destructed at auction",
            category: "Art",
            thumbnailColor: "#212121",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    On October 5, 2018, a painting by the anonymous street artist Banksy sold at Sotheby's in London for 1.04 million pounds. The moment the auctioneer's hammer fell, the painting began to shred itself. A hidden mechanism built into the ornate gold frame activated, feeding the canvas through a paper shredder. Gasps filled the auction room. The lower half of the image—a little girl reaching for a red heart-shaped balloon—emerged from the bottom of the frame in ribbons. The shredding stopped halfway down, leaving the work half intact and half destroyed. Banksy, watching remotely, posted a video to Instagram showing himself building the device years earlier, with the caption: "The urge to destroy is also a creative urge." The art world had never seen anything like it. Sotheby's initially feared a lawsuit, but something unexpected happened: the buyer, a European collector, chose to keep the work. Art critics debated whether the piece had been destroyed or transformed into something new. Within days, it was given a new title: "Love Is in the Bin." Banksy authenticated it as a new work of art. Experts predicted the half-shredded painting was now worth more than the original. They were right. In 2021, "Love Is in the Bin" sold again at Sotheby's—this time for 18.6 million pounds, making it the most expensive Banksy ever sold. The act of destruction had increased its value nearly twentyfold. The stunt crystallized Banksy's critique of the art market. A work mocking the commodification of art had become more commodified than ever. The very collectors Banksy was satirizing competed to own proof of his contempt for them. Whether this represents the triumph of capitalism or the ultimate conceptual art joke depends on who you ask. The shredder, still embedded in the frame, remains part of the piece.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#212121"
                )
            ]
        ),

        // STORY 32: The Hays Code
        Story(
            title: "Hollywood's 34 Years of Censorship",
            slug: "hays-code",
            description: "How Hollywood censored itself for 34 years",
            category: "Art",
            thumbnailColor: "#1A237E",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    From 1934 to 1968, every Hollywood film had to be approved by a single man's office before it could be released. The Motion Picture Production Code, known as the Hays Code, dictated what Americans could and couldn't see on screen. No profanity. No nudity. No depictions of drug use. No interracial relationships. No criminals going unpunished. No clergy shown in a negative light. Married couples had to sleep in separate beds. The code emerged from scandal. In the early 1920s, a series of Hollywood controversies—drug overdoses, mysterious deaths, accusations of assault—had convinced religious groups that the film industry was corrupting American morals. Rather than face government censorship, the studios hired Will H. Hays, a former Postmaster General, to clean up their image. The initial code was largely ignored until 1934, when Catholic groups threatened a nationwide boycott. The studios caved. Joseph Breen, a devout Catholic with a talent for creative reinterpretation, became the code's chief enforcer. Every script had to be submitted to his office. Every scene had to be approved. Films that violated the code couldn't be shown in major theaters. Directors learned to work around the restrictions. Alfred Hitchcock became a master of suggestive editing, implying violence without showing it. Billy Wilder crafted dialogue with double meanings that sailed past the censors. The code created its own aesthetic—a language of visual euphemism that audiences learned to decode. Couples would embrace, the camera would pan to waves crashing on a beach, and everyone understood what had happened. The code began crumbling in the 1950s as television competed for audiences and foreign films offered content Hollywood couldn't match. By 1968, it was replaced by the ratings system still used today. The strange era of official censorship had ended, leaving behind thousands of films shaped by what they couldn't show—and a lasting question about who decides what audiences can handle.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#1A237E"
                )
            ]
        ),

        // STORY 33: The Nazi Art Theft
        Story(
            title: "History's Greatest Art Heist",
            slug: "nazi-art-theft",
            description: "The greatest cultural heist in history",
            category: "Art",
            thumbnailColor: "#B71C1C",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    Between 1933 and 1945, the Nazi regime stole an estimated 600,000 works of art from museums, galleries, churches, and private collections across Europe. It was the largest organized theft of cultural property in human history. Hitler, a failed artist himself, dreamed of building the world's greatest museum in his hometown of Linz, Austria. The Führermuseum would house the masterpieces of Western civilization, proving German cultural supremacy. To fill it, special task forces followed the Wehrmacht into conquered territories, systematically cataloging and seizing anything of value. Hermann Göring, Hitler's second-in-command, was even more rapacious. His personal collection eventually numbered over 1,500 works, including paintings by Vermeer, Raphael, and Cranach. He transformed his country estate into a private museum, forcing conquered nations to "gift" him their treasures. Jewish collectors were targeted first. Families who had spent generations assembling world-class collections watched helplessly as Nazi officials loaded their property onto trucks. Those who resisted were sent to concentration camps. Many families were murdered; their art scattered across the Reich. The Allies knew what was happening. As the war ended, specialized units called "Monuments Men" raced to locate Nazi storage sites before the artwork could be destroyed or looted again. They found thousands of works hidden in salt mines, castles, and caves—including the entire contents of the Rothschild collection stuffed into a single Austrian mine. Eighty years later, the recovery effort continues. Families still search for lost paintings. Museums quietly return works with questionable provenance. Some estimates suggest 100,000 pieces remain missing. They hang in living rooms and bank vaults around the world, their true histories hidden or forgotten.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#B71C1C"
                )
            ]
        ),

        // STORY 34: Han van Meegeren's Forgeries
        Story(
            title: "The Forger Who Fooled the Nazis",
            slug: "van-meegeren-forgeries",
            description: "The con artist who painted his way to fame",
            category: "Art",
            thumbnailColor: "#6A1B9A",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In 1945, Dutch police arrested Han van Meegeren for collaborating with the enemy. He had sold a priceless Vermeer painting to Hermann Göring, the highest-ranking Nazi to stand trial at Nuremberg. The charge carried the death penalty. Van Meegeren's defense was extraordinary: the painting was a fake. He had painted it himself. At first, no one believed him. The work, "Christ with the Adulteress," had been authenticated by the world's leading Vermeer expert and had fooled every curator who examined it. Van Meegeren had sold similar "Vermeers" to Dutch museums for millions. The idea that a mediocre modern artist could have created them seemed absurd. So van Meegeren offered to prove it. Under police guard, using seventeenth-century materials and techniques he had spent years perfecting, he painted another "Vermeer" from scratch. The demonstration was conclusive. The Dutch courts faced an unusual problem. Van Meegeren had committed fraud on an enormous scale, deceiving his country's most prestigious institutions. But he had also cheated the Nazis, taking Göring's money for a worthless fake. In the aftermath of occupation, that made him a folk hero. He was convicted of forgery and sentenced to one year in prison—a remarkably light sentence that he never served. Van Meegeren died of a heart attack two months after his conviction, famous at last, though not for the reasons he had hoped. His forgeries remain technically impressive, but art historians now wonder how anyone was ever fooled. The "Vermeers" look nothing like Vermeer's actual style. The faces are oddly modern, the compositions clumsy. Experts had seen what they wanted to see, and their certainty had blinded everyone else. Van Meegeren's greatest forgery wasn't a painting—it was the myth of expert infallibility.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#6A1B9A"
                )
            ]
        ),

        // STORY 35: The Making of Apocalypse Now
        Story(
            title: "Apocalypse Now Nearly Killed Coppola",
            slug: "apocalypse-now-making",
            description: "The film that nearly killed its director",
            category: "Art",
            thumbnailColor: "#1B5E20",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    The original shooting schedule was sixteen weeks. It took over a year. The budget tripled. The lead actor had a heart attack. The director contemplated suicide. A typhoon destroyed the sets. The film's star arrived overweight, unprepared, and reportedly drunk. Francis Ford Coppola called it his "Vietnam." When he began filming Apocalypse Now in the Philippines in 1976, Coppola was the most celebrated director in America. The Godfather films had made him rich and powerful. He had convinced United Artists to fund his vision of Joseph Conrad's "Heart of Darkness" transposed to the Vietnam War, with Martin Sheen as a captain sent upriver to assassinate a rogue colonel played by Marlon Brando. Everything went wrong. Harvey Keitel was fired after two weeks and replaced by Sheen, who arrived to find no finished script. Brando showed up massively overweight, having read neither the source novel nor his lines. Coppola shot around him, filming Brando in shadow to hide his size, improvising scenes as they went. Then Sheen, only thirty-six years old, suffered a near-fatal heart attack. Production shut down while he recovered. Coppola, who had invested his own money when the budget overran, began having breakdowns on set. "My film is not about Vietnam," he said at Cannes. "It is Vietnam." The Philippine military, which had lent Coppola helicopters, kept recalling them to fight actual insurgents, leaving the production without equipment. When Typhoon Olga struck, it destroyed the elaborate sets, adding months to the schedule. The film finally premiered in 1979, nearly four years after shooting began. It won the Palme d'Or and was nominated for eight Academy Awards. Critics argued over whether it was a masterpiece or an expensive mess. Coppola himself seemed uncertain. "We had access to too much money, too much equipment, and little by little we went insane," he later said. The making of the film had become indistinguishable from its subject: a journey into madness from which no one emerged unchanged.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#1B5E20"
                )
            ]
        ),

        // STORY 36: The Bauhaus School
        Story(
            title: "14 Years That Shaped Modern Design",
            slug: "bauhaus-school",
            description: "The design school that shaped the modern world",
            category: "Art",
            thumbnailColor: "#E63946",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    In 1919, in a Germany still reeling from defeat in World War I, an architect named Walter Gropius founded a school that would change how the world looks. The Bauhaus existed for only fourteen years before the Nazis closed it. In that brief span, it invented modern design. Gropius believed that art, craft, and technology should be unified. The old distinctions between fine art and practical design were obsolete. A well-designed chair could be as meaningful as a painting. A building could be a machine for living. Form should follow function. The school attracted visionaries. Paul Klee and Wassily Kandinsky taught painting. Marcel Breuer designed the first tubular steel furniture. László Moholy-Nagy pioneered photography and graphic design. Students learned weaving, metalwork, typography, and architecture, trained to approach every problem with fresh eyes. The aesthetic that emerged was radical: clean lines, primary colors, sans-serif typefaces, buildings of glass and steel with no ornamentation. The Bauhaus rejected decoration as dishonest, a relic of a bourgeois past that had led Europe into catastrophe. The new world would be rational, functional, democratic. Everything from teapots to skyscrapers would follow the same principles. The Nazis saw it differently. To them, the Bauhaus represented everything wrong with Weimar Germany—internationalism, modernism, Jewish influence. In 1933, the school was forced to close. Its teachers scattered across Europe and America, bringing their ideas with them. Gropius went to Harvard. Mies van der Rohe redesigned the Chicago skyline. Moholy-Nagy founded a new Bauhaus in Chicago that became the Illinois Institute of Technology. The school's influence multiplied. Apple's minimalist products, IKEA's democratic design, the clean lines of modern architecture—all trace back to those fourteen years in Weimar and Dessau. The Nazis destroyed the Bauhaus. Its ideas conquered the world.
                    """,
                    textColor: "#FFFFFF",
                    backgroundColor: "#E63946"
                )
            ]
        ),

        // STORY 37: The Destruction of the Buddhas
        Story(
            title: "1,500 Years of History, Destroyed",
            slug: "buddhas-bamiyan",
            description: "When the Taliban destroyed 1,500 years of history",
            category: "Art",
            thumbnailColor: "#FF8F00",
            sections: [
                ContentBlock(
                    position: 0,
                    blockType: .text,
                    textContent: """
                    For fifteen centuries, two giant Buddhas stood carved into a cliff face in central Afghanistan. The larger figure rose 180 feet, the tallest standing Buddha in the world. The smaller was 120 feet. Travelers on the Silk Road had marveled at them since the sixth century. In March 2001, the Taliban destroyed them both. The demolition took weeks. Anti-aircraft guns and artillery made little impression on the sandstone. Explosives were lowered from above. The statues were too massive to fall easily. Taliban soldiers worked methodically, blasting away the faces first, then the bodies, reducing 1,500 years of history to rubble in the Bamiyan Valley. The international community watched in horror. Diplomats from Japan, India, and Sri Lanka flew to Kabul to plead for the statues. The Metropolitan Museum of Art offered to buy them. UNESCO declared them World Heritage sites. Taliban leader Mullah Omar was unmoved. The statues were idols, he declared, and Islam forbade idols. It didn't matter that no one had worshipped them for a thousand years, that Afghanistan's Buddhist population had vanished centuries ago, that the statues were beloved by Muslims and tourists alike. The ideology was absolute. The destruction revealed something the world would soon learn more fully. Six months after the Buddhas fell, al-Qaeda attacked New York and Washington from Taliban-controlled Afghanistan. The same absolutism that could not tolerate ancient statues would not hesitate to kill thousands. After the American invasion, archaeologists returned to Bamiyan. They found fragments of the statues, some bearing traces of the original paint that had once made them magnificent. Behind the rubble, they discovered cave paintings that had been hidden for centuries. There has been talk of rebuilding the Buddhas using 3D printing or other technologies, but the niches remain empty. In their absence, they have become a different kind of monument—to destruction, to loss, and to the fragility of everything humans create.
                    """,
                    textColor: "#000000",
                    backgroundColor: "#FF8F00"
                )
            ]
        )
    ]
}
