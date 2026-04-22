# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/), shared across my Mac and one Debian VM.

This repo is the public version of the base setup I actually use across my machines.

The AI and agent-tooling layer lives separately in `$HOME/dotfiles-ai`, so this repo stays focused on the shell, editor, terminal, SSH, and macOS setup.

## Public vs Local

This repo keeps a deliberate split between:

- tracked base configs that show the shape of my setup
- local-only machine overlays that contain real host inventories, private endpoints, and host-specific state

Examples of that split:

- tracked: `ssh/.ssh/config`
- local-only: `~/.ssh/config.local`
- tracked: editor and terminal defaults
- local-only: machine-specific overrides and secrets

## Prerequisites

- **macOS**: `brew install stow`
- **Debian**: `sudo apt install stow`

### Package Convention

Each package mirrors the home directory structure:
```
package-name/
├── .config/package-name/     # XDG config
└── .local/                   # Local files
```

## Current Host Layout

The current setup is simple:

```bash
# macOS
just stow-macos
# → aerospace btop karabiner git nvim omp ssh tmux zed zsh ghostty

# Debian VM
just stow-debian
# → btop git nvim omp ssh tmux zsh
```

Additional packages can be stowed manually as needed:
```bash
stow -t ~ macos
```

## Installation

```bash
# Clone the repository
git clone https://github.com/raphhgg/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"

# Install packages for your host
just stow-macos        # macOS
just stow-debian       # Debian VM

# Install Homebrew packages (macOS only)
just brew-install

```

## Public Repo Notes

- Real host inventories and internal SSH targets live in `~/.ssh/config.local`, not in the tracked SSH config.
- AI-specific Claude, Codex, and OpenCode configs live in the separate `dotfiles-ai` repo.
- You should expect to adapt usernames, host aliases, and machine-local overrides if you borrow these configs.

## Fresh Mac Setup

If you are bootstrapping a new Mac, do not run the steps by hand one by one unless you need to debug something. Use the bootstrap script:

```bash
git clone https://github.com/raphhgg/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"
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
nvim "$HOME/dotfiles/zsh/.zshrc"
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
git clone https://github.com/raphhgg/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"

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
