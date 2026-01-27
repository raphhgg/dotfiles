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


# TODO
# alias zquery="zoxide query -l -s | less"
