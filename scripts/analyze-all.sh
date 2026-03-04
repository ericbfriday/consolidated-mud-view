#!/bin/bash
# analyze-all.sh - Scan all repos in ~/dev and gather metadata

set -e

DEV_DIR="$HOME/dev"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/../data"
REPOS=()

echo "=== Consolidated Mud View - Repository Analysis ==="
echo "Scanning: $DEV_DIR"
echo ""

# Find all git repos
for dir in "$DEV_DIR"/*/; do
    if [ -d "$dir/.git" ]; then
        name=$(basename "$dir")
        REPOS+=("$name")
    fi
done

echo "Found ${#REPOS[@]} repositories"
echo ""

# Create output file
OUTPUT_FILE="$OUTPUT_DIR/repos-$(date +%Y%m%d-%H%M%S).json"
mkdir -p "$OUTPUT_DIR"

# Generate JSON output
echo "[" > "$OUTPUT_FILE"
first=true

for repo in "${REPOS[@]}"; do
    cd "$DEV_DIR/$repo"
    
    # Gather metadata
    BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
    STATUS=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    LAST_COMMIT=$(git log -1 --format="%ci" 2>/dev/null || echo "unknown")
    REMOTE=$(git remote get-url origin 2>/dev/null || echo "none")
    LANGUAGE=$(git ls-files | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -1 | awk '{print $2}' || echo "unknown")
    
    if [ "$first" = true ]; then
        first=false
    else
        echo "," >> "$OUTPUT_FILE"
    fi
    
    cat >> "$OUTPUT_FILE" << EOF
  {
    "name": "$repo",
    "branch": "$BRANCH",
    "uncommitted_changes": $STATUS,
    "last_commit": "$LAST_COMMIT",
    "remote": "$REMOTE",
    "primary_extension": "$LANGUAGE"
  }
EOF
    
    echo "  - $repo ($BRANCH, $STATUS changes)"
done

echo "" >> "$OUTPUT_FILE"
echo "]" >> "$OUTPUT_FILE"

echo ""
echo "Analysis complete. Output saved to: $OUTPUT_FILE"
