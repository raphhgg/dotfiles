#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
AGENT_STANDARDS_DIR="${AGENT_STANDARDS_DIR:-$HOME/agent-standards}"

sync_repo() {
  local repo_dir="$1"
  local name="$2"

  if [[ ! -d "$repo_dir/.git" ]]; then
    echo "SKIP: ${name} not found at ${repo_dir}"
    return
  fi

  echo "==> Syncing ${name} (${repo_dir})"
  cd "$repo_dir"

  if ! git diff-index --quiet HEAD --; then
    echo "STOP: ${name} has uncommitted changes. Commit or stash first."
    return 1
  fi

  git fetch origin main

  local local_rev remote_rev base_rev
  local_rev="$(git rev-parse HEAD)"
  remote_rev="$(git rev-parse origin/main)"
  base_rev="$(git merge-base HEAD origin/main)"

  if [[ "$local_rev" == "$remote_rev" ]]; then
    echo "${name}: already up to date."
    return
  fi

  if [[ "$local_rev" != "$base_rev" ]]; then
    echo "STOP: ${name} has local commits not on origin/main. Push or reconcile first."
    return 1
  fi

  echo "${name}: pulling latest changes..."
  if ! git pull origin main --rebase; then
    echo "${name}: pull failed. Aborting rebase."
    git rebase --abort 2>/dev/null || true
    return 1
  fi

  echo "${name}: updated successfully."
}

sync_repo "$DOTFILES_DIR" "dotfiles"
sync_repo "$AGENT_STANDARDS_DIR" "agent-standards"
