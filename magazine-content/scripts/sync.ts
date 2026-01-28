/**
 * Sync Script - Pushes local story content to Supabase
 *
 * Usage:
 *   deno task sync              # Sync all stories
 *   deno task sync my-story     # Sync specific story
 */

import { createClient } from "@supabase/supabase-js";
import { parse as parseYaml } from "yaml";
import { load as loadEnv } from "dotenv";
import { walk } from "fs";
import * as path from "path";

// Load environment variables
await loadEnv({ export: true });

const SUPABASE_URL = Deno.env.get("SUPABASE_URL");
const SUPABASE_SERVICE_KEY = Deno.env.get("SUPABASE_SERVICE_KEY");

if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error("Missing SUPABASE_URL or SUPABASE_SERVICE_KEY in .env");
  Deno.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

// Types
interface StoryFrontmatter {
  title: string;
  slug: string;
  description?: string;
  category?: string;
  published: boolean;
  publishedAt?: string;
}

interface DesignConfig {
  thumbnailColor: string;
  titlePage: { backgroundColor: string; textColor: string };
  colorPalette: Array<{ background: string; text: string }>;
  imagePlaceholderColors: string[];
  imageAspectRatios: number[];
  imagePositionSeed: number;
  imageColorOffset: number;
}

interface ParsedImage {
  altText: string;
  filename: string;
  style: string;
}

// Parse markdown frontmatter and content
function parseStoryMarkdown(content: string): {
  frontmatter: StoryFrontmatter;
  bodyText: string;
  images: ParsedImage[];
} {
  // Extract frontmatter
  const frontmatterMatch = content.match(/^---\n([\s\S]*?)\n---/);
  if (!frontmatterMatch) {
    throw new Error("No frontmatter found in story.md");
  }

  const frontmatter = parseYaml(frontmatterMatch[1]) as StoryFrontmatter;
  let body = content.slice(frontmatterMatch[0].length).trim();

  // Extract images from body
  const imageRegex = /!\[([^\]]*)\]\(([^)]+)\s*(?:"([^"]*)")?\)/g;
  const images: ParsedImage[] = [];
  let match;

  while ((match = imageRegex.exec(body)) !== null) {
    const [, altText, imagePath, style] = match;
    const filename = path.basename(imagePath);
    images.push({
      altText: altText || filename,
      filename,
      style: style || "framed",
    });
  }

  // Remove image markdown from body text
  const bodyText = body.replace(imageRegex, "").trim();

  return { frontmatter, bodyText, images };
}

// Upload images to Supabase Storage
async function uploadImages(
  storySlug: string,
  imagesDir: string
): Promise<Map<string, string>> {
  const urlMap = new Map<string, string>();

  try {
    for await (const entry of walk(imagesDir, { maxDepth: 1 })) {
      if (entry.isFile && /\.(jpg|jpeg|png|webp)$/i.test(entry.name)) {
        console.log(`  Uploading image: ${entry.name}`);

        const fileContent = await Deno.readFile(entry.path);
        const storagePath = `${storySlug}/${entry.name}`;
        const contentType = entry.name.endsWith(".png")
          ? "image/png"
          : entry.name.endsWith(".webp")
          ? "image/webp"
          : "image/jpeg";

        const { error } = await supabase.storage
          .from("story-images")
          .upload(storagePath, fileContent, {
            contentType,
            upsert: true,
          });

        if (error) {
          console.error(`  Error uploading ${entry.name}:`, error.message);
          continue;
        }

        const {
          data: { publicUrl },
        } = supabase.storage.from("story-images").getPublicUrl(storagePath);

        urlMap.set(entry.name, publicUrl);
        console.log(`  Uploaded: ${publicUrl}`);
      }
    }
  } catch (e) {
    // Images directory might not exist
    console.log(`  No images directory found`);
  }

  return urlMap;
}

