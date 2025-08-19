#!/bin/bash
set -e

# Fixed commit message
COMMIT_MESSAGE="fix: apply latest changes"

# Get the latest Git tag
LATEST_TAG=$(git describe --tags --abbrev=0)
echo "Latest tag: $LATEST_TAG"

# Remove the leading 'v' if exists
VERSION=${LATEST_TAG#v}

# Split version into parts
IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION"

# Increment patch version
PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$PATCH"
echo "New version: $NEW_VERSION"

# Update package.json version
npm version $NEW_VERSION --no-git-tag-version

# Add all changes and commit
git add .
git commit -m "$COMMIT_MESSAGE"

# Create a new Git tag
git tag "v$NEW_VERSION"

# Push commits and tags
git push origin HEAD
git push origin "v$NEW_VERSION"

echo "Committed, tagged, and pushed version v$NEW_VERSION ✅"
