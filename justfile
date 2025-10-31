# Commands for dotfiles management with stow

# Install all dotfiles using stow
stow-all:
    stow aerospace alacritty git nvim omp ssh zsh ghostty claude

# Remove all dotfiles symlinks
unstow-all:
    stow -D aerospace git nvim omp ssh zsh ghostty claude

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
