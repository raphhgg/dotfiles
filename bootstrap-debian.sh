#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/install/debian/lib/common.sh"

AVAILABLE_APPS=(
  "terminal-utils"
  "shells"
  "node"
  "neovim"
  "oh-my-posh"
  "ai-tools"
  "stow-dotfiles"
)

DEFAULT_PROFILE="full"
PROFILE="$DEFAULT_PROFILE"
ONLY_APPS=""
SKIP_APPS=""
WITH_LATEST=""

usage() {
  cat <<'EOF'
Usage: ./bootstrap-debian.sh [options]

Options:
  --profile <base|server|full>  Select app profile (default: full)
  --only <a,b,c>                Install only these app modules
  --skip <a,b,c>                Skip these app modules
  --with-latest <a,b,c>         Use latest installer variant for listed modules
  --help                        Show this help

App modules:
  terminal-utils,shells,node,neovim,oh-my-posh,ai-tools,stow-dotfiles

Latest-capable modules:
  neovim
EOF
}

split_csv() {
  local value="$1"
  local -n out_ref="$2"
  out_ref=()
  if [[ -z "$value" ]]; then
    return
  fi
  IFS=',' read -r -a out_ref <<< "$value"
}

is_valid_app() {
  local target="$1"
  local app
  for app in "${AVAILABLE_APPS[@]}"; do
    if [[ "$app" == "$target" ]]; then
      return 0
    fi
  done
  return 1
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --profile)
        PROFILE="${2:-}"
        shift 2
        ;;
      --only)
        ONLY_APPS="${2:-}"
        shift 2
        ;;
      --skip)
        SKIP_APPS="${2:-}"
        shift 2
        ;;
      --with-latest)
        WITH_LATEST="${2:-}"
        shift 2
        ;;
      --help)
        usage
        exit 0
        ;;
      *)
        die "Unknown argument: $1"
        ;;
    esac
  done
}

profile_apps() {
  local profile="$1"
  case "$profile" in
    base)
      echo "terminal-utils,shells,node,neovim,oh-my-posh,stow-dotfiles"
      ;;
    server)
      echo "terminal-utils,shells,node,neovim,oh-my-posh,ai-tools,stow-dotfiles"
      ;;
    full)
      echo "terminal-utils,shells,node,neovim,oh-my-posh,ai-tools,stow-dotfiles"
      ;;
    *)
      die "Invalid profile: $profile"
      ;;
  esac
}

run_app() {
  local app="$1"
  local script_path="$SCRIPT_DIR/scripts/install/debian/apps/$app.sh"
  if [[ ! -f "$script_path" ]]; then
    die "Missing installer script: $script_path"
  fi
  info "Running installer: $app"
  "$script_path"
}

main() {
  parse_args "$@"
  require_debian
  require_command sudo
  require_command apt
  require_command curl
  require_sudo

  local profile_csv
  profile_csv="$(profile_apps "$PROFILE")"

  local selected=()
  split_csv "$profile_csv" selected

  local only_list=()
  local skip_list=()
  local latest_list=()
  split_csv "$ONLY_APPS" only_list
  split_csv "$SKIP_APPS" skip_list
  split_csv "$WITH_LATEST" latest_list

  local item
  if [[ ${#only_list[@]} -gt 0 ]]; then
    selected=()
    for item in "${only_list[@]}"; do
      is_valid_app "$item" || die "Invalid app in --only: $item"
      selected+=("$item")
    done
  fi

  if [[ ${#skip_list[@]} -gt 0 ]]; then
    local filtered=()
    local app
    for app in "${selected[@]}"; do
      local should_skip=0
      for item in "${skip_list[@]}"; do
        is_valid_app "$item" || die "Invalid app in --skip: $item"
        if [[ "$app" == "$item" ]]; then
          should_skip=1
          break
        fi
      done
      if [[ $should_skip -eq 0 ]]; then
        filtered+=("$app")
      fi
    done
    selected=("${filtered[@]}")
  fi

  local use_latest_neovim=0
  for item in "${latest_list[@]}"; do
    if [[ "$item" == "neovim" ]]; then
      use_latest_neovim=1
    else
      die "Unsupported app in --with-latest: $item"
    fi
  done

  export DOTFILES_REPO_ROOT="$SCRIPT_DIR"

  info "Selected profile: $PROFILE"
  info "Selected modules: ${selected[*]}"
  if [[ $use_latest_neovim -eq 1 ]]; then
    info "Latest overrides: neovim"
  fi

  local app
  for app in "${selected[@]}"; do
    if [[ "$app" == "neovim" && $use_latest_neovim -eq 1 ]]; then
      run_app "neovim-latest"
    else
      run_app "$app"
    fi
  done

  success "Bootstrap complete. Restart your shell session to apply all changes."
}

main "$@"
