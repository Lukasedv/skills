#!/bin/bash
# list-skills.sh - List available skills from a GitHub repository
#
# Usage: ./list-skills.sh [source-repo]
#
# Examples:
#   ./list-skills.sh
#   ./list-skills.sh anthropics/skills
#   ./list-skills.sh github/awesome-copilot

set -e

SOURCE_REPO="${1:-anthropics/skills}"

echo "Available skills from $SOURCE_REPO:"
echo ""

# Try different possible skill locations
SKILLS_PATHS=("skills" ".github/skills" ".claude/skills")
FOUND=0

for SKILLS_PATH in "${SKILLS_PATHS[@]}"; do
    # Try to get skills listing via GitHub API
    RESPONSE=$(curl -s "https://api.github.com/repos/$SOURCE_REPO/contents/$SKILLS_PATH" 2>/dev/null)
    
    if echo "$RESPONSE" | grep -q '"type": "dir"'; then
        # Parse and display skill names
        echo "$RESPONSE" | grep '"name":' | sed 's/.*"name": "\([^"]*\)".*/  - \1/'
        FOUND=1
        break
    fi
done

if [ $FOUND -eq 0 ]; then
    echo "Error: Could not fetch skills from $SOURCE_REPO"
    echo "Make sure the repository exists and has skills in one of these directories:"
    echo "  - skills/"
    echo "  - .github/skills/"
    echo "  - .claude/skills/"
    exit 1
fi

echo ""
echo "To install a skill, run:"
echo "  ./install-skill.sh <skill-name> $SOURCE_REPO"
