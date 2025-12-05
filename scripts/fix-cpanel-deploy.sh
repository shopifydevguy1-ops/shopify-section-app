#!/bin/bash
# Script to fix cPanel deployment issues
# Run this via SSH or cPanel Terminal on the server

echo "=== Checking cPanel Deployment Status ==="

cd /home/azwywnto/repositories/shopify-section-app-final || {
    echo "Error: Failed to change directory" >&2
    exit 1
}

echo ""
echo "1. Checking git status..."
git status

echo ""
echo "2. Checking for .cpanel.yml file..."
if [ -f ".cpanel.yml" ]; then
    echo "✅ .cpanel.yml exists"
    echo "File contents:"
    cat .cpanel.yml
else
    echo "❌ .cpanel.yml not found!"
fi

echo ""
echo "3. Checking if repository is up to date..."
git fetch origin
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" = "$REMOTE" ]; then
    echo "✅ Repository is up to date"
else
    echo "⚠️  Repository is not up to date. Run: git pull origin main"
fi

echo ""
echo "4. Checking for uncommitted changes..."
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Uncommitted changes detected!"
    echo "To fix, run one of:"
    echo "  - git add . && git commit -m 'Fix uncommitted changes'"
    echo "  - git reset --hard HEAD (discards changes)"
else
    echo "✅ No uncommitted changes"
fi

echo ""
echo "=== Done ==="

