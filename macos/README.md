# macOS System Preferences

This directory contains macOS system preferences extracted from the nix-darwin configuration, converted to portable shell scripts and plist files.

## Files

- **`apply-preferences.sh`** - Main script to apply all system preferences
- **`dock-persistent-apps.plist`** - Dock persistent applications list (easy to edit!)

## Quick Start

Apply all preferences at once:

```bash
~/dotfiles/macos/apply-preferences.sh
```

Then restart services:

```bash
killall Dock Finder SystemUIServer
```

## What's Configured

### 🖥️ Dock
- Auto-hide enabled
- Magnification enabled (size: 71)
- Tile size: 48
- Scale minimization effect
- Hide recent applications
- Fast Mission Control animations (0.1s)
- Hot corners configured:
  - Top-left: Mission Control
  - Top-right: Desktop
  - Bottom-left: Application Windows
  - Bottom-right: Desktop
- Persistent apps: Zen, Obsidian, Fantastical, Ghostty, Zed, Cursor, Xcode, Discord, Slack, Messages

### 📁 Finder
- Show all file extensions
- Show hidden files
- Show path bar
- List view as default
- Search current folder by default
- No extension change warnings
- New windows open to Home directory
- Show external drives and servers on desktop
- Sort folders first

### 🎨 Interface & Appearance
- Dark mode enabled
- Auto-hide menu bar
- Metric system (Celsius, Centimeters)
- Expanded save/open dialogs
- Languages: English, French
- Mouse swipe navigation enabled

### ⌨️ Keyboard & Input
- Fast key repeat (InitialKeyRepeat: 25, KeyRepeat: 2)
- Auto-capitalization enabled
- Smart dashes and quotes enabled
- Spell check enabled
- Natural scroll direction disabled

### 🖱️ Trackpad
- Tap-to-click: disabled
- Right-click: enabled
- All gestures enabled (pinch, rotate, swipe, etc.)
- Palm rejection enabled
- Trackpad works with mouse connected

### 🔒 Security
- TouchID for sudo (requires manual setup)
- Gatekeeper quarantine disabled
- Screen saver password required (10s delay)

### 📸 Display
- Screenshots saved to: `~/Documents/screenshots`
- Night Shift enabled
- Keyboard backlight auto-adjust (if supported)

## Manual Steps Required

### TouchID for sudo

After running the script, enable TouchID for sudo:

```bash
sudo sed -i '' '2i\
auth       sufficient     pam_tid.so
' /etc/pam.d/sudo_local
```

Or manually edit `/etc/pam.d/sudo_local` and add this line after the first comment:
```
auth       sufficient     pam_tid.so
```

## Customizing Dock Apps

The Dock persistent applications are stored in `dock-persistent-apps.plist`. To modify:

1. Open the file in any text editor
2. Each app is a `<dict>` block - copy/paste to add more
3. Change the `<string>/Applications/AppName.app</string>` path
4. Run the script again to apply changes

Example app entry:
```xml
<dict>
    <key>tile-data</key>
    <dict>
        <key>file-data</key>
        <dict>
            <key>_CFURLString</key>
            <string>/Applications/YourApp.app</string>
            <key>_CFURLStringType</key>
            <integer>0</integer>
        </dict>
    </dict>
</dict>
```

## Selective Application

If you want to apply only specific settings, you can copy individual sections from the script and run them manually.

For example, to only configure the Dock:

```bash
# Dock behavior
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 48
# ... etc

killall Dock
```

## Reverting Changes

To revert any setting to macOS defaults, delete the preference key:

```bash
defaults delete com.apple.dock autohide
killall Dock
```

Or reset entire preference domains:

```bash
defaults delete com.apple.dock
killall Dock
```

## Notes

- Some settings require logout/restart to take full effect
- The script is idempotent - safe to run multiple times
- Based on nix-darwin configuration from `~/nix-darwin-config/darwin/preferences/`
- No external dependencies required - uses only macOS built-in tools
