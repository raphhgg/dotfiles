#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${SCRIPT_DIR}"
LOG_DIR="${HOME}/Library/Logs"
LOG_FILE="${LOG_DIR}/dotfiles-bootstrap.log"

mkdir -p "${LOG_DIR}"
touch "${LOG_FILE}"
exec > >(tee -a "${LOG_FILE}") 2>&1

bold="$(tput bold 2>/dev/null || true)"
red="$(tput setaf 1 2>/dev/null || true)"
yellow="$(tput setaf 3 2>/dev/null || true)"
green="$(tput setaf 2 2>/dev/null || true)"
reset="$(tput sgr0 2>/dev/null || true)"

step() {
  printf "\n%s==>%s %s\n" "${bold}" "${reset}" "$1"
}

info() {
  printf "%s[info]%s %s\n" "${green}" "${reset}" "$1"
}

warn() {
  printf "%s[warn]%s %s\n" "${yellow}" "${reset}" "$1"
}

fail() {
  printf "%s[fail]%s %s\n" "${red}" "${reset}" "$1" >&2
  exit 1
}

confirm_continue() {
  local prompt="${1:-Press Enter to continue}"
  read -r -p "${prompt} "
}

assert_macos() {
  [[ "$(uname -s)" == "Darwin" ]] || fail "This bootstrap script only supports macOS."
}

ensure_xcode_clt() {
  step "Checking Xcode Command Line Tools"

  if xcode-select -p >/dev/null 2>&1; then
    info "Xcode Command Line Tools already installed."
    return
  fi

  warn "Xcode Command Line Tools are required before Homebrew can be installed."
  xcode-select --install || true
  warn "Complete the Apple installer window, then come back here."

  until xcode-select -p >/dev/null 2>&1; do
    confirm_continue "Press Enter once Xcode Command Line Tools are installed."
  done

  info "Xcode Command Line Tools installed."
}

ensure_homebrew() {
  step "Checking Homebrew"

  if command -v brew >/dev/null 2>&1; then
    info "Homebrew already installed."
  else
    warn "Installing Homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    fail "Homebrew install completed but brew is still not on disk."
  fi

  info "Using brew at $(command -v brew)"
}

ensure_bootstrap_tools() {
  step "Installing bootstrap tools"
  HOMEBREW_NO_AUTO_UPDATE=1 brew install git stow just mas
}

ensure_repo_context() {
  step "Validating repository"

  [[ -f "${DOTFILES_DIR}/Brewfile" ]] || fail "Brewfile not found in ${DOTFILES_DIR}"
  [[ -f "${DOTFILES_DIR}/justfile" ]] || fail "justfile not found in ${DOTFILES_DIR}"
  [[ -x "${DOTFILES_DIR}/macos/apply-preferences.sh" ]] || fail "macos/apply-preferences.sh is not executable"

  info "Using dotfiles repo at ${DOTFILES_DIR}"
}

install_brew_bundle() {
  step "Installing Homebrew packages from Brewfile"
  HOMEBREW_NO_AUTO_UPDATE=1 brew bundle install --file "${DOTFILES_DIR}/Brewfile"
}

stow_dotfiles() {
  step "Stowing macOS dotfiles"
  (cd "${DOTFILES_DIR}" && just stow-macos)
}

apply_macos_preferences() {
  step "Applying macOS preferences"
  (
    cd "${DOTFILES_DIR}"
    ALLOW_UNSAFE_DOWNLOADS=0 ./macos/apply-preferences.sh
  )
}

verify_symlinks() {
  step "Verifying critical symlinks"

  local required=(
    "${HOME}/.zshrc"
    "${HOME}/.gitconfig"
    "${HOME}/.ssh/config"
    "${HOME}/.config/zed/settings.json"
    "${HOME}/.config/tmux/tmux.conf"
    "${HOME}/.codex/config.toml"
    "${HOME}/.claude/settings.json"
  )

  local missing=0
  for path in "${required[@]}"; do
    if [[ -L "${path}" || -f "${path}" ]]; then
      info "Found ${path}"
    else
      warn "Missing ${path}"
      missing=1
    fi
  done

  [[ "${missing}" -eq 0 ]] || warn "Some expected files are still missing. Check stow conflicts."
}

print_manual_follow_up() {
  cat <<EOF

${bold}Manual follow-up you still need on the new Mac${reset}

1. Restore SSH keys and any local-only SSH includes such as ~/.ssh/config.local.
2. Sign in to the App Store before rerunning brew bundle if MAS apps were skipped.
3. Re-authenticate CLI tools: gh, Claude, Codex, Cursor, Raycast, Tailscale, Proton Pass.
4. Re-grant macOS permissions: Accessibility, Full Disk Access, Input Monitoring, Screen Recording, Automation.
5. Start and approve AeroSpace and Karabiner-Elements at login.
6. Enable Touch ID for sudo manually if you still want it:
   sudo sed -i '' '2i\\
auth       sufficient     pam_tid.so
' /etc/pam.d/sudo_local
7. Restore non-dotfile data: ~/Projects, Obsidian vaults, local databases, .env files, browser profiles, and recovery codes.

Migration checklist: ${DOTFILES_DIR}/macos/MIGRATION_CHECKLIST.md
Bootstrap log: ${LOG_FILE}
EOF
}

main() {
  cat <<EOF
${bold}macOS bootstrap${reset}
Repo: ${DOTFILES_DIR}
This script installs packages, stows dotfiles, and applies macOS preferences.
EOF

  assert_macos
  ensure_repo_context
  ensure_xcode_clt
  ensure_homebrew
  ensure_bootstrap_tools
  install_brew_bundle
  stow_dotfiles
  apply_macos_preferences
  verify_symlinks
  print_manual_follow_up
}

main "$@"
