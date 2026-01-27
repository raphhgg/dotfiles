---
allowed-tools: Bash(stow:*)
argument-hint: [package-name]
description: Stow packages with correct target to home directory
---

## Task
Execute stow with correct target to home directory (`~`)

## Execution
This command will execute `stow -t ~` with the specified package names to ensure stow targets the home directory correctly.

## Usage
```
/stow <package-name>
```

Example:
```
/stow claude
/stow zsh
/stow nvim
```
