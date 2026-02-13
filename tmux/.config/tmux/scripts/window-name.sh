#!/usr/bin/env bash
# Wrapper around tmux-nerd-font-window-name that resolves ambiguous
# process names to their actual application name.
#
# Handles:
# - Claude Code: binary named by version (e.g. "2.1.39")
# - Node.js apps: "node" resolved to the actual app (e.g. opencode)

CMD="$1"
PANES="$2"
PID="$3"
SCRIPT=~/.config/tmux/plugins/tmux-nerd-font-window-name/bin/tmux-nerd-font-window-name

# Resolve version-like command names (e.g. "2.1.39") by checking known app paths
if [[ "$CMD" =~ ^[0-9]+\.[0-9] ]]; then
  if [[ -f "$HOME/.local/share/claude/versions/$CMD" ]]; then
    CMD="claude"
  fi
# Resolve "node" to the actual app by inspecting child process args
elif [[ "$CMD" == "node" ]]; then
  CHILD_ARGS=$(pgrep -P "$PID" 2>/dev/null | while read -r cpid; do
    ps -p "$cpid" -o args= 2>/dev/null
  done)
  for app in opencode; do
    if [[ "$CHILD_ARGS" == *"$app"* ]]; then
      CMD="$app"
      break
    fi
  done
fi

exec "$SCRIPT" "$CMD" "$PANES"
