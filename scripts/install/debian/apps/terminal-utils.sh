#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

install_gh_cli() {
  if command -v gh >/dev/null 2>&1; then
    success "GitHub CLI is already installed"
    return
  fi

  if ! command -v wget >/dev/null 2>&1; then
    apt_install_required wget
  fi

  info "Adding GitHub CLI apt repository"
  sudo mkdir -p -m 755 /etc/apt/keyrings

  local out=""
  out="$(mktemp)"
  wget -nv -O "$out" https://cli.github.com/packages/githubcli-archive-keyring.gpg
  sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null <"$out"
  rm -f "$out"

  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
  sudo mkdir -p -m 755 /etc/apt/sources.list.d
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null

  info "Updating apt package index"
  sudo apt update
  info "Installing GitHub CLI"
  sudo DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends gh
}

main() {
  require_debian
  require_command apt
  require_command sudo
  require_sudo

  local packages=(
    stow
    bash
    bat
    btop
    eza
    fastfetch
    ffmpeg
    fswatch
    fzf
    git
    just
    lua5.4
    procps
    ripgrep
    sqlite3
    tmux
    yq
    yt-dlp
    zoxide
  )

  apt_install_if_missing "${packages[@]}"
  install_gh_cli
  success "Terminal utilities installation finished"
}

main "$@"
