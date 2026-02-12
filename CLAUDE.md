# CLAUDE.md

## Repository Overview

Personal dotfiles repository managed with GNU Stow, supporting multi-host deployment (macOS, DS423Plus NAS, Ubuntu). See `justfile` for available targets and package lists.

## Stow Package Convention

Each package mirrors the home directory structure:
```
package-name/
├── .config/package-name/     # XDG config
├── .local/                   # Local files
└── .packagerc               # Root-level dotfiles
```

## Application Management

Brewfile is the source of truth for macOS applications. Use `just brew-install` to install all packages.

## Linear Issue Management

Default project: **"local machine"**. All Linear issues for this repository should use this project unless otherwise specified.
