#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

main() {
  require_command curl

  if command -v opencode >/dev/null 2>&1; then
    success "OpenCode is already installed"
    return
  fi

  info "Installing OpenCode"
  curl -fsSL https://opencode.ai/install | bash
  success "OpenCode installation finished"
}

main "$@"
