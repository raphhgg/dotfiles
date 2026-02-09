#!/bin/bash
set -euo pipefail

# Auto-detect dotfiles directory from script location
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$DOTFILES_DIR"

# Safety: bail on uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "SYNC STOPPED: Uncommitted changes. Commit or stash first."
    exit 0
fi

# Check for updates
git fetch origin main
LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse origin/main)

if [ "$LOCAL" = "$REMOTE" ]; then
    echo "Already up to date."
    exit 0
fi

echo "Updates detected. Pulling..."
if ! git pull origin main --rebase; then
    echo "Pull failed. Aborting rebase."
    git rebase --abort 2>/dev/null || true
    exit 1
fi

echo "Updated successfully."
