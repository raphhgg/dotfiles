#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

main() {
  local repo_root="${DOTFILES_REPO_ROOT:-}"
  if [[ -z "$repo_root" ]]; then
    repo_root="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
  fi

  if [[ ! -d "$repo_root" ]]; then
    die "Dotfiles repository root not found: $repo_root"
  fi

  require_command stow

  local stow_folders=(
    zsh
    tmux
    nvim
    btop
    git
    oh-my-posh
    ssh
  )

  info "Applying stow symlinks from $repo_root"
  local folder
  for folder in "${stow_folders[@]}"; do
    if [[ ! -d "$repo_root/$folder" ]]; then
      warn "Skipping missing stow package: $folder"
      continue
    fi
    info "Stowing $folder"
    stow -t "$HOME" -R -v -d "$repo_root" "$folder"
  done
  success "Stow phase finished"
}

main "$@"
