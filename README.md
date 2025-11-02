# Dotfiles with GNU Stow

This repository contains my personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites
- **macOS**: `brew install stow`
- **Arch Linux**: `sudo pacman -S stow`
- **Ubuntu/Debian**: `sudo apt install stow`
- **Other**: Check your package manager

## Structure

```
dotfiles/
├── zsh/          # Zsh configuration
│   └── .zshrc
├── git/          # Git configuration
│   ├── .gitconfig
│   └── .gitignore_global
├── nvim/         # Neovim configuration
│   └── .config/nvim/
├── claude/       # Claude Code configuration
│   ├── .claude/
│   └── .mcp.json.example
└── ...           # Other configurations
```

## Installation

```bash
# Clone the repository
git clone https://github.com/raaphhh/dotfiles.git ~/github/dotfiles
cd ~/github/dotfiles

# Install specific packages
stow zsh      # Creates ~/.zshrc
stow git      # Creates ~/.gitconfig
stow nvim     # Creates ~/.config/nvim/
# etc...

# Or install all at once using justfile
just stow-all

# Install Homebrew packages (optional)
just brew-install
```

## Management

### Adding new dotfiles
```bash
# Create package directory
mkdir tmux

# Add your config (maintaining home directory structure)
mkdir -p tmux/.config/tmux
cp ~/.config/tmux/tmux.conf tmux/.config/tmux/

# Install the package
stow tmux
```

### Updating configs
Since stow creates symlinks, just edit files normally:
```bash
# Edit the file directly
nvim ~/.zshrc

# Or edit in the repo
nvim ~/github/dotfiles/zsh/.zshrc
```

### Removing packages
```bash
# Remove symlinks
stow -D zsh

# Remove package directory
rm -rf zsh/
```

## Brewfile Management

This repository includes a curated `Brewfile` containing essential applications for macOS setup.

### Installing packages
```bash
# Install all packages from Brewfile
just brew-install

# Or manually
brew bundle install
```

### Updating Brewfile
```bash
# Update Brewfile with current packages (careful - this includes everything!)
just brew-dump

# Check what would be installed/removed
just brew-check

# Remove packages not in Brewfile
just brew-cleanup
```

### New Mac Setup
```bash
# Complete setup on a new Mac
git clone https://github.com/raaphhh/dotfiles.git ~/github/dotfiles
cd ~/github/dotfiles

# Install dotfiles
just stow-all

# Install applications
just brew-install
```

## Troubleshooting

### Stow conflicts
If stow complains about existing files:
```bash
# Manual backup and retry
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

### Missing symlinks
Check if stow created the links:
```bash
ls -la ~ | grep "\->"
ls -la ~/.config/ | grep "\->"
```

### Checking what's stowed
```bash
# See what packages are stowed
stow --verbose --no-folding --simulate *
```

## Claude Code Setup

This repository includes **user-level** Claude Code configuration for sharing settings across machines.

### Structure
```
claude/
└── .claude/                          # User-level config (~/.claude/)
    ├── settings.json                 # Global settings for all projects
    ├── plugins/
    │   └── config.json               # MCP plugin config
    └── .gitignore                    # Ignores credentials & session data
```

### Initial Setup

```bash
# Install Claude configuration
stow claude

# Edit settings.json directly for machine-specific values if needed
nvim ~/.claude/settings.json
```

### What Gets Version Controlled

**User-level (this repo):**
- `~/.claude/settings.json` - Global permissions, hooks, environment variables
- `~/.claude/plugins/config.json` - MCP plugin configuration

**NOT version controlled (managed by Claude):**
- `~/.claude/.credentials.json` - OAuth tokens (auto-managed)
- `~/.claude.json` - Main config file (contains project state and tokens)
- Session data (history, todos, cache, shell-snapshots, etc.)

**Project-level (each project's repo):**
- `.claude/settings.json` - Project-specific settings (checked into that project)
- `.claude/settings.local.json` - Personal overrides (gitignored in that project)
- `.mcp.json` - Project MCP servers (checked into that project)

### MCP Server Configuration

MCP servers are managed via the `claude mcp` CLI, not configuration files in dotfiles.

**Add user-level MCP server (available in all projects):**
```bash
# Linear integration
claude mcp add linear-server --scope user --transport sse https://mcp.linear.app/sse

# GitHub integration
claude mcp add github-server --scope user npx -y @modelcontextprotocol/server-github
```

OAuth credentials are automatically managed by Claude in `~/.claude/.credentials.json`.

**Add project-level MCP server (specific to one project):**
```bash
cd /your/project
claude mcp add project-server --scope project /path/to/server
# Creates .mcp.json in the project (commit this to project's git)
```

### Machine-Specific Settings

For machine-specific paths or values, edit `~/.claude/settings.json` directly:
```json
{
  "env": {
    "DOCKER_APPDATA_PATH": "/your/machine/specific/path",
    "MEDIAS_PATH": "/your/media/path"
  }
}
```

### Adding to New Machine

```bash
cd ~/dotfiles
stow claude

# Add MCP servers (they're per-machine, not in dotfiles)
claude mcp add linear-server --scope user --transport sse https://mcp.linear.app/sse

# Customize settings.json for this machine if needed
nvim ~/.claude/settings.json
```
