# Install-Skills

A meta-skill for GitHub Copilot CLI that helps you discover, browse, and install Agent Skills from GitHub repositories.

## Installation

Follow the official instructions on how to install skills:
https://docs.github.com/en/copilot/concepts/agents/about-agent-skills

## How It Works

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER PROMPT                             │
│  "Install all relevant skills for this repo"                    │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│                    INSTALL-SKILLS                               │
│  ┌────────────────────────────────────────────────────────┐     │
│  │ 1. Analyze repo to understand what skills are needed   │     │
│  │ 2. Search known skill repositories                     │     │
│  │ 3. Present matching skills to user                     │     │
│  │ 4. Run install script for selected skills              │     │
│  └────────────────────────────────────────────────────────┘     │
└─────────────────────┬───────────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────────┐
│                   SKILL SOURCES                                 │
│                                                                 │
│   ┌──────────────────┐  ┌──────────────────┐  ┌────────────┐   │
│   │ anthropics/skills│  │github/awesome-   │  │ Custom     │   │
│   │                  │  │copilot           │  │ Repos      │   │
│   └────────┬─────────┘  └────────┬─────────┘  └─────┬──────┘   │
│            └─────────────────────┼──────────────────┘          │
└──────────────────────────────────┼──────────────────────────────┘
                                   │
                                   ▼
┌─────────────────────────────────────────────────────────────────┐
│                    INSTALLED TO                                 │
│                                                                 │
│   .github/skills/<skill-name>/     (project - default)         │
│   ~/.copilot/skills/<skill-name>/  (personal - on request)     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Example Prompts

Once installed, try these prompts with GitHub Copilot CLI:

| Prompt | What It Does |
|--------|--------------|
| "Install all relevant skills for this repo" | Analyzes your project and installs matching skills |
| "What skills are available?" | Lists skills from known repositories |
| "Install the pdf skill" | Installs a specific skill by name |
| "Find skills for testing" | Searches for skills matching a keyword |
| "Install skills from anthropics/skills" | Browses and installs from a specific repo |

## Supported Skill Sources

- `anthropics/skills` - Official Anthropic skills collection
- `github/awesome-copilot` - Community-curated skills
- `microsoft/agent-skills` - skills for Microsoft AI SDKs and Azure services 
- Any GitHub repository with skills in `skills/`, `.github/skills/`, or `.claude/skills/`

## License

MIT
