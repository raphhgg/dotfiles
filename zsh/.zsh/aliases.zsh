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
# On Ubuntu/Debian, bat is installed as 'batcat'
if has_command bat; then
    alias cat=bat
    alias jcat='bat --language json'
    alias ycat='bat --language yaml'
elif has_command batcat; then
    alias bat=batcat
    alias cat=batcat
    alias jcat='batcat --language json'
    alias ycat='batcat --language yaml'
fi

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
alias dcu="docker compose up -d"
# restart quickly after a config/env change.
alias dcr="docker compose restart"
# force recreate
alias dcduf="docker compose down && docker compose up --force-recreate"
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


### Tmux
# Kill session
alias tk="tmux kill-session -t"

# SSH + tmux connections
alias sds="ssh ds423plus"
alias sub="ssh ubuntu-server"
alias sds-shell="ssh ds423plus-notmux"
alias sub-shell="ssh ubuntu-server-notmux"


### Wake On Lan
alias wolub="wakeonlan 10:7c:61:3f:c9:8f && sleep 10 && ssh ubuntu-server"

### Dotfiles Sync
alias dsync='$HOME/github/dotfiles/scripts/sync.sh'


# -----------------------------------------
# CLAUDE AGENT SWITCHER
# -----------------------------------------

# MODE 1: LOCAL (Uses your Server)
# - Default: GLM-4.7-Flash (GPU)
# - Option: /model local-opus (120B on CPU)
alias ccloc='export ANTHROPIC_BASE_URL="http://10.10.1.111:4000/" && \
export ANTHROPIC_API_KEY="sk-dummy" && \
export ANTHROPIC_AUTH_TOKEN="sk-litellm-static-key" && \
echo -e "\n🟢 MODE: LOCAL COMPUTE (LiteLLM Bridge)" && \
claude'
# MODE 2: PRO (Uses Anthropic Cloud)
# - Uses your paid subscription
# - Use when local models fail
alias ccsub='unset ANTHROPIC_BASE_URL && unset ANTHROPIC_API_KEY && unset ANTHROPIC_AUTH_TOKEN && echo -e "\n🔴 MODE: CLOUD SUBSCRIPTION (Paid)" && claude'

alias salmon='/volume2/docker/compose/scripts/salmon-upload.sh'
alias salmon-auto='/volume2/docker/compose/scripts/music/salmon-upload-auto.py'

# TODO
# alias zquery="zoxide query -l -s | less"

# Opencode
# Attach to opencode server running on ds423plus
alias ocnas=OPENCODE_SERVER_PASSWORD=uAiJPc9c7xMT3i0dPTcOcfkyrG5ZMTU opencode attach http://10.10.2.2:4096
