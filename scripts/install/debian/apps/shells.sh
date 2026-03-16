#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

main() {
  require_debian
  require_command apt
  require_command sudo
  require_sudo

  apt_install_if_missing bash zsh

  local set_default_shell="${DOTFILES_SET_ZSH_DEFAULT:-1}"
  if [[ "$set_default_shell" != "1" ]]; then
    success "Shell installation finished (default shell unchanged)"
    return
  fi

  local zsh_path
  zsh_path="$(command -v zsh || true)"
  if [[ -z "$zsh_path" ]]; then
    warn "zsh is not available on PATH; skipping default shell update"
    return
  fi

  if [[ "${SHELL:-}" == "$zsh_path" ]]; then
    success "zsh is already the active login shell"
    return
  fi

  info "Setting default shell to zsh"
  if chsh -s "$zsh_path"; then
    success "Default shell updated to zsh"
  else
    warn "Failed to change shell automatically. Run: chsh -s $zsh_path"
  fi
}

main "$@"
