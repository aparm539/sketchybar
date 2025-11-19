#!/bin/bash

# File watcher for sketchybar configuration
# Automatically reloads sketchybar when config files are saved
#
# Usage: ./watch.sh
# Or: ./watch.py (Python version with better cross-platform support)

CONFIG_DIR="$HOME/.config/sketchybar"
RELOAD_CMD="sketchybar --reload"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo -e "${RED}Error: fswatch is not installed.${NC}"
    echo -e "${YELLOW}Options:${NC}"
    echo "  1. Install fswatch: brew install fswatch"
    echo "  2. Use Python version: ./watch.py"
    echo "  3. Install watchdog for Python (recommended): pip3 install watchdog"
    exit 1
fi

echo -e "${GREEN}Watching ${CONFIG_DIR} for changes...${NC}"
echo -e "${YELLOW}Press Ctrl+C to stop${NC}"
echo ""

# Watch for file changes and reload sketchybar
fswatch -o "$CONFIG_DIR" | while read f; do
    echo -e "${GREEN}[$(date +'%H:%M:%S')] File changed, reloading sketchybar...${NC}"
    $RELOAD_CMD
done

