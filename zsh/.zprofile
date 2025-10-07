
# Zsh Profile Configuration
# Environment setup for login shells

# Add pipx-installed Python tools to PATH
export PATH="$PATH:/Users/raphaelgrau/.local/bin"

# Claude Code
export PATH="$HOME/.local/bin:$PATH"

# Initialize Homebrew environment variables and PATH
# Sets HOMEBREW_PREFIX, adds /opt/homebrew/bin to PATH, etc.
eval "$(/opt/homebrew/bin/brew shellenv)"
