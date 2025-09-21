# Zsh Helper Functions
# Collection of reusable utility functions for zsh configuration

# Check if a command is available
has_command() {
    command -v "$1" >/dev/null 2>&1
}

# Initialize a tool if it's available
init_tool() {
    local tool="$1"
    local init_cmd="$2"
    
    if has_command "$tool"; then
        local output
        output=$(eval "$init_cmd")
        eval "$output"
    fi
}

# Safely source a file if it exists and is readable
safe_source() {
    local file="$1"
    [[ -r "$file" ]] && source "$file"
}

# Initialize zinit (assumes it's properly installed)
init_zinit() {
    source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit
}

# Add directory to PATH if it exists and isn't already there
add_to_path() {
    local dir="$1"
    
    if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$dir:$PATH"
    fi
}

# Run command if tool is available (useful for startup commands)
run_if_available() {
    local tool="$1"
    shift
    
    if has_command "$tool"; then
        "$tool" "$@"
    fi
}

# Set environment variable if command exists
export_if_command_exists() {
    local var_name="$1"
    local command="$2"
    
    if has_command "$command"; then
        export "$var_name"="$(command -v "$command")"
    fi
}

# Show zsh profiling results if enabled
show_profiling() {
    if [[ -n "${ZSH_PROF+1}" ]]; then
        zprof
    fi
}

# Check if we're already inside a tmux session
is_in_tmux() {
    [[ -n "$TMUX" ]]
}

# Get the first detached tmux session ID
get_detached_session() {
    tmux list-sessions 2>/dev/null | grep -v "(attached)" | head -1 | cut -d: -f1
}

# Auto-attach to tmux session or create new one
tmux_auto_attach() {
    # Skip if already in tmux or if SKIP_TMUX is set
    if is_in_tmux || [[ -n "$SKIP_TMUX" ]]; then
        return 0
    fi

    # Skip if tmux is not available
    if ! has_command "tmux"; then
        return 0
    fi

    # Try to attach to a detached session first
    local detached_session
    detached_session=$(get_detached_session)

    if [[ -n "$detached_session" ]]; then
        tmux attach-session -t "$detached_session"
    else
        # No detached sessions, create a new one
        tmux new-session
    fi
}

