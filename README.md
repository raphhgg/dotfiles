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
└── ...           # Other configurations
```

## Installation

```bash
# Clone the repository
git clone https://github.com/raaphhh/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install specific packages
stow zsh      # Creates ~/.zshrc
stow git      # Creates ~/.gitconfig
stow nvim     # Creates ~/.config/nvim/
# etc...

# Or install all at once using justfile
just stow-all
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