#!/bin/bash
# Script to empty the cPanel trash directory
# Run this via SSH on your Z.com server

echo "=== Emptying cPanel Trash ==="
echo ""

TRASH_DIR="/home/azwywnto/.trash"

# Check if trash directory exists
if [ ! -d "$TRASH_DIR" ]; then
    echo "Trash directory does not exist: $TRASH_DIR"
    exit 0
fi

# Show current size
echo "Current trash size:"
du -sh "$TRASH_DIR" 2>/dev/null || echo "Cannot read trash directory"
echo ""

# Count files
FILE_COUNT=$(find "$TRASH_DIR" -type f 2>/dev/null | wc -l)
echo "Files in trash: $FILE_COUNT"
echo ""

# Empty the trash
echo "Emptying trash directory..."
find "$TRASH_DIR" -mindepth 1 -delete 2>/dev/null

if [ $? -eq 0 ]; then
    echo "✓ Trash emptied successfully"
else
    echo "⚠ Some files may not have been deleted (permission issues)"
    echo "Trying with force..."
    rm -rf "$TRASH_DIR"/* 2>/dev/null
    rm -rf "$TRASH_DIR"/.* 2>/dev/null
fi

echo ""
echo "Final trash size:"
du -sh "$TRASH_DIR" 2>/dev/null || echo "Trash directory is empty or removed"
echo ""

echo "=== Done ==="

