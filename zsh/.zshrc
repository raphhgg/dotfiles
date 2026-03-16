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
# init_tool "fzf" "source <(fzf --zsh)"

# Zoxide 
init_tool "zoxide" "zoxide init zsh"

# Replace 'cd' with zoxide 
eval "$(zoxide init zsh --cmd cd)"

# Show profiling results if enabled
# show_profiling

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="/home/raphh/.local/bin:$PATH"
export PATH="/home/raphh/.fzf/bin:$PATH"

# opencode
export PATH=/home/raphh/.opencode/bin:$PATH
