---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git ls-files:*), Bash(git diff --name-only:*), Bash(git commit:*)
argument-hint: [message]
description: Analyze changes and suggest well-formatted git commit(s)
---

## Context
- Current git status: !`git status`
- Files changed: !`git diff --name-only HEAD`
- Files added: !`git ls-files --others --exclude-standard`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`

## Task
- Analyze all changes since last commit and suggest 1 or more appropriate commit messages following conventional commits format.
- **DO NOT launch the 'git commit' command(s), you should show to the user the different commits you want to create and prompt him to validate the proposed commit(s)** 

## Analysis
1. **Files changed**: List all files that have been modified, added, or deleted
2. **Logical grouping**: Group changes by logical functionality or component
3. **Commit scope**: Prefix each commit with appropriate scope (e.g., [zsh], [nvim], [claude], [global])

## Suggested Commits
Based on the analysis, I will propose one or more commit messages that:
- Follow conventional commit format (type: description)
- Include appropriate scope prefixes
- Group related changes logically
- Focus on the changes made rather than generation markers

## Commit Message Guidelines
- Use scope prefixes: [zsh], [nvim], [claude], [global], [aerospace], [sketchybar], etc.
- Use conventional commit types: feat, fix, docs, style, refactor, test, chore
- Keep messages concise but descriptive
- Focus on what changed, not how it was generated
- **DO NOT include any co-authorship footer or attribution lines**
