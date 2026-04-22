# New Mac Migration Checklist

## Before Wiping the Old Mac

- Verify the latest dotfiles changes are committed and pushed.
- Export or back up SSH keys from `~/.ssh/`.
- Confirm GitHub CLI auth works: `gh auth status`.
- Export password manager recovery codes and 2FA seeds.
- Back up local-only files: `.env*`, `.secrets`, certificates, provisioning profiles, `.npmrc`, `.netrc`, cloud credentials.
- Back up `~/Projects` and any other active work directories.
- Export browser profiles, bookmarks, and extensions if they are not cloud-synced.
- Back up app data that Homebrew will not recreate: Obsidian vaults, local databases, Docker/Colima state, Postman data, Proxyman data, Raycast snippets/settings if not synced.

## New Mac Bootstrap

- Clone the repo to a stable path: `$HOME/dotfiles`.
- Run `./bootstrap-macos.sh`.
- Sign in to the App Store, then rerun `brew bundle install` if MAS apps were skipped.
- Restore SSH keys before switching Git remotes to SSH-only workflows.
- Start AeroSpace and Karabiner-Elements and grant their permissions.
- Re-authenticate tools and apps that keep tokens in Keychain or local secure storage.

## Manual Restore Items

- `~/.ssh/config.local` and any host-specific SSH keys.
- Any tool-specific auth/session state you actually want to keep.
- Browser profiles.
- Obsidian vaults.
- Mail, Calendar, Contacts, and Messages accounts.
- Tailscale and VPN client login state.
- Recovery codes and hardware security key registrations.

## Validation

- `just stow-macos`
- `brew bundle check --file Brewfile`
- `test -L ~/.zshrc && test -L ~/.gitconfig`
- `test -f ~/.config/zed/settings.json`
- `test -d ~/.config`
