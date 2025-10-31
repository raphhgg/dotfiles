#!/bin/bash

# macOS Preferences Setup Script
# Extracted from nix-darwin configuration
# This script applies system preferences using macOS defaults commands

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🍎 Applying macOS system preferences..."
echo "⚠️  Some changes require logging out or restarting to take effect"
echo ""

# ============================================================================
# DOCK PREFERENCES
# ============================================================================
echo "📦 Configuring Dock..."

# Dock behavior
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string "bottom"

# Magnification settings
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 71

# Icon and animation settings
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock mineffect -string "scale"

# Application and document management
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock showhidden -bool false

# Dock content management
defaults write com.apple.dock static-only -bool false

# Performance
defaults write com.apple.dock launchanim -bool true
defaults write com.apple.dock expose-animation-duration -float 0.1

# Hot Corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
defaults write com.apple.dock wvous-tl-corner -int 2    # Top-left: Mission Control
defaults write com.apple.dock wvous-tr-corner -int 4    # Top-right: Desktop
defaults write com.apple.dock wvous-bl-corner -int 3    # Bottom-left: Application Windows
defaults write com.apple.dock wvous-br-corner -int 4    # Bottom-right: Desktop

# Persistent applications - load from external plist file
if [ -f "$SCRIPT_DIR/dock-persistent-apps.plist" ]; then
    defaults write com.apple.dock persistent-apps -array
    defaults write com.apple.dock persistent-apps -array-add "$(cat "$SCRIPT_DIR/dock-persistent-apps.plist" | plutil -convert xml1 -o - - | sed -n '/<array>/,/<\/array>/p' | sed '1d;$d')"
    # Alternative simpler approach:
    # plutil -replace persistent-apps -xml "$(cat "$SCRIPT_DIR/dock-persistent-apps.plist")" ~/Library/Preferences/com.apple.dock.plist
else
    echo "⚠️  Warning: dock-persistent-apps.plist not found, skipping Dock apps configuration"
fi

# ============================================================================
# FINDER PREFERENCES
# ============================================================================
echo "🔍 Configuring Finder..."

# File visibility and extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true

# Desktop and interface
defaults write com.apple.finder CreateDesktop -bool true
defaults write com.apple.finder QuitMenuItem -bool true

# View options
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Search behavior
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Window behavior
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# New window behavior
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Desktop items
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Additional view settings
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Desktop view settings
defaults write com.apple.finder DesktopViewSettings -dict \
    IconViewSettings -dict-add \
        arrangeBy -string "grid" \
        backgroundColorBlue -float 1.0 \
        backgroundColorGreen -float 1.0 \
        backgroundColorRed -float 1.0 \
        backgroundType -int 0 \
        gridOffsetX -int 0 \
        gridOffsetY -int 0 \
        gridSpacing -int 54 \
        iconSize -int 64 \
        labelOnBottom -bool true \
        showIconPreview -bool true \
        showItemInfo -bool false \
        textSize -int 12

# Default icon view settings
defaults write com.apple.finder FK_DefaultIconViewSettings -dict \
    arrangeBy -string "grid" \
    backgroundType -int 0 \
    gridSpacing -int 54 \
    iconSize -int 64 \
    showIconPreview -bool true

# ============================================================================
# INTERFACE & APPEARANCE PREFERENCES
# ============================================================================
echo "🎨 Configuring Interface & Appearance..."

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Mouse and navigation behavior
defaults write NSGlobalDomain AppleEnableMouseSwipeNavigateWithScrolls -bool true
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true

# Locale and internationalization
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -int 1
defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"

# Expanded save/open panels
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelFileLastListModeForOpenModeKey -int 1
defaults write NSGlobalDomain NSNavPanelFileLastListModeForSaveModeKey -int 1

# Menu bar auto-hide
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool false

# Title bar double-click behavior
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# System locale and languages
defaults write NSGlobalDomain AppleLocale -string "en_001@rg=bezzzz"
defaults write NSGlobalDomain AppleLanguages -array "en" "fr"

# Trackpad Force Click
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

# Control Center configuration
defaults write com.apple.controlcenter BatteryShowPercentage -bool false

# ============================================================================
# KEYBOARD & INPUT PREFERENCES
# ============================================================================
echo "⌨️  Configuring Keyboard & Input..."

# Key repeat settings
defaults write NSGlobalDomain InitialKeyRepeat -int 25
defaults write NSGlobalDomain KeyRepeat -int 2

# Text input behavior
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

# Scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# ============================================================================
# TRACKPAD PREFERENCES
# ============================================================================
echo "🖱️  Configuring Trackpad..."

# Clicking behavior
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false

# Drag behavior
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool false

# Right-click behavior
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Three-finger tap gesture
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 0

# Click pressure settings
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 1
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1

# Scrolling behavior
defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadHorizScroll -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -int 1

# Corner behavior
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 1

# Gestures
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2

# Additional settings
defaults write com.apple.AppleMultitouchTrackpad TrackpadHandResting -int 1
defaults write com.apple.AppleMultitouchTrackpad USBMouseStopsTrackpad -int 0

# ============================================================================
# DISPLAY & VISUAL PREFERENCES
# ============================================================================
echo "🖥️  Configuring Display & Visual..."

# Screensaver settings
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 10

# Screen capture location
mkdir -p ~/Documents/screenshots
defaults write com.apple.screencapture location -string "~/Documents/screenshots"

# Night Shift
defaults write com.apple.CoreBrightness AutoBlueReductionEnabled -bool true

# Keyboard backlight (for supported hardware)
defaults write com.apple.BezelServices KeyboardBacklightABEnabled -bool true
defaults write com.apple.BezelServices KeyboardBacklightIdleDimTime -int 30

# ============================================================================
# SECURITY PREFERENCES
# ============================================================================
echo "🔒 Configuring Security..."

# Disable Gatekeeper quarantine for downloaded apps
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo ""
echo "✅ System preferences applied successfully!"
echo ""
echo "⚠️  IMPORTANT NEXT STEPS:"
echo "1. Configure TouchID for sudo (requires manual setup):"
echo "   Run: sudo sed -i '' '2i\\
auth       sufficient     pam_tid.so
' /etc/pam.d/sudo_local"
echo ""
echo "2. Restart affected services:"
echo "   killall Dock Finder SystemUIServer"
echo ""
echo "3. Log out and log back in (or restart) for all changes to take effect"
echo ""
