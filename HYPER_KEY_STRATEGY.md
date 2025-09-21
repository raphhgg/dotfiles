# Hyper Key Strategy for macOS Development Environment

## Overview

This document outlines our strategy for implementing a unified hyper key system across multiple applications using Caps Lock as the foundation key, enabling powerful keyboard shortcuts without conflicts.

## Goals

- **Single Key Foundation**: Use Caps Lock as the base for all power-user shortcuts
- **No Conflicts**: Each application gets its own unique key combination
- **Ergonomic**: Easy to reach combinations that don't strain fingers
- **Consistent**: Same base key (Caps Lock) for all power features

## Design Philosophy

### Why Letter Keys as Part of Prefix is Brilliant

The core insight of this system is using **letter keys as application namespaces**. Rather than treating the letter as "extra complexity," it's actually the **organizing principle** that makes the system scalable and conflict-free.

**🎯 Namespace Organization:**
- **`Hyper+B`** = tmux domain (B for Buffer management, terminal Basics)
- **`Hyper+A`** = App launcher domain (A for Applications)
- **`Hyper+S`** = Space/window management domain (S for Spaces)
- **`Hyper+R`** = System/reload domain (R for Reload, Restart)

**🧠 Mental Model Benefits:**
- **Predictable**: "I need tmux? Think Hyper+B first"
- **Organized**: Each letter represents a clear application category
- **Scalable**: Easy to add new applications without conflicts
- **Memorable**: Letter mnemonics make shortcuts intuitive

**🔧 Practical Advantages:**
- **No accidental triggers**: Won't accidentally activate tmux when using other functions
- **Clear intent**: The letter signals "I'm about to do [app] stuff"
- **Future-proof**: Can add unlimited applications with their own letters
- **Documentation-friendly**: Easy to document and teach others

## Architecture

### High-Level Flow
```
Caps Lock (Physical)
    ↓
Karabiner-Elements (Key Remapper)
    ↓
Cmd+Ctrl+Alt+Shift+[app letter] (Hyper+Letter)
    ↓
Ghostty (Router/Dispatcher)
    ↓
Function Key Escape Sequences
    ↓
Applications (tmux, Aerospace, etc.)
```

### Detailed Architecture: Ghostty as the Router

**🚦 Critical Understanding: Ghostty Controls the Routing**

The letter choice happens in **Ghostty**, not in the target applications:

```
Ghostty Level (Router/Dispatcher):
super+ctrl+alt+shift+b=text:\x1bOP  → Sends F1 to tmux
super+ctrl+alt+shift+s=text:\x1bOQ  → Sends F2 to Aerospace
super+ctrl+alt+shift+a=text:\x1bOR  → Sends F3 to Raycast

Application Level (Receivers):
tmux:      prefix F1  (doesn't know about "B")
Aerospace: prefix F2  (doesn't know about "S")
Raycast:   prefix F3  (doesn't know about "A")
```

**Key Insight**: tmux thinks its prefix is "F1" - it has no knowledge that the user pressed "B". Ghostty translates `Hyper+B` into the F1 escape sequence that tmux understands.

### Centralized Control Benefits

**🎛️ All routing decisions happen in one place (Ghostty config):**

1. **Easy reorganization**: Want to change tmux from B to T? Just edit Ghostty config
2. **No app conflicts**: Each app gets its own function key, managed centrally
3. **Simple expansion**: Add new apps by picking unused letters and function keys
4. **Clear documentation**: One config file shows the entire hyper key mapping

### How to Expand the System

**Adding Aerospace on `Hyper+S`:**
```bash
# In Ghostty config:
keybind = super+ctrl+alt+shift+s=text:\x1bOQ  # F2 for Aerospace

# In Aerospace config:
# Aerospace would receive F2 as its prefix
```

**Adding Raycast on `Hyper+A`:**
```bash
# In Ghostty config:
keybind = super+ctrl+alt+shift+a=text:\x1bOR  # F3 for Raycast

# Raycast would detect F3 as hyper key activation
```

**Changing tmux from B to T:**
```bash
# In Ghostty config:
keybind = super+ctrl+alt+shift+t=text:\x1bOP  # Keep F1, just change trigger

# tmux config stays the same (still receives F1)
# Only the trigger letter changes
```

## ✅ COMPLETED: tmux + Ghostty Integration

### What We Built

**Ghostty Configuration** (`~/.dotfiles/ghostty/.config/ghostty/config`):
```
# Hyper Key Configuration
# Send F1 function key sequence for hyper key prefix
# Using B as the trigger key, sends F1 which tmux can bind to
# Hyper+B acts as tmux prefix
keybind = super+ctrl+alt+shift+b=text:\x1bOP
```

**tmux Configuration** (`~/.dotfiles/tmux/.tmux.conf`):
```
# HYPER KEY PREFIX - Using F1 function key
# Ghostty: Cmd+Ctrl+Alt+Shift+B → F1 sequence → tmux prefix
set-option -g prefix F1
bind-key F1 send-prefix
```

### How It Works

1. **User presses**: `Cmd+Ctrl+Alt+Shift+B`
2. **Ghostty receives**: 4-modifier combination + B
3. **Ghostty sends**: F1 escape sequence (`\x1bOP`) to tmux
4. **tmux recognizes**: F1 as prefix key
5. **User follows with**: Any tmux command (C, R, D, etc.)

### Current Working Commands

- `Cmd+Ctrl+Alt+Shift+B` + `C` = New tmux window
- `Cmd+Ctrl+Alt+Shift+B` + `R` = Reload tmux config
- `Cmd+Ctrl+Alt+Shift+B` + `D` = Detach session
- `Cmd+Ctrl+Alt+Shift+B` + `%` = Vertical split
- `Cmd+Ctrl+Alt+Shift+B` + `"` = Horizontal split
- `Cmd+Ctrl+Alt+Shift+B` + `?` = Show help

