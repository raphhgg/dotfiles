#!/usr/bin/env bash

set -euo pipefail

log() {
  local level="$1"
  shift
  printf '[%s] %s\n' "$level" "$*"
}

info() {
  log "INFO" "$@"
}

warn() {
  log "WARN" "$@"
}

success() {
  log "OK" "$@"
}

die() {
  log "ERROR" "$@"
  exit 1
}

require_command() {
  local cmd="$1"
  command -v "$cmd" >/dev/null 2>&1 || die "Missing required command: $cmd"
}

require_sudo() {
  if ! sudo -v; then
    die "sudo authentication failed"
  fi
}

require_debian() {
  if [[ ! -f /etc/os-release ]]; then
    die "Cannot detect operating system"
  fi

  local distro=""
  distro="$(. /etc/os-release && echo "${ID:-}")"
  if [[ "$distro" != "debian" ]]; then
    die "This installer only supports Debian (detected: ${distro:-unknown})"
  fi
}

debian_major_version() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    printf '%s\n' "${VERSION_ID%%.*}"
  else
    printf '0\n'
  fi
}

apt_update_once() {
  if [[ "${DOTFILES_APT_UPDATED:-0}" == "1" ]]; then
    return
  fi
  info "Updating apt package index"
  sudo apt update
  export DOTFILES_APT_UPDATED=1
}

is_pkg_installed() {
  local pkg="$1"
  dpkg -s "$pkg" >/dev/null 2>&1
}

apt_has_package() {
  local pkg="$1"
  apt-cache show "$pkg" >/dev/null 2>&1
}

apt_install_if_missing() {
  local missing=()
  local pkg
  for pkg in "$@"; do
    if is_pkg_installed "$pkg"; then
      continue
    fi
    if ! apt_has_package "$pkg"; then
      warn "Package not found in apt repositories: $pkg"
      continue
    fi
    missing+=("$pkg")
  done

  if [[ ${#missing[@]} -eq 0 ]]; then
    info "Requested apt packages are already installed or unavailable"
    return
  fi

  apt_update_once
  info "Installing apt packages: ${missing[*]}"
  sudo DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends "${missing[@]}"
}

apt_install_required() {
  local missing=()
  local pkg
  for pkg in "$@"; do
    if is_pkg_installed "$pkg"; then
      continue
    fi
    if ! apt_has_package "$pkg"; then
      die "Required apt package not found: $pkg"
    fi
    missing+=("$pkg")
  done

  if [[ ${#missing[@]} -eq 0 ]]; then
    return
  fi

  apt_update_once
  info "Installing required apt packages: ${missing[*]}"
  sudo DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends "${missing[@]}"
}
