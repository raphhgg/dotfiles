#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

main() {
  require_debian
  require_command apt
  require_command sudo
  require_sudo

  apt_install_if_missing nodejs npm
  success "Node.js installation finished"
}

main "$@"
