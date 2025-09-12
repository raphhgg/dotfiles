# Dotfiles with GNU Stow

This repository contains my personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

**Note**: This repository was extracted from my nix-darwin configuration to be standalone and reusable across different systems.

## Prerequisites

**Option A - Using Nix (recommended for macOS with nix-darwin)**:
Stow is already included in your nix-darwin packages, no additional installation needed.

**Option B - Traditional package managers**:
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
├── alacritty/    # Alacritty terminal
│   └── .config/alacritty/alacritty.toml
├── nvim/         # Neovim with LazyVim
│   └── .config/nvim/
├── ssh/          # SSH configuration
│   └── .ssh/config
└── omp/          # Oh My Posh prompt
    └── .config/omp/config.toml
```

## Integration with nix-darwin

If you're using this with nix-darwin, you have two options:

### Option 1: Manual Management (Recommended)
```bash
# Clone to your preferred location
git clone <repo> ~/dotfiles
cd ~/dotfiles

# Install packages you need
stow zsh git alacritty nvim ssh omp
```

### Option 2: Automated via nix-darwin (Advanced)
Add to your nix-darwin configuration:

```nix
# In your darwin configuration
system.activationScripts.dotfiles.text = ''
  echo "Setting up dotfiles..."
  cd ${config.users.users.raphaelgrau.home}/dotfiles
  ${pkgs.stow}/bin/stow zsh git alacritty nvim ssh omp
'';
```

## Installation

### Initial Setup
```bash
# Clone to your preferred location  
git clone <repo> ~/dotfiles
cd ~/dotfiles

# Run the install script (if available)
./install.sh
```

The install script will:
1. Backup existing configs to `~/.config-backup/`
2. Create symlinks using stow
3. Show next steps

### Manual Installation
```bash
cd ~/dotfiles

# Install specific packages
stow zsh      # Creates ~/.zshrc
stow git      # Creates ~/.gitconfig
stow nvim     # Creates ~/.config/nvim/
# etc...

# Or install all at once
stow */
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
nvim ~/dotfiles/zsh/.zshrc
```

### Removing packages
```bash
# Remove symlinks
stow -D zsh

# Remove package directory
rm -rf zsh/
```

## Platform Compatibility

These dotfiles are designed to work across:
- **macOS** (with Homebrew)
- **Arch Linux** (with pacman)
- **Other Unix systems**

### Required tools:

**With nix-darwin** (install via packages.nix):
```nix
environment.systemPackages = with pkgs; [
  zsh-autosuggestions
  zsh-syntax-highlighting  
  oh-my-posh
  fzf
  zoxide
  fastfetch
  # Applications
  alacritty
  neovim
];
```

**Traditional package managers**:
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`  
- `oh-my-posh`
- `fzf`
- `zoxide`
- `fastfetch`

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

## Notes

- **LazyVim**: Neovim config uses LazyVim - plugins install automatically on first run
- **SSH keys**: Only config is managed, not private keys (never commit private keys!)
- **Cross-platform**: Configs detect available tools and adapt accordingly