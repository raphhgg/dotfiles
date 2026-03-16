#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

main() {
  require_debian
  require_command apt
  require_command sudo
  require_sudo

  apt_install_if_missing neovim
  if command -v nvim >/dev/null 2>&1; then
    info "Neovim installed: $(nvim --version | head -n 1)"
  fi
  success "Neovim apt installation finished"
}

main "$@"
