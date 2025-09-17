# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow, containing configuration files for various development tools and applications.

## Common Commands

### Stow Management
```bash
# Install all dotfile packages
just stow-all

# Install specific package
stow <package-name>  # e.g., stow zsh, stow ghostty

# Remove all symlinks
just unstow-all

# Remove specific package symlinks
stow -D <package-name>

# Check what would be stowed (dry run)
stow --verbose --no-folding --simulate *
```

### Homebrew Management
```bash
# Install all packages from Brewfile
just brew-install

# Update Brewfile with currently installed packages (use carefully)
just brew-dump

# Check which packages would be installed/uninstalled
just brew-check

# Remove packages not in Brewfile
just brew-cleanup
```

## Architecture

### Stow Package Structure
Each application/tool has its own directory that mirrors the home directory structure:
```
package-name/
├── .config/package-name/     # For XDG config
├── .local/                   # For local files
└── .packagerc               # For root-level dotfiles
```

### Zsh Configuration (Modular)
The zsh configuration is split into focused modules:
- `aliases.zsh` - Command aliases
- `completion.zsh` - Tab completion setup
- `helpers.zsh` - Utility functions for configuration
- `history.zsh` - History configuration

Key helper functions in `helpers.zsh`:
- `has_command()` - Check if command exists
- `init_tool()` - Initialize tools conditionally
- `safe_source()` - Source files safely
- `add_to_path()` - Add directories to PATH

### Package Management
- **Stow packages**: alacritty, git, nvim, omp, ssh, zsh, ghostty
- **Brewfile**: Contains curated applications, development tools, fonts, and Mac App Store apps
- Configuration changes are immediately reflected via symlinks

## Troubleshooting

### Stow Conflicts
When stow reports conflicts with existing files:
1. Back up existing file: `mv ~/.file ~/.file.backup`
2. Run stow command again
3. Check for `.DS_Store` files which can cause conflicts on macOS

### Missing Dependencies
- Ensure GNU Stow is installed: `brew install stow`
- For Homebrew packages: `just brew-install`
- Check symlink creation: `ls -la ~ | grep "->"`

## Commit Message Guidelines

**Important**: This repository does NOT use Claude Code's default commit message format. When making commits:

- **DO NOT** include "🤖 Generated with [Claude Code](https://claude.ai/code)" lines
- **DO NOT** include "Co-Authored-By: Claude <noreply@anthropic.com>" lines
- **DO NOT** add any Claude attribution or generation markers

Use clean, standard commit messages that focus on the changes made. The commit history has been cleaned to remove previous Claude attribution lines and should remain that way.

## Git Configuration

This repository uses a specific SSH key configuration:
- **Remote**: `github-personal:raaphhh/dotfiles.git`  
- **SSH Host**: `github-personal` (configured in ~/.ssh/config)
- **SSH Key**: `~/.ssh/id_ed25519_personal`

When cloning or working with this repository, ensure you're using the `github-personal` SSH host alias, not the direct `github.com` URL.