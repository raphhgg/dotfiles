# Commands for dotfiles management with stow

# Install all dotfiles using stow
stow-all:
    stow alacritty git nvim omp ssh zsh ghostty tmux

# Remove all dotfiles symlinks
unstow-all:
    stow -D alacritty git nvim omp ssh zsh ghostty tmux

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