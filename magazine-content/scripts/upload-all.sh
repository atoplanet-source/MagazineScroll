#!/bin/bash

# Bulk upload all stories to Supabase
# Usage: SUPABASE_URL=... SUPABASE_SERVICE_KEY=... ./scripts/upload-all.sh

SUPABASE_URL="${SUPABASE_URL:?Missing SUPABASE_URL environment variable}"
SUPABASE_KEY="${SUPABASE_SERVICE_KEY:?Missing SUPABASE_SERVICE_KEY environment variable}"

upload_story() {
  local slug="$1"
  local title="$2"
  local description="$3"
  local category="$4"
  local thumbnail_color="$5"
  local body_text="$6"
  local design_config="$7"

  echo "Uploading: $title..."

  curl -s --fail -X POST \
    "${SUPABASE_URL}/rest/v1/stories" \
    -H "Content-Type: application/json" \
    -H "apikey: ${SUPABASE_KEY}" \
    -H "Authorization: Bearer ${SUPABASE_KEY}" \
    -H "Prefer: resolution=merge-duplicates,return=minimal" \
    -d @- <<EOF
{
  "slug": "$slug",
  "title": "$title",
  "description": "$description",
  "category": "$category",
  "thumbnail_color": "$thumbnail_color",
  "published": true,
  "published_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "body_text": $(echo "$body_text" | jq -Rs .),
  "design_config": $design_config,
  "updated_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

  if [ $? -eq 0 ]; then
    echo "  Done!"
  else
    echo "  Error!"
  fi
}

echo "Starting bulk upload of all stories..."
echo ""
