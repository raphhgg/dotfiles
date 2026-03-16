#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

main() {
  require_debian
  require_command curl
  require_command tar
  require_command sudo
  require_sudo

  apt_install_if_missing curl tar

  local arch
  arch="$(uname -m)"

  local artifact_dir=""
  local artifact_tar=""
  case "$arch" in
    x86_64)
      artifact_dir="nvim-linux-x86_64"
      artifact_tar="nvim-linux-x86_64.tar.gz"
      ;;
    aarch64|arm64)
      artifact_dir="nvim-linux-arm64"
      artifact_tar="nvim-linux-arm64.tar.gz"
      ;;
    *)
      die "Unsupported architecture for Neovim prebuilt release: $arch"
      ;;
  esac

  local download_url="https://github.com/neovim/neovim/releases/latest/download/$artifact_tar"
  local temp_dir
  temp_dir="$(mktemp -d)"
  trap 'rm -rf "$temp_dir"' EXIT

  info "Downloading latest Neovim release for $arch"
  curl -fsSL "$download_url" -o "$temp_dir/$artifact_tar"

  info "Extracting archive"
  tar -xzf "$temp_dir/$artifact_tar" -C "$temp_dir"

  info "Installing under /opt/$artifact_dir"
  sudo rm -rf "/opt/$artifact_dir"
  sudo mv "$temp_dir/$artifact_dir" /opt/

  info "Creating /usr/local/bin/nvim symlink"
  sudo ln -sf "/opt/$artifact_dir/bin/nvim" /usr/local/bin/nvim

  info "Neovim installed: $(nvim --version | head -n 1)"
  success "Neovim latest installation finished"
}

main "$@"
