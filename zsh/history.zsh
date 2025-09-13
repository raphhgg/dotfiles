# History Configuration
# Settings for zsh command history management

# History file location
HISTFILE="$HOME/.zsh_history"

# Number of commands to remember in current session
HISTSIZE=10000

# Number of commands to save to history file
SAVEHIST=5000

# History options
setopt hist_ignore_dups         # Don't save duplicate commands in a row
setopt hist_ignore_all_dups     # Remove older duplicate commands
setopt hist_ignore_space        # Don't save commands that start with space
setopt share_history            # Share history between sessions
setopt extended_history         # Save timestamps in history
setopt hist_save_no_dups        # Don't save duplicate commands to file
setopt hist_find_no_dups        # Don't show duplicates when searching
setopt hist_verify              # Show command before executing from history
setopt hist_expire_dups_first   # Remove duplicates first when trimming history