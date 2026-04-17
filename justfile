# Commands for dotfiles management with stow

# Install dotfiles for macOS
stow-macos:
    stow -t ~ aerospace alacritty borders btop karabiner git nvim omp opencode ssh tmux zed zsh ghostty claude codex
    DOTFILES_DIR=$PWD bash ./scripts/install-codex-config.sh macos

# Install dotfiles for ds423plus NAS server
stow-ds423plus:
    stow -t ~ tmux omp claude git nvim zsh btop opencode

# Install dotfiles for ubuntu server
stow-ubuntu:
    stow -t ~ tmux omp claude git nvim zsh ssh btop opencode codex
    DOTFILES_DIR=$PWD bash ./scripts/install-codex-config.sh debian

# Remove all dotfiles symlinks
unstow-all:
    stow -t ~ -D aerospace alacritty borders btop karabiner git nvim omp opencode ssh tmux zed zsh ghostty claude codex

# Sync dotfiles from remote
sync:
    ./scripts/sync.sh

# Sync Codex shared repos used across machines
sync-codex:
    ./scripts/sync-codex.sh

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

# Bootstrap a fresh macOS machine from this repo
bootstrap-macos:
    ./bootstrap-macos.sh
