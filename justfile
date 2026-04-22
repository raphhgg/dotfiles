# Commands for dotfiles management with stow

# Install dotfiles for macOS
stow-macos:
    stow -t ~ aerospace btop karabiner git nvim omp ssh tmux zed zsh ghostty

# Install dotfiles for the Debian VM
stow-debian:
    stow -t ~ tmux omp git nvim zsh ssh btop

# Remove all dotfiles symlinks
unstow-all:
    stow -t ~ -D aerospace alacritty borders btop karabiner git nvim omp ssh tmux zed zsh ghostty

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

# Bootstrap a fresh macOS machine from this repo
bootstrap-macos:
    ./bootstrap-macos.sh