### Technical Insights Discovered

1. **tmux Limitation**: Cannot bind to arbitrary escape sequences like `\x1b[200~`
2. **Function Key Solution**: tmux can bind to standard function keys (F1-F12)
3. **Ghostty Power**: Can send custom escape sequences via `text:` action
4. **Escape Sequence Mapping**: `\x1bOP` = F1, which tmux understands perfectly

## ✅ COMPLETED: Karabiner-Elements Integration

### What We Built

**Installation** (via nix-darwin):
- Added `"karabiner-elements"` to `~/nix-darwin-config/darwin/applications/homebrew/gui.nix`
- Installed via `darwin-rebuild switch --flake .`
- Configured system permissions (Input Monitoring, Login Items, Driver Extensions)

**Configuration** (`~/.dotfiles/karabiner/.config/karabiner/karabiner.json`):
```json
{
  "description": "Caps Lock to Hyper Key (Cmd+Ctrl+Alt+Shift) with Escape if alone",
  "manipulators": [
    {
      "type": "basic",
      "from": {
        "key_code": "caps_lock",
        "modifiers": {"optional": ["any"]}
      },
      "to": [
        {
          "key_code": "left_shift",
          "modifiers": ["left_command", "left_control", "left_option"]
        }
      ],
      "to_if_alone": [{"key_code": "escape"}]
    }
  ]
}
```

**Dotfiles Integration**:
- Created `karabiner/` Stow package following repository structure
- Added to justfile for `stow-all` and `unstow-all` commands
- Configuration managed via symlinks like other dotfiles

**Current Working Chain**:
- `Caps Lock + B` → `Cmd+Ctrl+Alt+Shift+B` → Ghostty → F1 → tmux
- `Caps Lock` (alone) → Escape
- Ready for future expansions with other applications

## ✅ READY: Raycast Integration

### Configuration Status
With Karabiner-Elements now installed:

1. **Raycast auto-detects** the hyper key setup (Caps Lock → Cmd+Ctrl+Alt+Shift)
2. **Available for configuration** in Raycast → Settings → Advanced → Hyper Key
3. **Suggested shortcuts**:
   - `Caps Lock + Space` → Raycast launcher
   - `Caps Lock + C` → Calculator
   - `Caps Lock + T` → Terminal
   - `Caps Lock + F` → File search

### Integration Notes
- **tmux reserved**: `Caps Lock + B` is dedicated to tmux workflow
- **Raycast available**: All other hyper key combinations available
- **No conflicts**: Clean separation between applications
- **System conflict**: Check System Settings → Keyboard → Keyboard Shortcuts → Services → "Convert Text to Simplified Chinese" (disable if needed)

## ⏳ PLANNED: Aerospace Window Manager

### Integration Strategy
Aerospace will also use the hyper key for window management:

- `Caps Lock + H/J/K/L` → Navigate windows (vim-style)
- `Caps Lock + 1/2/3` → Switch workspaces
- `Caps Lock + Shift + H/J/K/L` → Move windows

### No Conflicts
- **tmux**: `Caps Lock + B` + tmux commands
- **Raycast**: `Caps Lock + [app shortcuts]`
- **Aerospace**: `Caps Lock + [window commands]`

## Benefits of This Strategy

### ✅ **Ergonomic**
- **Caps Lock**: Large, easy to reach with pinky
- **No finger gymnastics**: Natural modifier combinations
- **Single base key**: Muscle memory for all power features

### ✅ **No Conflicts**
- **Letter-based namespaces**: B=tmux, A=apps, S=spaces, R=reload
- **Function key isolation**: Each app gets its own F-key via Ghostty routing
- **Centralized control**: All routing decisions in one config file
- **Future-proof**: 26 letters = 26 potential application domains

### ✅ **Powerful**
- **tmux**: Full session/window/pane management
- **Raycast**: App launching, calculations, file search
- **Aerospace**: Advanced window management
- **All from one key**: Caps Lock becomes a "power mode" trigger

### ✅ **Consistent**
- **Same base pattern**: Caps Lock + [function key]
- **Predictable**: Easy to remember and teach others
- **Cross-application**: Uniform approach across tools

## Troubleshooting

### If tmux stops working:
1. Check Ghostty config: `~/.dotfiles/ghostty/.config/ghostty/config`
2. Verify escape sequence: `cat -v` should show `^[OP` for `Cmd+Ctrl+Alt+Shift+B`
3. Test tmux binding: `tmux list-keys | grep F1`

### If Karabiner-Elements conflicts:
1. Check accessibility permissions in System Preferences
2. Verify JSON syntax in Karabiner config
3. Test with simpler mappings first

### If Raycast doesn't detect hyper key:
1. Restart Raycast after Karabiner-Elements setup
2. Check Raycast preferences for hyper key detection
3. Manually configure if auto-detection fails

## Current Status

- ✅ **tmux + Ghostty**: Fully working and tested
- ✅ **Karabiner-Elements**: Installed, configured, and integrated with dotfiles
- ✅ **Caps Lock → Hyper Key**: Working with escape-if-alone functionality
- ✅ **Raycast**: Ready for hyper key configuration (auto-detection enabled)
- ⏳ **Aerospace**: Waiting for installation and configuration

## Next Steps

1. **Configure Raycast shortcuts** in Settings → Advanced → Hyper Key
2. **Install and configure Aerospace** window management (if needed)
3. **Test system shortcut conflicts** and disable conflicting ones
4. **Expand system** with additional applications using the established pattern
5. **Consider future applications** for remaining hyper key combinations

---

*This strategy provides a foundation for a powerful, unified keyboard-driven workflow while maintaining clear separation between different application domains.*