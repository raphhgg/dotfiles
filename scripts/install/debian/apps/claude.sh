#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

main() {
  require_command curl

  if command -v claude >/dev/null 2>&1; then
    success "Claude CLI is already installed"
    return
  fi

  info "Installing Claude CLI"
  curl -fsSL https://claude.ai/install.sh | bash
  success "Claude CLI installation finished"
}

main "$@"
