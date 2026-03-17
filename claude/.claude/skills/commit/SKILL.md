---
name: commit
description: Analyze changes and suggest well-formatted git commit(s)
argument-hint: [message]
disable-model-invocation: true
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git ls-files:*), Bash(git diff --name-only:*), Bash(git commit:*), Bash(git push:*), Bash(rm:*), AskUserQuestion, question
---

## Context
- Current git status: !`git status`
- Files changed: !`git diff --name-only HEAD`
- Files added: !`git ls-files --others --exclude-standard`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5


## How to Ask User Question
The tool we'll call will depend of which application the user is using to run this skill:
- If using Claude Code, you **MUST** use the `AskUserQuestion` tool
- If using OpenCode, you **MUST** use the `question` tool


## Critical Safety Rules
- **DO NOT use `Bash(rm:*)` command(s) directly**. First, use the `AskUserQuestion` / `question` tool to validate with the user that the files you identified can indeed be deleted.
- **DO NOT launch the `Bash(git commit:*)` command(s) directly**. First, use the `AskUserQuestion` / `question` tool to validate 2 things:
  - Validate commits: after having presented the commit name and description to the user, ask them if these commits are good, if some commits needs to be ommitted or if some stuff are missing
  - Ask the user if I need to just commit or commit and push

## Task
- Analyze all changes since last commit and suggest 1 or more appropriate commit messages following the guidelines below.

### Guidelines
1. **Files changed**: List all files that have been modified, added, or deleted
2. Identify and remove dead or debug code.
2. **Logical grouping**: Group changes by logical functionality or component
3. **Commit scope**: Prefix each commit with appropriate scope (e.g., [zsh], [nvim], [claude], [global], [monitoring], [torrents], etc)
4. **DO NOT include any co-authorship footer or attribution lines**
