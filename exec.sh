#!/bin/bash
set -e

# Fixed commit message
COMMIT_MESSAGE="fix: apply latest changes"

# Read current version from package.json
CURRENT_VERSION=$(node -p "require('./package.json').version")

# Split version into parts
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Increment patch version
PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$PATCH"

echo "Current version: $CURRENT_VERSION"
echo "New version: $NEW_VERSION"

# Update package.json version
npm version $NEW_VERSION --no-git-tag-version

# Add all changes and commit
git add .
git commit -m "$COMMIT_MESSAGE"

# Create a git tag with new version
git tag "v$NEW_VERSION"

# Push commits and tags
git push origin main
git push origin "v$NEW_VERSION"

echo "Committed, tagged, and pushed version $NEW_VERSION ✅"