// Sync a single story
async function syncStory(storyDir: string): Promise<void> {
  const storyPath = path.join(storyDir, "story.md");
  const designPath = path.join(storyDir, "design.json");
  const imagesDir = path.join(storyDir, "images");

  // Check if story.md exists
  try {
    await Deno.stat(storyPath);
  } catch {
    console.log(`Skipping ${path.basename(storyDir)} - no story.md found`);
    return;
  }

  console.log(`\nSyncing: ${path.basename(storyDir)}`);

  // Read files
  const markdownContent = await Deno.readTextFile(storyPath);

  let designConfig: DesignConfig;
  try {
    designConfig = JSON.parse(await Deno.readTextFile(designPath));
  } catch {
    console.log(`  Warning: No design.json found, using defaults`);
    designConfig = {
      thumbnailColor: "#000000",
      titlePage: { backgroundColor: "#000000", textColor: "#FFFFFF" },
      colorPalette: [
        { background: "#000000", text: "#FFFFFF" },
        { background: "#FFFFFF", text: "#000000" },
      ],
      imagePlaceholderColors: ["#E63946", "#FFD60A"],
      imageAspectRatios: [1.4, 0.8],
      imagePositionSeed: 2,
      imageColorOffset: 0,
    };
  }

  // Parse markdown
  const { frontmatter, bodyText, images } = parseStoryMarkdown(markdownContent);

  // Upload images
  const imageUrls = await uploadImages(frontmatter.slug, imagesDir);

  // Upsert story
  const { data: story, error: storyError } = await supabase
    .from("stories")
    .upsert(
      {
        slug: frontmatter.slug,
        title: frontmatter.title,
        description: frontmatter.description,
        category: frontmatter.category,
        thumbnail_color: designConfig.thumbnailColor,
        published: frontmatter.published,
        published_at: frontmatter.published ? new Date().toISOString() : null,
        design_config: designConfig,
        body_text: bodyText,  // Include body text in stories table
        updated_at: new Date().toISOString(),
      },
      { onConflict: "slug" }
    )
    .select()
    .single();

  if (storyError) {
    console.error(`  Error upserting story:`, storyError.message);
    return;
  }

  console.log(`  Story upserted: ${story.id}`);

  // Delete existing content blocks
  const { error: deleteBlocksError } = await supabase.from("content_blocks").delete().eq("story_id", story.id);
  if (deleteBlocksError) {
    console.error(`  Error deleting content blocks:`, deleteBlocksError.message);
    return;
  }

  // Create single content block with full text
  // The app will paginate this automatically
  const { error: blocksError } = await supabase.from("content_blocks").insert({
    story_id: story.id,
    position: 0,
    block_type: "text",
    text_content: bodyText,
    text_color: "#FFFFFF",
    background_color: "#000000",
  });

  if (blocksError) {
    console.error(`  Error inserting content blocks:`, blocksError.message);
    return;
  }

  // Save image metadata
  if (images.length > 0) {
    const { error: deleteImagesError } = await supabase.from("story_images").delete().eq("story_id", story.id);
    if (deleteImagesError) {
      console.error(`  Error deleting image metadata:`, deleteImagesError.message);
      return;
    }

    const imageRecords = images
      .filter((img) => imageUrls.has(img.filename))
      .map((img) => ({
        story_id: story.id,
        filename: img.filename,
        storage_path: `${frontmatter.slug}/${img.filename}`,
        public_url: imageUrls.get(img.filename)!,
      }));

    if (imageRecords.length > 0) {
      const { error: imgError } = await supabase
        .from("story_images")
        .insert(imageRecords);

      if (imgError) {
        console.error(`  Error saving image metadata:`, imgError.message);
      }
    }
  }

  console.log(`  Synced successfully!`);
}

// Main execution
async function main() {
  const args = Deno.args;
  const storiesDir = path.join(Deno.cwd(), "stories");

  if (args.length > 0) {
    // Sync specific story
    const storySlug = args[0];
    const storyDir = path.join(storiesDir, storySlug);
    await syncStory(storyDir);
  } else {
    // Sync all stories
    console.log("Syncing all stories...");

    for await (const entry of Deno.readDir(storiesDir)) {
      if (entry.isDirectory) {
        await syncStory(path.join(storiesDir, entry.name));
      }
    }
  }

  console.log("\nDone!");
}

main().catch(console.error);
