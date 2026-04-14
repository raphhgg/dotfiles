# First-Time macOS Setup Script - Implementation Plan

Status: implemented as `bootstrap-macos.sh`. Keep this file as design history, not as the primary entrypoint. When this file disagrees with `bootstrap-macos.sh` or `macos/README.md`, the code and README win.

## Overview
Create a comprehensive setup script `bootstrap-macos.sh` that automates setting up a fresh macOS installation with your dotfiles, similar to the reference script from linkarzu's repository.

## Script Structure

### 1. **Prerequisites & Verification**
- Display welcome message and overview
- Prompt for user's Git email address (save to temp file for persistence across runs)
- Verify Xcode Command Line Tools are NOT installed (will install fresh)
- Check if Homebrew is installed (warn if present)
- Verify repository is not already cloned

### 2. **Initial Setup**
- Install Xcode Command Line Tools: `xcode-select --install`
- Install Homebrew: Run official install script
- Add Homebrew to PATH temporarily for script execution

### 3. **Git Configuration**
- Set global Git user email (from prompt)
- Set global Git user name (prompt if not set)
- Configure Git to use SSH

### 4. **SSH Key Setup**
- Check for existing SSH keys in `~/.ssh/`
- If no keys found, prompt user to paste private key content
- Save key to `~/.ssh/id_ed25519_personal` with correct permissions (600)
- Generate public key from private key: `ssh-keygen -y -f ~/.ssh/id_ed25519_personal > ~/.ssh/id_ed25519_personal.pub`
- Display public key for user to add to GitHub (pause for confirmation)
- Test SSH connection to GitHub
- Create/update `~/.ssh/config` with github-personal host alias

### 5. **Clone Dotfiles Repository**
- Clone using SSH: `git clone git@github-personal:raaphhh/dotfiles.git ~/github/dotfiles`
- Change to dotfiles directory

### 6. **Install GNU Stow**
- Use Homebrew to install stow: `brew install stow`

### 7. **Install Homebrew Packages**
- Run: `cd ~/github/dotfiles && brew bundle install`
- This installs all formulae, casks, and MAS apps from Brewfile

### 8. **Stow All Configurations**
- Backup any existing conflicting files (`.zshrc`, `.gitconfig`, etc.)
- Run the macOS target from `justfile`
- Verify symlinks created successfully

### 9. **Apply macOS System Preferences**
- Run existing script: `~/github/dotfiles/macos/apply-preferences.sh`
- Includes Dock, Finder, keyboard, trackpad, security settings

### 10. **Configure Aerospace Window Manager**
- Verify Aerospace is installed
- Check if config is stowed correctly (`~/.config/aerospace/`)
- Start Aerospace service: `brew services start aerospace`
- Add to login items if not automatic

### 11. **Configure Karabiner-Elements**
- Verify Karabiner-Elements is installed
- Check config is stowed (`~/.config/karabiner/`)
- If TypeScript configs exist, compile them
- Create LaunchAgent for automatic startup (if needed)
- Start Karabiner-Elements: `open -a 'Karabiner-Elements'`
- Grant necessary permissions (prompt user)

### 12. **Menu Bar / Status Bar**
- Keep the native macOS menu bar visible to match the current local setup
- Verify no third-party menu bar replacement is configured in dotfiles
- Stop SketchyBar if it was previously enabled: `brew services stop sketchybar`

### 13. **Configure Tmux**
- Verify tmux is installed
- Check if TPM (Tmux Plugin Manager) is in Brewfile (it's via `brew "tmux"`)
- Clone TPM manually: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- Source tmux config
- Display instructions to install plugins: "Open tmux and press `prefix + I` to install plugins"

### 14. **Final Steps**
- Restart core services: `killall Dock Finder SystemUIServer`
- Display TouchID sudo setup instructions (manual step from apply-preferences.sh)
- List applications that need manual configuration
- Display next steps:
  - Log out and log back in
  - Re-authenticate CLI and app accounts
  - Re-grant macOS permissions
  - Restore app-specific data

### 15. **Script Features**
- Colored output for better readability (✓ green success, ⚠️  yellow warnings, ✗ red errors)
- Progress indicators for long-running tasks
- Idempotent where possible (safe to re-run)
- Error handling and validation
- Logging to `~/setup-log.txt`

## Files to Create/Modify

1. **New file**: `bootstrap-macos.sh` (main script, ~500-800 lines)
2. **Update**: `macos/README.md` (add section about `bootstrap-macos.sh`)
3. **Optional**: Create helper functions file for SSH key handling

## Key Differences from Reference Script

- Uses **Stow** instead of direct file copying/symlinking
- Uses **justfile** for automation instead of direct commands
- Single **Brewfile** instead of multiple bundle files
- **Aerospace** instead of Yabai (no SIP disable needed)
- **User-provided SSH key** instead of 1Password integration
- Leverages existing `apply-preferences.sh` instead of inline defaults commands

## Implementation Notes

### SSH Key Handling
The script will:
1. Check for existing keys first
2. If none exist, prompt user: "Please paste your SSH private key (from iCloud Keychain or Proton Pass):"
3. Read multi-line input until EOF (Ctrl-D)
4. Save securely with proper permissions
5. Derive public key automatically

### Error Handling
- Each major step should check for success
- Failed steps should be logged with clear error messages
- Script should be able to resume from where it failed
- Option to skip certain steps if already completed

### User Interaction
- Clear prompts and confirmations at critical steps
- Show progress for long operations
- Provide helpful context and next steps
- Allow user to review configurations before applying

## Reference
Based on: https://github.com/linkarzu/dotfiles-latest/blob/main/scripts/macos/mac/setup/010-firstTimeSetup.sh
