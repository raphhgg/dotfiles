# GitHub Actions Configuration

This directory contains GitHub Actions workflows for automating dotfiles synchronization.

## Workflow: Sync to NAS Server

**File**: `workflows/sync-to-server.yml`

Automatically syncs dotfiles to the ds423plus NAS server whenever changes are pushed to the `main` branch.

### Required GitHub Secrets

To enable this workflow, configure the following secrets in your GitHub repository settings:

1. Go to: `Settings` → `Secrets and variables` → `Actions` → `New repository secret`

2. Add these three secrets:

| Secret Name | Description | Value |
|-------------|-------------|-------|
| `SERVER_HOST` | NAS hostname or IP address | `ds423plus` |
| `SERVER_USER` | SSH username on NAS | `raphh` |
| `SERVER_SSH_KEY` | Private SSH key for authentication | See below |

### SSH Key Setup

A dedicated SSH key has been created specifically for this GitHub Actions workflow:

**Key files:**
- Private key: `~/.ssh/github_actions_dotfiles` (for GitHub Secrets)
- Public key: `~/.ssh/github_actions_dotfiles.pub` (on NAS)
- SSH config: `ssh/.ssh/config` (host: `ds423plus-github-actions-dotfiles-sync`)

**Security features:**
- ✅ Dedicated key (isolated from personal SSH keys)
- ✅ Command restriction: Can only run `cd ~/dotfiles && git pull origin main`
- ✅ Disabled port forwarding, X11 forwarding, and agent forwarding
- ✅ Easy revocation without affecting personal access

**To get the private key for GitHub Secrets:**
```bash
cat ~/.ssh/github_actions_dotfiles
```

Copy the entire output (including `BEGIN` and `END` lines) and paste into the `SERVER_SSH_KEY` secret in GitHub.

### How It Works

1. **Push** changes to `main` branch on GitHub
2. **GitHub Actions** workflow triggers automatically
3. **Runner** connects to NAS via SSH using stored credentials
4. **Executes** restricted command: `cd ~/dotfiles && git pull origin main`
5. **Reports** status in GitHub Actions tab

### Security Model

The SSH key is restricted at the `authorized_keys` level on the NAS:

```bash
command="cd ~/dotfiles && git pull origin main",no-port-forwarding,no-X11-forwarding,no-agent-forwarding ssh-ed25519 AAAA... github_actions_dotfiles
```

This means even if GitHub's infrastructure is compromised, the key can **only**:
- Connect to the NAS
- Navigate to `~/dotfiles`
- Execute `git pull origin main`

Nothing else is possible with this key.

### Monitoring

- View sync status: Repository → `Actions` tab
- Each push creates a new workflow run
- Failed syncs will show red ❌ status
- Successful syncs show green ✅ status

### Troubleshooting

**Workflow fails with "Permission denied"**
- Verify `SERVER_SSH_KEY` contains the complete private key (including headers)
- Check that the public key is in `~/.ssh/authorized_keys` on NAS
- Verify key permissions on NAS: `chmod 600 ~/.ssh/authorized_keys`

**Workflow fails with "Connection timeout"**
- Verify `SERVER_HOST` is correct (`ds423plus` or IP address)
- Check if NAS is reachable from external networks
- Verify firewall settings on NAS allow SSH connections

**Git pull fails**
- Ensure `~/dotfiles` directory exists on NAS
- Verify git remote is configured correctly: `git remote -v`
- Check that the NAS user has permission to write to the directory

**Command restriction issues**
- Verify the authorized_keys entry has the correct command restriction
- Check `/var/log/auth.log` on NAS for SSH connection details

### Key Rotation

To rotate the SSH key:

1. Generate new key: `ssh-keygen -t ed25519 -C "github_actions_dotfiles" -f ~/.ssh/github_actions_dotfiles_new -N ""`
2. Copy to NAS: `ssh-copy-id -i ~/.ssh/github_actions_dotfiles_new.pub raphh@ds423plus`
3. Add command restriction on NAS (see Security Model section)
4. Update GitHub secret `SERVER_SSH_KEY` with new private key
5. Test workflow by pushing a commit
6. Remove old key from NAS: `ssh ds423plus "sed -i.bak '/github_actions_dotfiles$/d' ~/.ssh/authorized_keys"`
7. Remove old key locally: `rm ~/.ssh/github_actions_dotfiles{,.pub}`
8. Rename new key: `mv ~/.ssh/github_actions_dotfiles_new ~/.ssh/github_actions_dotfiles`

### Testing Locally

Test the SSH connection and command restriction:

```bash
# Test connection with the GitHub Actions key
ssh -i ~/.ssh/github_actions_dotfiles raphh@ds423plus

# This should automatically execute: cd ~/dotfiles && git pull origin main
# You won't get an interactive shell due to the command restriction
```

### Future Enhancements

Potential additions to consider:

- **Selective restow**: Only restow changed packages after sync
- **Config reload**: Auto-reload tmux/zsh configurations
- **Notifications**: Send alerts on sync failures (Slack, Discord, email)
- **Rollback mechanism**: Keep backup before pulling changes
- **Multiple servers**: Sync to multiple machines in parallel
- **Dry-run mode**: Preview changes before applying
