# Completion System Configuration
# Settings for zsh auto-completion

# Initialize completion system
autoload -Uz compinit
compinit

# Completion options
setopt complete_in_word     # complete from both ends of word
setopt always_to_end        # move cursor to end of word after completion
setopt auto_menu            # show completion menu on successive tab press
setopt auto_list            # automatically list choices on ambiguous completion

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Menu selection for completion
zstyle ':completion:*' menu select

# Completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"

# Better directory completion
zstyle ':completion:*' special-dirs true

# Colorful completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Salmon completion
fpath=(/volume2/docker/compose/scripts $fpath)