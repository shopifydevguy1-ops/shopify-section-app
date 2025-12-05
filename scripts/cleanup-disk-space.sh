#!/bin/bash
# Script to clean up disk space on Z.com server
# Run this via SSH on your Z.com server

echo "=== Disk Space Cleanup Script ==="
echo ""

# Show current disk usage
echo "Current disk usage:"
df -h /home/azwywnto
echo ""

# Navigate to home directory
cd /home/azwywnto || {
    echo "Error: Cannot access /home/azwywnto" >&2
    exit 1
}

echo "=== Finding large directories ==="
echo "Top 10 largest directories:"
du -h --max-depth=1 2>/dev/null | sort -hr | head -10
echo ""

echo "=== Cleaning up node_modules directories ==="
find /home/azwywnto -type d -name "node_modules" -exec du -sh {} \; 2>/dev/null
read -p "Delete all node_modules directories? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find /home/azwywnto -type d -name "node_modules" -exec rm -rf {} + 2>/dev/null
    echo "✓ Deleted node_modules directories"
else
    echo "Skipped node_modules deletion"
fi
echo ""

echo "=== Cleaning up .next build directories ==="
find /home/azwywnto -type d -name ".next" -exec du -sh {} \; 2>/dev/null
read -p "Delete all .next directories? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find /home/azwywnto -type d -name ".next" -exec rm -rf {} + 2>/dev/null
    echo "✓ Deleted .next directories"
else
    echo "Skipped .next deletion"
fi
echo ""

echo "=== Cleaning up out directories (static exports) ==="
find /home/azwywnto -type d -name "out" -exec du -sh {} \; 2>/dev/null
read -p "Delete all out directories? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find /home/azwywnto -type d -name "out" -exec rm -rf {} + 2>/dev/null
    echo "✓ Deleted out directories"
else
    echo "Skipped out deletion"
fi
echo ""

echo "=== Cleaning up log files ==="
find /home/azwywnto -type f \( -name "*.log" -o -name "npm-debug.log*" -o -name "yarn-debug.log*" -o -name "yarn-error.log*" \) -exec ls -lh {} \; 2>/dev/null | head -10
read -p "Delete all log files? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find /home/azwywnto -type f \( -name "*.log" -o -name "npm-debug.log*" -o -name "yarn-debug.log*" -o -name "yarn-error.log*" \) -delete 2>/dev/null
    echo "✓ Deleted log files"
else
    echo "Skipped log file deletion"
fi
echo ""

echo "=== Cleaning up .DS_Store files (macOS) ==="
find /home/azwywnto -type f -name ".DS_Store" -exec ls -lh {} \; 2>/dev/null | wc -l | xargs echo "Found .DS_Store files:"
read -p "Delete all .DS_Store files? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find /home/azwywnto -type f -name ".DS_Store" -delete 2>/dev/null
    echo "✓ Deleted .DS_Store files"
else
    echo "Skipped .DS_Store deletion"
fi
echo ""

echo "=== Cleaning up TypeScript build info ==="
find /home/azwywnto -type f -name "*.tsbuildinfo" -exec ls -lh {} \; 2>/dev/null | head -5
read -p "Delete all .tsbuildinfo files? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find /home/azwywnto -type f -name "*.tsbuildinfo" -delete 2>/dev/null
    echo "✓ Deleted .tsbuildinfo files"
else
    echo "Skipped .tsbuildinfo deletion"
fi
echo ""

echo "=== Cleaning up tmp directory (be careful!) ==="
if [ -d "/home/azwywnto/tmp" ]; then
    du -sh /home/azwywnto/tmp
    read -p "Clean tmp directory? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        find /home/azwywnto/tmp -type f -mtime +7 -delete 2>/dev/null
        echo "✓ Cleaned old files from tmp (older than 7 days)"
    else
        echo "Skipped tmp cleanup"
    fi
fi
echo ""

echo "=== Final disk usage ==="
df -h /home/azwywnto
echo ""

echo "=== Cleanup complete! ==="
echo "Note: node_modules and .next will be regenerated on next deployment"

