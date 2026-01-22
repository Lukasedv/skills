# Skills

A collection of Agent Skills for GitHub Copilot CLI.

## Available Skills

| Skill | Description |
|-------|-------------|
| [install-skills](./install-skills/) | Automatically install and manage Agent Skills from GitHub repositories. Use when asked to "install a skill", "add a skill", "find skills", "browse skills", or when the user needs a specific capability that might exist as a community skill. Supports anthropics/skills, github/awesome-copilot, and custom GitHub repositories. |

## Installation

To install a skill from this repository:

```bash
# Using the install script
./install-skills/scripts/install-skill.sh <skill-name> Lukasedv/skills

# Or manually copy to your skills directory
cp -r <skill-name> ~/.copilot/skills/
```

## License

MIT
