# Commands for dotfiles management with stow

# Install dotfiles for macOS
stow-macos:
    stow -t ~ aerospace alacritty git nvim omp ssh zsh ghostty claude borders karabiner sketchybar

# Install dotfiles for ds423plus NAS server
stow-ds423plus:
    stow -t ~ tmux omp claude git nvim zsh btop opencode

# Install dotfiles for ubuntu server
stow-ubuntu:
    stow -t ~ tmux omp claude git nvim zsh ssh btop opencode

# Remove all dotfiles symlinks
unstow-all:
    stow -t ~ -D aerospace git nvim omp ssh zsh ghostty claude borders karabiner sketchybar

# Sync dotfiles from remote
sync:
    ./scripts/sync.sh

# Brewfile management commands

# Install all packages from Brewfile
brew-install:
    brew bundle install

# Update Brewfile with currently installed packages
brew-dump:
    brew bundle dump --describe --force

# Check which packages would be installed/uninstalled
brew-check:
    brew bundle check || brew bundle --verbose

# Clean up packages not in Brewfile
brew-cleanup:
    brew bundle cleanup
