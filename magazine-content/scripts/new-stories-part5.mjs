/**
 * New Stories Part 5 - Final batch
 * 19th Century (+4), Science (+4), Art (+4) = 12 stories
 * Usage: SUPABASE_URL=... SUPABASE_SERVICE_KEY=... node scripts/new-stories-part5.mjs
 */

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error("Missing required environment variables: SUPABASE_URL, SUPABASE_SERVICE_KEY");
  process.exit(1);
}

const stories = [
  // ========== 19TH CENTURY (+4) ==========
  {
    slug: "great-famine-ireland",
    title: "The Great Famine of Ireland",
    description: "When blight destroyed Ireland's potatoes and a million people starved",
    category: "19th Century",
    thumbnail_color: "#2E5A3C",
    body_text: `The first sign appeared in September 1845. A farmer in County Wexford noticed black spots on his potato leaves. Within days, the spots spread. The potatoes beneath turned to foul-smelling mush.

The blight was Phytophthora infestans, a water mold that had crossed the Atlantic from America. It spread through the air, through rain, through the very soil itself. Within weeks, it had reached every corner of Ireland.

For three million Irish families, the potato wasn't just food. It was everything. A single acre could feed a family for a year. The poor ate potatoes for breakfast, lunch, and dinner—sometimes ten pounds per person per day.

Now the potatoes were rotting in the ground.

The first winter killed 100,000 people. The British government's response was to open workhouses where the starving could break stones in exchange for thin gruel. To qualify, families had to surrender their land.

The second year was worse. The blight returned. What little seed potatoes remained were destroyed. Entire villages starved together, their bodies found in ditches, in abandoned cottages, along the roads to ports.

Landlords began mass evictions. If tenants couldn't pay rent, they were thrown out. Soldiers demolished cottages to prevent families from returning. In County Clare, one landlord evicted 6,000 people in a single year.

Those who could afford passage fled. "Coffin ships" carried the desperate across the Atlantic, their holds packed so tightly that typhus spread like fire. One in five passengers died at sea.

By 1852, Ireland had lost a quarter of its population. One million dead from starvation and disease. Another million fled to America, Canada, Australia. Whole villages stood empty, their thatched roofs collapsing into the rain.

The land itself changed. Fields that once grew potatoes went to cattle. The population never recovered. To this day, Ireland has fewer people than it did in 1845.

Some called it a famine. Others called it something worse: a catastrophe that could have been prevented, a tragedy of policy as much as blight.`,
    design_config: {
      titleBackground: "#2E5A3C",
      titleText: "#FFFFFF",
      colors: ["#2E5A3C", "#1A3D28", "#4A7C5F", "#8B4513", "#D4C5A9"],
      imageColors: ["#4A7C5F", "#8B4513"],
      imageAspectRatios: [1.3, 0.9],
      imagePositions: [2, 5]
    }
  },
  {
    slug: "crystal-palace-exhibition",
    title: "The Crystal Palace Exhibition",
    description: "When Victorian Britain built an iron cathedral to showcase the world",
    category: "19th Century",
    thumbnail_color: "#4169E1",
    body_text: `In 1850, Prince Albert had a vision: a great exhibition showcasing the industrial achievements of all nations. There was just one problem. They needed a building large enough to hold it, and they needed it in less than a year.

The Building Committee received 245 designs. They rejected them all. Then a gardener named Joseph Paxton sketched something extraordinary on a piece of blotting paper during a railway board meeting.

His design was revolutionary: a massive greenhouse made entirely of iron and glass. No bricks, no mortar. Just prefabricated components that could be assembled like a giant kit.

The Crystal Palace rose in Hyde Park at astonishing speed. 2,000 workers erected 4,500 tons of iron, 400 tons of glass, and 600,000 cubic feet of timber. Full-grown elm trees were enclosed within it rather than cut down.

When it opened on May 1, 1851, Queen Victoria called it "magical." The building was 1,848 feet long—longer than six football fields. Sunlight streamed through 300,000 panes of glass, casting rainbows across the exhibits below.

Six million people came. They marveled at the Koh-i-Noor diamond, the world's largest. They studied McCormick's reaper, which would transform American agriculture. They puzzled over a folding piano for yacht owners and an alarm bed that tipped sleepers onto the floor.

The American exhibits drew particular attention. Cyrus McCormick's reaper. Samuel Colt's revolvers. Goodyear's vulcanized rubber. Critics who had mocked the American section as "prairies" fell silent.

The exhibition ran for five months, attracted visitors from every continent, and turned a substantial profit. It had proven something remarkable: that nations could compete through innovation rather than warfare.

After the exhibition closed, the Crystal Palace was dismantled and rebuilt on a hill in south London, where it stood for 85 years. It burned in 1936. Nothing like it has been built since.`,
    design_config: {
      titleBackground: "#4169E1",
      titleText: "#FFFFFF",
      colors: ["#4169E1", "#1E3A8A", "#5B8CDE", "#F5F5F5", "#C0C0C0"],
      imageColors: ["#5B8CDE", "#C0C0C0"],
      imageAspectRatios: [1.6, 0.8],
      imagePositions: [3, 6]
    }
  },
  {
    slug: "taiping-rebellion",
    title: "The Taiping Rebellion",
    description: "When a failed scholar declared himself Jesus's brother and nearly toppled China",
    category: "19th Century",
    thumbnail_color: "#8B0000",
    body_text: `Hong Xiuquan failed the civil service exam four times. In a fever dream after his fourth failure, he saw visions: he was the younger brother of Jesus Christ, sent to destroy demons and establish a heavenly kingdom on Earth.

In 1851, he announced the Taiping Heavenly Kingdom in southern China. His followers believed him. Within two years, they had captured Nanjing, a city of one million people, and made it their capital.

The Taiping weren't just rebels. They were revolutionaries with a vision. They banned foot-binding, the practice that had crippled Chinese women for centuries. They prohibited opium, alcohol, and gambling. They declared men and women equal.

Their army swelled to over a million soldiers, including entire regiments of women warriors. They swept through southern China, capturing city after city, threatening to topple the Qing dynasty that had ruled for two centuries.

Hong ruled from a massive palace in Nanjing, surrounded by 88 concubines—a contradiction of his own teachings he seemed not to notice. He spent his days writing religious tracts and poetry while his generals fought the war.

The Qing fought back with help from European powers who feared the Taiping's anti-opium stance. Frederick Townsend Ward, an American soldier of fortune, organized the "Ever Victorious Army" to defend Shanghai.

The war lasted 14 years. Battles killed hundreds of thousands. Famine killed millions more. Cities that resisted were massacred to the last child. Refugees fled in waves of humanity that stripped the countryside bare.

When Nanjing finally fell in 1864, Hong Xiuquan was already dead—probably from eating wild vegetables during the siege. The victorious Qing killed every Taiping they could find.

The death toll remains almost incomprehensible: somewhere between 20 and 30 million people. It was the bloodiest civil war in human history, fought by a man who believed he was the son of God.`,
    design_config: {
      titleBackground: "#8B0000",
      titleText: "#FFFFFF",
      colors: ["#8B0000", "#5C0000", "#CD5C5C", "#FFD700", "#1A1A1A"],
      imageColors: ["#FFD700", "#CD5C5C"],
      imageAspectRatios: [1.2, 1.0],
      imagePositions: [2, 5]
    }
  },
  {
    slug: "scramble-for-africa",
    title: "The Scramble for Africa",
    description: "When European powers carved up a continent in a single afternoon",
    category: "19th Century",
    thumbnail_color: "#8B4513",
    body_text: `In November 1884, representatives from 14 nations gathered in Berlin. Not a single African was invited. Over the next three months, they would divide an entire continent among themselves.

The host was Otto von Bismarck, who had no interest in colonies but plenty of interest in keeping European rivals busy elsewhere. The rules were simple: any power that occupied African territory and informed the others could claim it.

The scramble had already begun. King Leopold II of Belgium had claimed the Congo as his personal property—an area 76 times larger than Belgium itself. France was pushing into West Africa. Britain controlled Egypt and wanted Cape Colony to Cairo.

At the conference, diplomats drew lines on maps with minimal knowledge of the terrain, the peoples, or the kingdoms they were dividing. Borders cut through ethnic groups, separated families, split ancient empires.

The Asante kingdom, which had dominated West Africa for two centuries, was divided between Britain and France. The Maasai found their grazing lands split between British Kenya and German Tanganyika. The Bakongo people were split among three different colonial powers.

Within 30 years, European powers controlled 90% of Africa. Only Ethiopia, which defeated an Italian army at the Battle of Adwa, and Liberia, founded by freed American slaves, remained independent.

The Berlin Conference never mentioned the people who lived on the continent they were dividing. It spoke of "civilizing" Africans while authorizing their conquest. It invoked Christianity while enabling exploitation that would kill millions.

In the Congo alone, Leopold's rubber quotas would claim an estimated 10 million lives. Workers who didn't meet their quotas had their hands cut off. Villages that resisted were burned.

The borders drawn in Berlin remain Africa's borders today. They're why Nigeria contains 250 ethnic groups and why the Somali people are divided among five different countries. A three-month conference in a German palace shaped a continent's destiny.`,
    design_config: {
      titleBackground: "#8B4513",
      titleText: "#FFFFFF",
      colors: ["#8B4513", "#654321", "#D2691E", "#F4A460", "#2F4F4F"],
      imageColors: ["#D2691E", "#2F4F4F"],
      imageAspectRatios: [1.4, 0.85],
      imagePositions: [3, 6]
    }
  },

  // ========== SCIENCE (+4) ==========
  {
    slug: "rosalind-franklin-dna",
    title: "Rosalind Franklin and DNA",
    description: "When one photograph revealed the secret of life—and one scientist was forgotten",
    category: "Science",
    thumbnail_color: "#4B0082",
    body_text: `Photo 51 is not much to look at. An X-shaped pattern of dark spots on a gray background. But this single image, taken by Rosalind Franklin in May 1952, contained the secret of life itself.

Franklin was a 31-year-old crystallographer at King's College London. Her specialty was X-ray diffraction—bombarding molecules with X-rays and deducing their structure from the patterns they created. She was very, very good at it.

Her target was DNA. Scientists knew it carried genetic information, but no one understood its structure. Franklin spent months perfecting her technique, adjusting humidity, exposure times, and angles until she captured the clearest image of DNA ever taken.

The X pattern in Photo 51 told a story. It meant DNA was a helix—a spiral staircase of atoms winding around itself. Franklin knew this. She was methodically working toward a complete structural model.

Then, without her knowledge or permission, her colleague Maurice Wilkins showed Photo 51 to James Watson.

Watson and his partner Francis Crick had been trying to build a DNA model at Cambridge. They had made mistakes, embarrassing ones. But when Watson saw Franklin's photo, everything clicked. "My mouth fell open and my pulse began to race," he later wrote.

Within weeks, Watson and Crick had built their famous double helix model. Their 1953 paper in Nature made one small acknowledgment of "unpublished experimental results" from King's College. They didn't mention Franklin's name.

In 1962, Watson, Crick, and Wilkins received the Nobel Prize for discovering DNA's structure. Franklin had died four years earlier of ovarian cancer, possibly caused by radiation exposure from her work. Nobel rules prohibit posthumous awards.

Watson's memoir, published in 1968, portrayed Franklin as difficult, unfeminine, and unable to interpret her own data. Her supporters called it character assassination.

Today, scientists recognize what really happened. Franklin's photo was shown without her consent. Her data was used without her credit. She came closer to solving DNA's structure than anyone—and was erased from the story.`,
    design_config: {
      titleBackground: "#4B0082",
      titleText: "#FFFFFF",
      colors: ["#4B0082", "#2E0854", "#8A2BE2", "#E6E6FA", "#1A1A1A"],
      imageColors: ["#8A2BE2", "#E6E6FA"],
      imageAspectRatios: [1.0, 1.2],
      imagePositions: [2, 5]
    }
  },
  {
    slug: "crispr-discovery",
    title: "The Discovery of CRISPR",
    description: "When scientists found bacteria's ancient immune system—and turned it into a scalpel for genes",
    category: "Science",
    thumbnail_color: "#00CED1",
    body_text: `In 1987, a Japanese scientist named Yoshizumi Ishino noticed something strange in E. coli bacteria. Short, repeating DNA sequences appeared at regular intervals, separated by unique "spacer" segments. He had no idea what they were for.

For twenty years, the sequences remained a mystery. Scientists called them "clustered regularly interspaced short palindromic repeats"—CRISPR—but couldn't explain their function.

Then, in 2007, researchers at a Danish yogurt company made a breakthrough. They were studying how bacteria defend against viruses—a major problem in dairy production. They discovered that CRISPR spacers matched viral DNA exactly.

The bacteria were keeping records of past infections. When a virus attacked, the bacterium captured a snippet of viral DNA and stored it in its CRISPR array. If the same virus returned, the bacterium could recognize and destroy it.

Jennifer Doudna at Berkeley and Emmanuelle Charpentier in Sweden saw the potential. They figured out how to reprogram CRISPR to target any DNA sequence they wanted. In 2012, they published a paper showing they could use CRISPR to cut genes with unprecedented precision.

It was a molecular scalpel for the genome. Where previous gene-editing tools were like sledgehammers, CRISPR was a surgeon's blade.

Within months, scientists were using CRISPR to modify human cells. Within years, they were treating genetic diseases. In 2023, the FDA approved the first CRISPR therapy: a cure for sickle cell disease.

But CRISPR also opened darker possibilities. In 2018, a Chinese scientist named He Jiankui announced he had created the world's first gene-edited babies. The scientific community reacted with horror. He was sentenced to three years in prison.

The power to rewrite life's code had arrived faster than anyone expected. The ethical frameworks to govern it had not. CRISPR can cure diseases, enhance crops, even eliminate mosquito-borne illnesses. But it can also edit human embryos, potentially creating genetic changes that pass to future generations.

Doudna and Charpentier received the 2020 Nobel Prize. Their tool, born from bacterial immune systems billions of years old, had become humanity's most powerful technology for controlling evolution itself.`,
    design_config: {
      titleBackground: "#00CED1",
      titleText: "#FFFFFF",
      colors: ["#00CED1", "#008B8B", "#40E0D0", "#E0FFFF", "#1A1A1A"],
      imageColors: ["#40E0D0", "#008B8B"],
      imageAspectRatios: [1.3, 0.9],
      imagePositions: [3, 6]
    }
  },
  {
    slug: "human-genome-project",
    title: "The Human Genome Project",
    description: "When scientists raced to read the 3 billion letters of human DNA",
    category: "Science",
    thumbnail_color: "#2E8B57",
    body_text: `In 1990, scientists announced the most ambitious biology project in history. They would read every letter of human DNA—all 3 billion of them. It would take 15 years and $3 billion. Some said it was impossible.

DNA is written in a four-letter alphabet: A, T, G, and C. These letters pair up—A with T, G with C—to form the rungs of the double helix. The sequence of letters determines everything from eye color to disease risk.

But reading DNA was agonizingly slow. The best technology could sequence only a few hundred letters at a time. Reading 3 billion would require reading millions of overlapping fragments and stitching them together like a puzzle with no picture.

Laboratories around the world divided up the work. Each tackled a different chromosome. Massive sequencing machines ran 24 hours a day. Supercomputers assembled the fragments.

Then Craig Venter appeared. A maverick scientist with a private company called Celera, Venter announced he would sequence the genome faster and cheaper than the public project. His approach was radical: sequence random fragments and let computers figure out where they belonged.

The race was on. The public project accelerated. Venter's team worked around the clock. Relations between the two groups grew hostile. Scientists accused Venter of trying to patent human genes for profit.

In June 2000, President Clinton brokered a truce. At a White House ceremony, both teams announced a tie. They had completed a working draft of the human genome.

The results were humbling. Humans had only about 20,000 genes—barely more than a fruit fly, far fewer than a rice plant. What made us complex wasn't our number of genes but how they were regulated.

The project revealed that all humans share 99.9% of their DNA. Race, that concept that had divided humanity for centuries, had almost no genetic basis. We were all, at the molecular level, nearly identical.

Today, a human genome can be sequenced in hours for under $1,000. The technology born from that 13-year race has transformed medicine, identified disease genes, and opened the door to personalized treatment. We can now read the book of life—even if we're still learning how to understand it.`,
    design_config: {
      titleBackground: "#2E8B57",
      titleText: "#FFFFFF",
      colors: ["#2E8B57", "#1E5A3C", "#3CB371", "#98FB98", "#1A1A1A"],
      imageColors: ["#3CB371", "#98FB98"],
      imageAspectRatios: [1.5, 0.8],
      imagePositions: [2, 5]
    }
  },
  {
    slug: "voyager-golden-record",
    title: "The Voyager Golden Record",
    description: "When NASA sent humanity's message in a bottle to the stars",
    category: "Science",
    thumbnail_color: "#FFD700",
    body_text: `In 1977, NASA faced an extraordinary deadline. Two spacecraft, Voyager 1 and 2, were about to launch on a journey past Jupiter and Saturn. They would eventually leave the solar system entirely, drifting through interstellar space for billions of years.

Carl Sagan had an idea: send a message. If any intelligent beings ever encountered the Voyagers, they should know who sent them.

NASA gave Sagan and his team less than a year to create a calling card for humanity. They chose a 12-inch gold-plated copper record—the technology of the era—containing sounds and images of Earth.

Selecting the contents was agonizing. How do you summarize a planet? The team included 115 images: a diagram of human DNA, photographs of houses and schools, pictures of people eating and learning and caring for children.

The sounds were even harder. They recorded greetings in 55 languages, from ancient Sumerian to modern Wu Chinese. They included sounds of Earth: wind and rain, birds and whales, footsteps and laughter, a mother's kiss on her baby.

Music was debated intensely. They chose Bach, Beethoven, Mozart—but also Chuck Berry's "Johnny B. Goode." One committee member objected that rock and roll was "adolescent." Sagan replied: "There are a lot of adolescents on the planet."

They added Senegalese percussion, Peruvian panpipes, Australian Aboriginal songs. Blind Willie Johnson's "Dark Was the Night, Cold Was the Ground." Georgian choral singing. A Navajo night chant.

Ann Druyan, the creative director who would later marry Sagan, recorded her brain waves while thinking about human history, about Earth, about falling in love. Those thoughts are encoded on the record in the form of compressed audio.

The cover includes instructions for playing the record, etched in symbols any intelligent species should understand: a pulsar map showing Earth's location, diagrams of the record player, the hydrogen atom as a universal clock.

Both Voyagers are now in interstellar space, the most distant human-made objects in existence. Voyager 1 is 15 billion miles from Earth and still transmitting.

The records will outlast every monument on Earth. Long after our civilization is dust, these two spacecraft will drift through the galaxy, carrying the sounds of our planet—a message in a bottle thrown into an ocean of stars.`,
    design_config: {
      titleBackground: "#FFD700",
      titleText: "#1A1A1A",
      colors: ["#FFD700", "#B8860B", "#FFF8DC", "#1A1A2E", "#4169E1"],
      imageColors: ["#1A1A2E", "#4169E1"],
      imageAspectRatios: [1.0, 1.1],
      imagePositions: [3, 6]
    }
  },

  // ========== ART (+4) ==========
  {
    slug: "guernica-creation",
    title: "The Creation of Guernica",
    description: "When Picasso painted the bombing of a Spanish town—and changed art forever",
    category: "Art",
    thumbnail_color: "#2F2F2F",
    body_text: `On April 26, 1937, German bombers attacked the Spanish town of Guernica for three hours. It was market day. The streets were filled with civilians. When the smoke cleared, 1,600 people were dead and the town center was rubble.

Pablo Picasso heard the news in Paris. He had been commissioned to create a mural for the Spanish Pavilion at the World's Fair, but had been struggling for months. Now he knew exactly what to paint.

He worked in a frenzy. Within days, he had completed 45 preparatory sketches. The final canvas measured 11 feet tall and 25 feet wide. He painted it in his studio on Rue des Grands-Augustins, working by electric light because the skylights didn't provide enough illumination.

The painting is chaos rendered in black, white, and gray. A dismembered soldier clutches a broken sword. A horse screams in agony, its body pierced by a spear. A mother holds her dead child and howls at the sky. A light bulb blazes like a cold eye above the carnage.

Picasso refused to explain the symbols. When asked about the bull in the painting—standing impassive amid the destruction—he said only: "The bull is a bull... the viewer must see what he sees."

Some critics dismissed it. "The decoration of Picasso is very fine," one wrote, "but rather like a design for a very expensive wallpaper." Others recognized its power immediately.

After the World's Fair, Picasso refused to let Guernica return to Spain while Franco remained in power. It hung for decades at the Museum of Modern Art in New York, a permanent accusation against fascism.

In 1974, a man attacked it with red spray paint, writing "KILL LIES ALL." The paint was removed. In 1981, six years after Franco's death, Guernica finally went to Spain. Picasso had been dead for eight years.

Today it hangs in the Reina Sofia museum in Madrid, behind bulletproof glass. Crowds gather before it daily, staring at the screaming horse, the broken sword, the inconsolable mother.

It remains the most powerful anti-war painting ever created. Picasso took an atrocity and made it unforgettable. Eighty years later, it still screams.`,
    design_config: {
      titleBackground: "#2F2F2F",
      titleText: "#FFFFFF",
      colors: ["#2F2F2F", "#1A1A1A", "#4A4A4A", "#FFFFFF", "#696969"],
      imageColors: ["#4A4A4A", "#FFFFFF"],
      imageAspectRatios: [1.8, 0.7],
      imagePositions: [2, 5]
    }
  },
  {
    slug: "sistine-chapel-ceiling",
    title: "The Sistine Chapel Ceiling",
    description: "When Michelangelo spent four years on his back painting God",
    category: "Art",
    thumbnail_color: "#8B7355",
    body_text: `Michelangelo didn't want to paint the Sistine Chapel. He was a sculptor, not a painter. When Pope Julius II summoned him to Rome in 1508, he tried to refuse. The Pope insisted.

The chapel ceiling was 68 feet above the floor—a vast curved surface of 5,800 square feet. The Pope wanted the twelve apostles painted in the spandrels. Michelangelo thought this was boring. He counter-proposed the entire story of Genesis.

He designed his own scaffolding, a revolutionary system that didn't touch the walls. Then he climbed up and began to paint, standing on the platform with his head tilted back, paint dripping into his eyes and beard.

Contrary to legend, he didn't lie on his back. He stood, bending backward for hours at a time. The position was agonizing. He later wrote a poem about it: "My beard toward Heaven, I feel the back of my brain upon my neck."

For four years, he worked almost alone. He dismissed the assistants Julius sent, trusting no one with his vision. He painted from dawn until he couldn't see, then stumbled home to sleep in his clothes.

The central panels show the Genesis story: God dividing light from darkness, creating Adam, expelling humanity from Eden. Around them, prophets and sibyls twist and brood. Ignudi—nude male figures—frame the scenes.

The Creation of Adam became the most recognized image in Western art. God's finger reaching toward Adam's, the small gap between them charged with infinite potential. Michelangelo painted the entire Sistine ceiling and that gesture became its symbol.

When he finished in 1512, he could barely see. Paint and plaster had damaged his eyes so badly that for months he had to hold letters above his head to read them.

Julius never saw the completed ceiling. He died three months after it was unveiled. But he had been right to force Michelangelo. The sculptor had created the greatest painting of the Renaissance—a work so magnificent that 500 years later, five million people visit each year to crane their necks and stare upward, just as Michelangelo once did.`,
    design_config: {
      titleBackground: "#8B7355",
      titleText: "#FFFFFF",
      colors: ["#8B7355", "#6B5344", "#A08060", "#DEB887", "#2F4F4F"],
      imageColors: ["#A08060", "#2F4F4F"],
      imageAspectRatios: [1.4, 0.9],
      imagePositions: [3, 6]
    }
  },
  {
    slug: "frida-kahlo-accident",
    title: "Frida Kahlo's Accident",
    description: "When a bus crash created Mexico's most famous painter",
    category: "Art",
    thumbnail_color: "#C41E3A",
    body_text: `On September 17, 1925, an 18-year-old girl named Frida Kahlo was riding a wooden bus through Mexico City. A streetcar slammed into it at full speed.

The collision was catastrophic. The bus splintered. A metal handrail pierced Frida's pelvis, entering through her hip and exiting through her vagina. Her spine was broken in three places. Her collarbone shattered. Her right leg was crushed.

A witness described the scene: Frida lay broken on the ground, covered in gold powder that had spilled from a house painter's packet. She looked, he said, like a strange golden bird.

Doctors didn't expect her to survive. She spent months in a full body cast, unable to move. Her mother had a special easel built that allowed her to paint lying down. A mirror was installed above her bed.

Frida began painting herself. Over the next three decades, she would create 55 self-portraits—one-third of her entire output. "I paint myself because I am so often alone," she explained, "and because I am the subject I know best."

Her paintings were unlike anything in art history. They showed her body cut open, her spine as a cracked column, her heart exposed on her chest. They depicted her in Mexican folk dress, surrounded by monkeys and parrots, roots growing from her body.

She married Diego Rivera, Mexico's most famous muralist, twice. Their relationship was passionate, destructive, and defining for both. She painted The Two Fridas after their first divorce: two versions of herself, one in European dress, one in Mexican, their exposed hearts connected by a single artery.

The accident defined her life. She underwent 35 surgeries. She could never carry a pregnancy to term. She lived with constant pain, masked by morphine and tequila and sheer will.

When she died in 1954 at age 47, her last diary entry read: "I hope the exit is joyful—and I hope never to return." She had transformed her suffering into art that would outlive her pain, turning her broken body into images that millions would find beautiful.`,
    design_config: {
      titleBackground: "#C41E3A",
      titleText: "#FFFFFF",
      colors: ["#C41E3A", "#8B0000", "#FF6B6B", "#FFD700", "#228B22"],
      imageColors: ["#FFD700", "#228B22"],
      imageAspectRatios: [1.0, 1.2],
      imagePositions: [2, 5]
    }
  },
  {
    slug: "vincent-van-gogh-ear",
    title: "Van Gogh's Ear",
    description: "When a troubled painter cut off part of himself—and kept creating masterpieces",
    category: "Art",
    thumbnail_color: "#FFB347",
    body_text: `On December 23, 1888, in a small yellow house in Arles, France, Vincent van Gogh severed his own ear with a razor. He was 35 years old and had been painting seriously for only eight years. He would live just 19 months more.

The trigger was an argument with Paul Gauguin. Van Gogh had dreamed of founding an artists' colony in the south of France. Gauguin was the only one who came. They lived together for nine weeks, painting and arguing, their tensions escalating daily.

That December evening, Gauguin announced he was leaving. Van Gogh confronted him with a razor, then turned it on himself. He cut off most of his left ear, wrapped it in newspaper, and delivered it to a woman at the local brothel. "Guard this object carefully," he told her.

Police found him the next morning, unconscious from blood loss. He spent two weeks in the hospital, then checked himself into an asylum at Saint-Rémy. He would spend a year there, suffering repeated breakdowns.

But he also painted. In those 12 months, he created 150 canvases—roughly one every two days. Starry Night. Irises. Wheat Field with Cypresses. The paintings exploded with color and movement, swirling with an intensity that seemed to capture his turbulent mind.

He painted the asylum's garden. He painted the view from his window. He painted himself, bandaged ear and all, staring at the viewer with unsettling calm.

In May 1890, he left the asylum and moved to Auvers-sur-Oise, near Paris. He painted frantically—70 canvases in 70 days. Wheat fields under troubled skies. The church at Auvers. Dr. Gachet, his physician, looking melancholy.

On July 27, 1890, he walked into a wheat field and shot himself in the chest. He survived the bullet and walked home. He died two days later, his brother Theo holding his hand.

In his entire life, Van Gogh sold only one or two paintings. Today, his works sell for over $100 million. The yellow house in Arles was destroyed in World War II. The ear was never found.`,
    design_config: {
      titleBackground: "#FFB347",
      titleText: "#1A1A1A",
      colors: ["#FFB347", "#FF8C00", "#FFD700", "#4169E1", "#228B22"],
      imageColors: ["#4169E1", "#228B22"],
      imageAspectRatios: [1.1, 1.0],
      imagePositions: [3, 5]
    }
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
  console.log(`Uploading ${stories.length} new stories (Part 5 - Final)...\n`);
  console.log("Categories: 19th Century (+4), Science (+4), Art (+4)\n");

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

main();
