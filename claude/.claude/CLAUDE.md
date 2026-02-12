# Global Claude Code Instructions

## Identity & Accounts
- GitHub username: raaphhh
- SSH host alias: github-personal (key: ~/.ssh/id_ed25519_personal)

## NEVER EVER DO
- NEVER publish passwords, API keys, tokens, or secrets to git/npm/docker
- NEVER commit .env or .secrets files — always verify .gitignore first
- NEVER output, display, or echo secrets from env vars, config files, or secret stores
- NEVER hardcode credentials — always reference from secure storage
- NEVER include sensitive data in commit messages, PR descriptions, or issue bodies
- Before ANY commit: verify no secrets are staged

## Defense in Depth
| Layer | What             | How                              |
|------:|------------------|----------------------------------|
|     1 | Behavioral rules | This CLAUDE.md — "NEVER" rules   |
|     2 | Access control   | settings.json deny list          |
|     3 | Git safety       | .gitignore patterns              |

## Configuration Sync
This file is managed via GNU Stow from the dotfiles repository:
`stow -t ~ claude` → symlinks ~/.claude

## General Preferences
- Be concise and direct in responses
- Minimize unnecessary preamble and postamble
- Focus on the specific task at hand
- Use TodoWrite tool for multi-step tasks to track progress
