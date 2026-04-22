# macOS Setup Notes

This directory contains the macOS bootstrap, preferences, and migration notes for my current Mac setup.

## What Lives Here

- **`apply-preferences.sh`** - Main script to apply all system preferences
- **`../bootstrap-macos.sh`** - Fresh Mac bootstrap entrypoint
- **`dock-persistent-apps.plist`** - Dock layout source
- **`MIGRATION_CHECKLIST.md`** - Manual data and account transfer checklist

## Start Here

Bootstrap a fresh Mac from this repo:

```bash
cd "$HOME/dotfiles"
./bootstrap-macos.sh
```

Apply only system preferences:

```bash
cd "$HOME/dotfiles"
./macos/apply-preferences.sh
```

Then restart the affected services:

```bash
killall Dock Finder SystemUIServer
```

## What The Scripts Touch

### 🖥️ Dock
- Auto-hide enabled
- Magnification enabled (size: 71)
- Tile size: 48
- Scale minimization effect
- Hide recent applications
- Fast Mission Control animations (0.1s)
- Hot corners configured:
  - Top-left: custom local value `1`
  - Top-right: Desktop
  - Bottom-left: Application Windows
  - Bottom-right: custom local value `1`
- Persistent apps are defined in `dock-persistent-apps.plist`

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
- Menu bar remains visible
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

For the broader machine migration checklist, see `MIGRATION_CHECKLIST.md`.

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

## Customizing The Dock

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

## Running Only Part Of The Setup

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
- The Dock and hot corner values in this directory reflect the current local Mac, not generic macOS defaults
- No external dependencies required - uses only macOS built-in tools
