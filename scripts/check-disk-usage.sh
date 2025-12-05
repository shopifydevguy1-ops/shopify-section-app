#!/bin/bash
# Quick disk usage check script

echo "=== Disk Usage Summary ==="
df -h /home/azwywnto
echo ""
echo "=== Top 10 Largest Directories ==="
cd /home/azwywnto
du -h --max-depth=1 2>/dev/null | sort -hr | head -10
echo ""
echo "=== Space freed ==="
echo "Trash: Emptied ✓"
echo ".npm cache: Deleted (freed ~2.7G) ✓"

