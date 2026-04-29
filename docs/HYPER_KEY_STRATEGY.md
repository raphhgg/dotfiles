# Hyper Key Strategy for macOS Development Environment

## Overview

This document outlines which applications use the hyper key (Caps Lock) and how they're organized to avoid conflicts.

## Applications

### Karabiner-Elements
**How it works**: Caps Lock → Hyper Key (Cmd+Ctrl+Alt+Shift) transformation and Belgian AZERTY fixes
- Look in `$HOME/dotfiles/karabiner/.config/karabiner/assets/complex_modifications/` for modular configuration files.

### tmux (Hyper+A)
**How it works**: Ghostty translates `Hyper+A` → F1 escape sequence → tmux prefix
- Look in `$HOME/dotfiles/tmux/.config/tmux/tmux.conf` for more info.

### Raycast
**How it works**: Direct Raycast integration, auto-detects hyper key.

### AeroSpace (Window Management)
**How it works**: Direct AeroSpace bindings with Belgian AZERTY support

**Workspace Management**:
- `Hyper + 1-9` → Switch to workspace 1-9
- `cmd+tab` → Next workspace with windows (overrides macOS app switcher)
- `opt+tab` → Previous workspace with windows
- `Hyper + Tab` → Toggle between current and previous workspace
- `Hyper + Left/Right` → Focus previous/next monitor

**Window Management**:
- `Hyper + H/J/K/L` → Focus left/down/up/right window
- `Hyper + Shift + H/J/K/L` → Move window left/down/up/right
- `Hyper + M, then 1-9` → Move window to workspace and follow
- `Hyper + F` → Toggle fullscreen

**Special Features**:
- cmd+tab completely overrides macOS application switcher
- Only visits workspaces that contain windows
- Automatic app-to-workspace assignments
- Multi-monitor workspace pinning:
  - Laptop/main display: workspaces 1, 2, 3, 4, 8
  - External display: workspaces 5, 6, 7, 9
- Belgian AZERTY keyboard fully supported

- Look in `$HOME/dotfiles/aerospace/.config/aerospace/aerospace.toml` for more info.

## Troubleshooting

### Hyper Key Not Working
- Check Karabiner-Elements permissions in System Settings → Privacy & Security
- Verify Caps Lock → Hyper Key rule is enabled in Karabiner-Elements
- Test with `Hyper + A` for tmux - should show prefix indicator

### tmux Prefix Not Working
- Check Ghostty config: `$HOME/dotfiles/ghostty/.config/ghostty/config`
- Verify tmux config: `$HOME/dotfiles/tmux/.config/tmux/tmux.conf`
- Test escape sequence: `cat -v` should show `^[OP` for `Hyper+A`

### cmd+tab Still Shows macOS App Switcher
- Check Karabiner-Elements complex modifications are imported and enabled
- Look for `aerospace_cmd_tab_navigation.json` in active rules
- Restart Karabiner-Elements if needed

### AeroSpace Shortcuts Not Working
- Verify AeroSpace is running: `aerospace list-workspaces`
- Check config: `$HOME/dotfiles/aerospace/.config/aerospace/aerospace.toml`
- Reload AeroSpace config: `aerospace reload-config`

### Belgian AZERTY Keys Not Working
- Import Belgian AZERTY modifications from complex_modifications folder
- Check `belgian_azerty_angle_brackets.json` and `aerospace_workspace_switching.json` are enabled
- Verify keyboard type is set to ISO in Karabiner virtual keyboard settings
