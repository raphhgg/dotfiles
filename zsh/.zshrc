# Modular Zsh Configuration
# Main configuration file that sources modular components

# Enable zsh profiling (uncomment for debugging startup speed)
# zmodload zsh/zprof

# Source helper functions first
source ~/helpers.zsh

# Source configuration modules
safe_source ~/history.zsh
safe_source ~/completion.zsh
safe_source ~/keybinds.zsh
safe_source ~/aliases.zsh

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
init_zinit
zinit load "zsh-users/zsh-autosuggestions"
zinit load "zsh-users/zsh-syntax-highlighting"  # Load syntax highlighting last

# Tool Initialization (system tools managed by nix-darwin)
init_tool "oh-my-posh" "oh-my-posh init zsh --config ~/.config/omp/config.toml"
init_tool "fzf" "fzf --zsh"
init_tool "zoxide" "zoxide init zsh"

# Run fastfetch on terminal start
run_if_available "fastfetch"

# Show profiling results if enabled
show_profiling