# Modular Zsh Configuration
# Main configuration file that sources modular components

# Enable zsh profiling (uncomment for debugging startup speed)
# zmodload zsh/zprof

# Fix TERM if it's set to dumb (happens with SSH RemoteCommand)
if [[ "$TERM" == "dumb" && -n "$TMUX" ]]; then
    export TERM=tmux-256color
elif [[ "$TERM" == "dumb" ]]; then
    export TERM=xterm-256color
fi

# Source helper functions first
source ~/.zsh/helpers.zsh

# Source configuration modules
safe_source ~/.zsh/history.zsh
safe_source ~/.zsh/completion.zsh
safe_source ~/.zsh/aliases.zsh

# Zsh Options
setopt auto_cd              # cd into directory by typing its name
setopt auto_pushd           # automatically push directories to stack
setopt pushd_silent         # don't print directory stack after pushd/popd
setopt glob_dots            # include hidden files in globbing
setopt extended_glob        # enable extended globbing patterns
setopt prompt_subst         # enable parameter expansion in prompts
setopt interactive_comments # allow comments in interactive shells
setopt long_list_jobs       # show job information in long format

# Initialize zinit and load plugins
if init_zinit; then
    zinit load "zsh-users/zsh-autosuggestions"
    zinit load "zsh-users/zsh-syntax-highlighting"  # Load syntax highlighting last
fi

# Tool Initialization (system tools managed by nix-darwin)
init_tool "oh-my-posh" "oh-my-posh init zsh --config ~/.config/omp/config.toml"
# init_tool "fzf" "fzf --zsh"
init_tool "zoxide" "zoxide init zsh"

# Tmux auto-attach (run only in interactive shells)
# if [[ $- == *i* ]]; then
#     tmux_auto_attach
# fi

# Show profiling results if enabled
# show_profiling

export PATH="/usr/local/bin:$PATH"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# opencode
export PATH=/var/services/homes/raphh/.opencode/bin:$PATH
