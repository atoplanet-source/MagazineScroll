-- MagazineScroll Supabase Schema
-- Run this in your Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Stories table
CREATE TABLE stories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    slug VARCHAR(255) UNIQUE NOT NULL,
    title VARCHAR(500) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    thumbnail_color VARCHAR(7) DEFAULT '#000000',
    published BOOLEAN DEFAULT false,
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    body_text TEXT,  -- Full story text for the app to paginate

    -- Design config stored as JSONB
    design_config JSONB NOT NULL DEFAULT '{}'::jsonb
);

-- Indexes for stories
CREATE INDEX stories_category_idx ON stories(category);
CREATE INDEX stories_published_idx ON stories(published, published_at DESC);

-- Content blocks table
CREATE TABLE content_blocks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    story_id UUID REFERENCES stories(id) ON DELETE CASCADE,
    position INTEGER NOT NULL,
    block_type VARCHAR(50) NOT NULL DEFAULT 'text',
    title VARCHAR(500),
    text_content TEXT,
    text_color VARCHAR(7) DEFAULT '#000000',
    accent_color VARCHAR(7),
    image_url TEXT,
    image_style VARCHAR(20),
    background_color VARCHAR(7) DEFAULT '#FFFFFF',
    created_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(story_id, position)
);

CREATE INDEX content_blocks_story_idx ON content_blocks(story_id, position);

-- Images metadata table
CREATE TABLE story_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    story_id UUID REFERENCES stories(id) ON DELETE CASCADE,
    filename VARCHAR(255) NOT NULL,
    storage_path TEXT NOT NULL,
    public_url TEXT NOT NULL,
    width INTEGER,
    height INTEGER,
    file_size INTEGER,
    uploaded_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX story_images_story_idx ON story_images(story_id);

-- Enable Row Level Security
ALTER TABLE stories ENABLE ROW LEVEL SECURITY;
ALTER TABLE content_blocks ENABLE ROW LEVEL SECURITY;
ALTER TABLE story_images ENABLE ROW LEVEL SECURITY;

-- Public read access for published stories
CREATE POLICY "Public can read published stories" ON stories
    FOR SELECT USING (published = true);

CREATE POLICY "Public can read content blocks of published stories" ON content_blocks
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM stories
            WHERE stories.id = content_blocks.story_id
            AND stories.published = true
        )
    );

CREATE POLICY "Public can view images of published stories" ON story_images
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM stories
            WHERE stories.id = story_images.story_id
            AND stories.published = true
        )
    );

-- Full access for service role (used by sync script)
-- These use the service_role key which bypasses RLS
