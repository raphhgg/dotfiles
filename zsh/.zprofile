# Zsh Profile Configuration
# Environment setup for login shells

# Source helper functions first
source ~/.zsh/helpers.zsh

# Sets HOMEBREW_PREFIX, adds /opt/homebrew/bin to PATH, etc.
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set default editor
export EDITOR="nvim"

# Ensure ~/.local/bin is in PATH for all shells (not just login shells)
add_to_path "$HOME/.local/bin"

# Add OpenCode to PATH
add_to_path "$HOME/.opencode/bin"
