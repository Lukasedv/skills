---
name: install-skills
description: 'Automatically install and manage Agent Skills from GitHub repositories. Use when asked to "install a skill", "add a skill", "find skills", "browse skills", "get skills from GitHub", or when the user needs a specific capability that might exist as a community skill. Supports anthropics/skills, github/awesome-copilot, and custom GitHub repositories.'
---

# Install Skills

A meta-skill for discovering, browsing, and installing Agent Skills from online repositories. This skill helps you find and install community-created skills to enhance your capabilities.

## When to Use This Skill

- User asks to "install a skill", "add a skill", or "get a skill"
- User mentions needing capabilities that might exist as community skills
- User wants to browse available skills from known repositories
- User wants to install a skill from a specific GitHub repository
- User asks "what skills are available?"

## Supported Skill Sources

### Primary Repositories

| Repository | Description |
|------------|-------------|
| `anthropics/skills` | Official Anthropic skills collection |
| `github/awesome-copilot` | GitHub's community-curated skills in `skills/` directory |

### Custom Repositories

Any GitHub repository with skills in one of these structures:
- `skills/<skill-name>/SKILL.md`
- `.github/skills/<skill-name>/SKILL.md`
- `.claude/skills/<skill-name>/SKILL.md`

## Installation Locations

Skills can be installed to:

| Location | Scope | Path |
|----------|-------|------|
| Personal | All projects | `~/.copilot/skills/<skill-name>/` |
| Project | Current repo only | `.github/skills/<skill-name>/` |

**Default**: Personal skills (`~/.copilot/skills/`)

## Workflow: Browse Available Skills

### Step 1: List Skills from Known Repositories

Use the GitHub MCP Server to fetch repository contents:

```
# For anthropics/skills
Use get_file_contents for owner: "anthropics", repo: "skills", path: "skills"

# For github/awesome-copilot  
Use get_file_contents for owner: "github", repo: "awesome-copilot", path: "skills"
```

### Step 2: Display Skills to User

Present skills in a table format:

| Skill Name | Repository | Description |
|------------|------------|-------------|
| skill-name | source/repo | Brief description from SKILL.md |

### Step 3: Get Skill Details

Fetch and display the SKILL.md content for any skill the user is interested in.

## Workflow: Install a Skill

### Step 1: Identify the Skill Source

Parse the user's request to determine:
- Skill name
- Source repository (default to searching known repos)
- Installation scope (personal or project)

### Step 2: Fetch Skill Contents

Use GitHub MCP Server to get all files in the skill directory:

```
get_file_contents for the skill directory to list all files
Then fetch each file's content
```

### Step 3: Create Local Directory

```bash
# For personal installation
mkdir -p ~/.copilot/skills/<skill-name>

# For project installation  
mkdir -p .github/skills/<skill-name>
```

### Step 4: Write Skill Files

Copy all files from the remote skill to the local directory:
- SKILL.md (required)
- scripts/ (if present)
- references/ (if present)
- assets/ (if present)
- templates/ (if present)
- Any other files

### Step 5: Confirm Installation

Report to the user:
- Skill name installed
- Installation location
- Brief description of what the skill does
- Any prerequisites or dependencies noted in the skill

## Workflow: Search for Skills

When the user describes a capability they need:

1. Search known repositories for skills with matching keywords
2. Read SKILL.md descriptions to find relevant matches
3. Present options to the user
4. Install the selected skill

## Workflow: Install from Custom Repository

When given a GitHub URL or owner/repo reference:

1. Parse the repository reference
2. Check for skills in standard locations:
   - `skills/`
   - `.github/skills/`
   - `.claude/skills/`
3. List available skills
4. Install selected skill(s)

## Example Commands

| User Says | Action |
|-----------|--------|
| "Install the webapp-testing skill" | Search repos, install matching skill |
| "What skills are available?" | List all skills from known repos |
| "Install pdf skill from anthropics/skills" | Install specific skill from specific repo |
| "I need help with image manipulation" | Search for relevant skills, suggest matches |
| "Add the github-issues skill to this project" | Install to .github/skills/ |
| "Install all skills from anthropics/skills" | Batch install all available skills |

## Installation Script

For batch operations or scripted installations, use:

```bash
#!/bin/bash
# install-skill.sh - Helper script for skill installation

SKILL_NAME="$1"
SOURCE_REPO="${2:-anthropics/skills}"
INSTALL_PATH="${3:-$HOME/.copilot/skills}"

# Create destination
mkdir -p "$INSTALL_PATH/$SKILL_NAME"

# Clone sparse checkout of just the skill
git clone --depth 1 --filter=blob:none --sparse \
  "https://github.com/$SOURCE_REPO.git" /tmp/skill-install
cd /tmp/skill-install
git sparse-checkout set "skills/$SKILL_NAME"

# Copy to destination
cp -r "skills/$SKILL_NAME"/* "$INSTALL_PATH/$SKILL_NAME/"

# Cleanup
rm -rf /tmp/skill-install

echo "Installed $SKILL_NAME to $INSTALL_PATH/$SKILL_NAME"
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Skill not found | Check spelling, try searching with keywords |
| Permission denied | Ensure write access to installation path |
| Skill conflicts | Check for existing skill with same name |
| Missing dependencies | Read skill's prerequisites section |

## Post-Installation

After installing a skill:
1. The skill is immediately available for use
2. Copilot will automatically load it when relevant based on the description
3. No restart required

## Uninstalling Skills

To remove an installed skill:

```bash
# Personal skill
rm -rf ~/.copilot/skills/<skill-name>

# Project skill
rm -rf .github/skills/<skill-name>
```
