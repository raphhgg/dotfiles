#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$(cd "${SCRIPT_DIR}/.." && pwd)}"

detect_target() {
  if [[ "${1:-}" == "macos" || "${1:-}" == "debian" ]]; then
    printf '%s\n' "$1"
    return
  fi

  if [[ "$(uname -s)" == "Darwin" ]]; then
    printf 'macos\n'
    return
  fi

  if [[ -r /etc/os-release ]]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    case "${ID:-}" in
      debian|ubuntu)
        printf 'debian\n'
        return
        ;;
    esac
  fi

  printf 'unsupported\n'
}

main() {
  local target
  target="$(detect_target "${1:-}")"
  if [[ "$target" == "unsupported" ]]; then
    echo "Skipping Codex config install: unsupported platform" >&2
    exit 0
  fi

  local source_config="${DOTFILES_DIR}/codex/.codex/config.${target}.toml"
  if [[ ! -f "$source_config" ]]; then
    echo "Missing Codex config source: ${source_config}" >&2
    exit 1
  fi

  mkdir -p "${HOME}/.codex"
  cp "$source_config" "${HOME}/.codex/config.toml"
}

main "${1:-}"
