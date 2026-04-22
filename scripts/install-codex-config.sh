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
  local target_config="${HOME}/.codex/config.toml"
  local local_overlay="${HOME}/.codex/config.local.toml"
  local tmp_config
  tmp_config="$(mktemp "${HOME}/.codex/config.XXXXXX.toml")"

  sed "s#__HOME__#${HOME//\#/\\#}#g" "$source_config" > "$tmp_config"

  if [[ -f "$local_overlay" ]]; then
    {
      printf '\n'
      printf '# Local machine-specific additions\n'
      sed "s#__HOME__#${HOME//\#/\\#}#g" "$local_overlay"
    } >> "$tmp_config"
  fi

  mv "$tmp_config" "$target_config"
}

main "${1:-}"
