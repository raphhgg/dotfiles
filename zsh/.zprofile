
# Zsh Profile Configuration
# Environment setup for login shells

# Sets HOMEBREW_PREFIX, adds /opt/homebrew/bin to PATH, etc.
if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Claude Code
export PATH="$HOME/.local/bin:$PATH"

# Add pipx-installed Python tools to PATH
export PATH="$PATH:/Users/raphaelgrau/.local/bin"
