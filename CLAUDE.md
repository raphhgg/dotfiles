# CLAUDE.md

## Repository Overview

Personal dotfiles repository managed with GNU Stow, supporting multi-host deployment (macOS, DS423Plus NAS, Ubuntu). See `justfile` for available targets and package lists.

## Stow Package Convention

Each package mirrors the home directory structure:
```
package-name/
├── .config/package-name/     # XDG config
├── .local/                   # Local files
└── .packagerc                # Root-level dotfiles
```

### Stow Commands

After adding/removing/renaming  files, make sure you always launch the stow command so that new files are symlinked.

>  stow -t ~ -R -v <name_of_the_service>


## Application Management

Brewfile is the source of truth for macOS applications. Use `just brew-install` to install all packages.

## Linear Issue Management

Default project: **"local machine"**. All Linear issues for this repository should use this project unless otherwise specified.
