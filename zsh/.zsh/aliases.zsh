# Aliases Configuration
# Custom aliases and functions

### Zsh
alias x="exit"
alias c="clear"
alias rm="rm -r"

### Cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

### Bat
alias cat=bat
# Highlight JSON or YAML files nicely
alias jcat='bat --language json'
alias ycat='bat --language yaml'

### Ls / Eza
# https://man.archlinux.org/man/extra/eza/eza.1.en
# full
alias ls='eza -la -lh --icons --git --group-directories-first --header --sort=name'
# minimal
alias l='eza --icons --group-directories-first --sort=name'
# minimal + hidden
alias la='eza -a --icons --group-directories-first --sort=name'
# tree view (2 levels deep)
alias lt='eza --tree --level=2 --icons --git'


### Docker Compose
# down
alias dcd="docker compose down"
# up detached
alias dcu="docker compose up"
# restart quickly after a config/env change.
alias dcr="docker compose restart"
# redeploy after updating image versions or dependencies.
alias dcdpu="docker compose down && docker compose pull && docker compose up"


### Git

# Add
# git add followed by file names
alias ga="git add"
# git add all files
alias gaa="git add ."

# Commit
# git commit with a message
alias gc="git commit -m"
# git commit with a message and push to remote
alias gcp="git commit -am && git push"

# git commit all staged modified and deleted files that are already being tracked
# it does not stage new untracked files — you still need to git add those first.
alias gc="git commit -am"

# add all files and commit with a message
alias gaac='git add . && git commit -m'
# add all files and commit with a message and push to remote
alias gaacp='git add . && git commit -m && git push'


### Claude Code
# claude code local
alias ccl='unset ANTHROPIC_API_KEY; \
export ANTHROPIC_BASE_URL="http://10.10.1.111:11434"; \
export ANTHROPIC_AUTH_TOKEN="ollama"; \
export ANTHROPIC_DEFAULT_OPUS_MODEL="qwen3-coder:30b"; \
export ANTHROPIC_DEFAULT_SONNET_MODEL="qwen3-coder:30b"; \
export ANTHROPIC_DEFAULT_HAIKU_MODEL="qwen2.5-coder:7b"; \
claude --model opus'

#alias cco='claude --model qwen-opus'
alias ccs='claude --model qwen-sonnet'

alias cc='ANTHROPIC_BASE_URL=http://10.10.1.111:11434 ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_MODEL=qwen-opus-safe ANTHROPIC_DEFAULT_OPUS_MODEL=qwen-opus-safe ANTHROPIC_DEFAULT_SONNET_MODEL=qwen-opus-safe ANTHROPIC_DEFAULT_HAIKU_MODEL=qwen-opus-safe ANTHROPIC_SMALL_FAST_MODEL=qwen-opus-safe claude'

alias ccc='ANTHROPIC_BASE_URL=http://10.10.1.111:11434 \
ANTHROPIC_AUTH_TOKEN=ollama \
ANTHROPIC_MODEL="qwen2.5-coder:7b-instruct" \
ANTHROPIC_DEFAULT_OPUS_MODEL="qwen2.5-coder:7b-instruct" \
ANTHROPIC_DEFAULT_SONNET_MODEL="qwen2.5-coder:7b-instruct" \
ANTHROPIC_DEFAULT_HAIKU_MODEL="qwen2.5-coder:7b-instruct" \
ANTHROPIC_SMALL_FAST_MODEL="qwen2.5-coder:7b-instruct" \
CLAUDE_CODE_MODEL="qwen2.5-coder:7b-instruct" \
CLAUDE_CODE_PLANNER_MODEL="qwen2.5-coder:7b-instruct" \
claude'


# TODO
# alias zquery="zoxide query -l -s | less"
