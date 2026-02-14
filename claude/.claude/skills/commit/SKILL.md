---
name: commit
description: Analyze changes and suggest well-formatted git commit(s)
argument-hint: [message]
disable-model-invocation: true
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git ls-files:*), Bash(git diff --name-only:*), Bash(git commit:*)
---

## Context
- Current git status: !`git status`
- Files changed: !`git diff --name-only HEAD`
- Files added: !`git ls-files --others --exclude-standard`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`

## Task
- Analyze all changes since last commit and suggest 1 or more appropriate commit messages following these guidelines.
- **DO NOT launch the 'git commit' command(s) directly**. You should first show to the user the different commits you want to create and prompt him to validate the proposed commit(s). Once he validated, you can use the 'git commit' command.

### Guidelines
1. **Files changed**: List all files that have been modified, added, or deleted
2. **Logical grouping**: Group changes by logical functionality or component
3. **Commit scope**: Prefix each commit with appropriate scope (e.g., [zsh], [nvim], [claude], [global], [monitoring], [torrents], etc)
4. **DO NOT include any co-authorship footer or attribution lines**
