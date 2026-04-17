# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/), supporting multi-host deployment across macOS, Synology NAS, and Ubuntu.

## Prerequisites

- **macOS**: `brew install stow`
- **Arch Linux**: `sudo pacman -S stow`
- **Ubuntu/Debian**: `sudo apt install stow`
- **Other**: Check your package manager

### Package Convention

Each package mirrors the home directory structure:
```
package-name/
├── .config/package-name/     # XDG config
└── .local/                   # Local files
```

## Multi-Host Deployment

Different hosts use different subsets of packages:

```bash
# macOS
just stow-macos
# → aerospace alacritty borders btop karabiner git nvim omp opencode ssh tmux zed zsh ghostty claude codex

# DS423Plus NAS
just stow-ds423plus
# → btop claude git nvim omp opencode ssh tmux zsh

# Ubuntu server
just stow-ubuntu
# → btop claude git nvim omp opencode ssh tmux zsh
```

Additional packages can be stowed manually as needed:
```bash
stow -t ~ macos
```

## Installation

```bash
# Clone the repository
git clone https://github.com/raaphhh/dotfiles.git ~/github/dotfiles
cd ~/github/dotfiles

# Install packages for your host
just stow-macos        # macOS
just stow-ds423plus    # NAS
just stow-ubuntu       # Ubuntu

# Install Homebrew packages (macOS only)
just brew-install

```

## Fresh Mac Setup

If you are bootstrapping a new Mac, do not run the steps by hand one by one unless you need to debug something. Use the bootstrap script:

```bash
git clone https://github.com/raaphhh/dotfiles.git ~/github/dotfiles
cd ~/github/dotfiles
./bootstrap-macos.sh
```

This will:

- install Xcode Command Line Tools if needed
- install Homebrew if needed
- install packages from the `Brewfile`
- stow the macOS dotfiles set
- apply macOS preferences with safer defaults

Manual restore items that still matter are listed in [macos/MIGRATION_CHECKLIST.md](./macos/MIGRATION_CHECKLIST.md).

## Management

### Adding new dotfiles
```bash
# Create package directory
mkdir btop

# Add your config (maintaining home directory structure)
mkdir -p btop/.config/btop
cp ~/.config/btop/btop.conf btop/.config/btop/

# Install the package
stow btop
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

### Syncing across machines
```bash
./scripts/sync.sh
```

For Codex and the shared harness, one repo is not enough. Your remote machine needs both `dotfiles` and `agent-standards` current before you start work:

```bash
just sync-codex
```

That command:

- updates `~/dotfiles`
- updates `~/agent-standards`
- stops if either repo has uncommitted changes
- stops if the remote machine has local commits you have not pushed yet

Recommended workflow:

1. Make changes locally in `dotfiles` or `agent-standards`.
2. Commit and push them.
3. On the remote machine, run `just sync-codex` before starting Codex.

Do not rely on syncing `~/.codex` wholesale. Keep auth, logs, sessions, and other machine-local state local.

## Brewfile Management

The `Brewfile` is the source of truth for macOS applications, development tools, fonts, and Mac App Store apps.

### Installing packages
```bash
# Install all packages from Brewfile
just brew-install

# Or manually
brew bundle install
```

### Updating Brewfile
```bash
# Update Brewfile with current packages (careful — this includes everything!)
just brew-dump

# Check what would be installed/removed
just brew-check

# Remove packages not in Brewfile
just brew-cleanup
```

### New Mac Setup
```bash
git clone https://github.com/raaphhh/dotfiles.git ~/github/dotfiles
cd ~/github/dotfiles

# Bootstrap the machine
./bootstrap-macos.sh
```

## Troubleshooting

### Stow conflicts
If stow complains about existing files:
```bash
# Back up existing file and retry
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

Check for `.DS_Store` files which can cause stow conflicts on macOS — delete them before stowing.

### Missing symlinks
Check if stow created the links:
```bash
ls -la ~ | grep "\->"
ls -la ~/.config/ | grep "\->"
```

### Missing dependencies
```bash
# Ensure GNU Stow is installed
brew install stow

# Install Homebrew packages
just brew-install
```

### Checking what's stowed
```bash
stow --verbose --no-folding --simulate *
```
