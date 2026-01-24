#!/bin/bash
# list-skills.sh - List available skills from a GitHub repository
#
# Usage: ./list-skills.sh [source-repo]
#
# Examples:
#   ./list-skills.sh
#   ./list-skills.sh anthropics/skills
#   ./list-skills.sh github/awesome-copilot
#
# If https://skills.sh/ CLI (add-skill) is installed, it will be used instead
# for better cross-agent compatibility and auto-detection features.

set -e

SOURCE_REPO="${1:-anthropics/skills}"

# Check if skills.sh CLI (add-skill) is available
check_skills_sh_cli() {
    command -v npx >/dev/null 2>&1 && npx add-skill --version >/dev/null 2>&1
}

# Use skills.sh CLI if available
use_skills_sh_cli() {
    local repo="$1"
    
    echo "Using skills.sh CLI (add-skill) to list skills..."
    echo ""
    
    # Execute the skills.sh CLI with --list flag
    npx add-skill "$repo" --list
}

# Try to use skills.sh CLI if available
if check_skills_sh_cli; then
    use_skills_sh_cli "$SOURCE_REPO"
    exit 0
fi

# Fall back to manual listing if skills.sh CLI is not available
echo "Note: skills.sh CLI not found, using manual listing."
echo "Install skills.sh CLI for better cross-agent compatibility: npx add-skill --help"
echo ""

# Paths to check for skills (in order of priority)
SKILLS_PATHS=("skills" ".github/skills" ".claude/skills")

FOUND=false

for SKILLS_PATH in "${SKILLS_PATHS[@]}"; do
    # Try to get skills listing via GitHub API
    RESPONSE=$(curl -s "https://api.github.com/repos/$SOURCE_REPO/contents/$SKILLS_PATH" 2>/dev/null)

    if echo "$RESPONSE" | grep -q '"type": "dir"'; then
        echo "Available skills from $SOURCE_REPO ($SKILLS_PATH):"
        echo ""
        # Parse and display skill names
        echo "$RESPONSE" | grep '"name":' | sed 's/.*"name": "\([^"]*\)".*/  - \1/'
        FOUND=true
        break
    fi
done

if [ "$FOUND" = false ]; then
    echo "Error: Could not fetch skills from $SOURCE_REPO"
    echo "Checked paths: ${SKILLS_PATHS[*]}"
    echo "Make sure the repository exists and has a skills directory"
    exit 1
fi

echo ""
echo "To install a skill, run:"
echo "  ./install-skill.sh <skill-name> $SOURCE_REPO"
