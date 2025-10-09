# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow, containing configuration files for various development tools and applications.

## tmux Session Persistence Setup

To add session persistence to tmux (survive system restarts/updates):

### Option 1: TPM via Homebrew (Recommended)
```bash
# TPM is installed via Homebrew in nix-darwin config (darwin/applications/homebrew/cli.nix)
# After `just rebuild`, TPM will be available

# Add to your ~/.tmux.conf:
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# Plugin configuration
set -g @continuum-restore 'on'
set -g @continuum-save-interval '10'

# Initialize TPM (keep at bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'

# Reload tmux config and install plugins:
tmux source-file ~/.tmux.conf
# Press prefix + I (capital I) to install plugins
```

### Option 2: Manual Plugin Installation
```bash
# Clone repositories directly
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/resurrect
git clone https://github.com/tmux-plugins/tmux-continuum ~/.tmux/plugins/continuum

# Add to ~/.tmux.conf:
run-shell ~/.tmux/plugins/resurrect/resurrect.tmux
run-shell ~/.tmux/plugins/continuum/continuum.tmux
```

### Key Commands
- **Manual save**: `prefix + Ctrl-s`
- **Manual restore**: `prefix + Ctrl-r` (usually automatic)
- **Auto-saves**: Every 10 minutes (configurable)

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

## macOS Application Management

**IMPORTANT**: On macOS, applications must be installed through the separate `nix-darwin-config` repository BEFORE configuring them in this dotfiles repository.

### Installation Process

When you need to install a new application:

1. **Navigate to nix-darwin config**: `cd ~/nix-darwin-config`
2. **Add application to appropriate file**:
   - GUI apps: `darwin/applications/homebrew/gui.nix`
   - CLI tools: `darwin/applications/homebrew/cli.nix`
   - Fonts: `darwin/applications/homebrew/fonts.nix`
   - Mac App Store: `darwin/applications/mas.nix`
3. **Rebuild configuration**: `darwin-rebuild switch --flake .`
4. **Configure in dotfiles**: Only after installation, create configuration packages in this repository

### Example: Adding Karabiner-Elements

```nix
# In ~/nix-darwin-config/darwin/applications/homebrew/gui.nix
homebrew.casks = [
  # System Utilities
  "appcleaner"
  "karabiner-elements"  # <-- Add here
  "keka"
];
```

### Why This Architecture

- **Applications**: Managed by nix-darwin (declarative, version-controlled)
- **Configurations**: Managed by this dotfiles repo (Stow packages)
- **Brewfile**: Auto-generated from nix-darwin config for reference
- **Consistent**: Same setup process across different machines

## Linear Issue Management

**Default Project:** All Linear issues for this dotfiles repository should be created in the **"local machine"** project unless otherwise specified.

When creating issues related to this repository, always use the "local machine" project by default.

## Git Configuration

This repository uses a specific SSH key configuration:
- **Remote**: `github-personal:raaphhh/dotfiles.git`
- **SSH Host**: `github-personal` (configured in ~/.ssh/config)
- **SSH Key**: `~/.ssh/id_ed25519_personal`

When cloning or working with this repository, ensure you're using the `github-personal` SSH host alias, not the direct `github.com` URL.

### Commit Message Guidelines

**Prefix commits with scope** using the format `[scope] message`:

- Use the most relevant scope for the commit (e.g., package name, feature area, or topic)
- Common scopes: package names (`[zsh]`, `[nvim]`, `[ssh]`), feature areas (`[github]`, `[stow]`, `[docs]`), or `[global]` for repository-wide changes
- Keep scope names lowercase

**Examples:**
```bash
[zsh] Add alias for docker compose
[github] Fix workflow to use self-hosted runner
[global] Update repository structure
```
