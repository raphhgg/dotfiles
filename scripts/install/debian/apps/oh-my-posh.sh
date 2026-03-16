#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

main() {
  require_command curl

  if command -v oh-my-posh >/dev/null 2>&1; then
    success "oh-my-posh is already installed"
    return
  fi

  local install_dir="$HOME/.local/bin"
  mkdir -p "$install_dir"
  info "Installing oh-my-posh into $install_dir"
  curl -fsSL https://ohmyposh.dev/install.sh | bash -s -- -d "$install_dir"

  if command -v oh-my-posh >/dev/null 2>&1; then
    success "oh-my-posh installation finished"
    return
  fi

  warn "oh-my-posh installed, but not visible in current PATH"
  warn "Ensure $install_dir is in your shell PATH"
}

main "$@"
