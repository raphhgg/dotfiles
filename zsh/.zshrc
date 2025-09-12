# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt extended_history
setopt hist_save_no_dups
setopt hist_find_no_dups

# Key bindings
bindkey -e  # emacs keymap
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Auto-completion
autoload -Uz compinit
compinit

# Enable zsh profiling (uncomment for debugging startup speed)
# zmodload zsh/zprof

# Run fastfetch on terminal start
if command -v fastfetch >/dev/null 2>&1; then
    fastfetch
fi

# Aliases
alias ls="ls --color"
alias c="clear"
alias zquery="zoxide query -l -s | less"

# Initialize oh-my-posh if available
if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init zsh --config ~/.config/omp/config.toml)"
fi

# Initialize fzf if available
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

# Initialize zoxide if available
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Auto-suggestions (if available via package manager)
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Syntax highlighting (load last)
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi