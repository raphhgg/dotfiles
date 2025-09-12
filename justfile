# Commands for dotfiles management with stow

# Install all dotfiles using stow
stow-all:
    stow alacritty git nvim omp ssh zsh

# Remove all dotfiles symlinks
unstow-all:
    stow -D alacritty git nvim omp ssh zsh