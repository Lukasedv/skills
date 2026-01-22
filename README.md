# Install-Skills

A meta-skill for GitHub Copilot CLI that helps you discover, browse, and install Agent Skills from GitHub repositories.

## Quick Install

Run this command to install the skill to your personal GitHub Copilot profile:

```bash
git clone --depth 1 https://github.com/Lukasedv/skills.git /tmp/skills && mkdir -p ~/.copilot/skills && cp -r /tmp/skills/install-skills ~/.copilot/skills/ && rm -rf /tmp/skills && echo "✓ install-skills installed to ~/.copilot/skills/"
```

## What It Does

Once installed, you can ask GitHub Copilot CLI to:

- **"Install a skill"** - Install skills from any GitHub repository
- **"What skills are available?"** - Browse skills from known repositories
- **"Find skills for X"** - Search for skills matching your needs

Supports installing from:
- `anthropics/skills`
- `github/awesome-copilot`
- Any custom GitHub repository with skills

## Manual Installation

If you prefer to install manually:

```bash
git clone https://github.com/Lukasedv/skills.git
cp -r skills/install-skills ~/.copilot/skills/
```

## License

MIT
