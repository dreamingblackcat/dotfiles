# Tool Management & Version Manager Setup

**Last updated:** 2026-04-17  
**Changes:** Refactored tool installation and version manager configuration

---

## Overview

This guide explains how tools and version managers are now organized and installed in your dotfiles setup.

---

## Key Changes Made

### 1. **mise is now the primary version manager**

- **Replaces:** asdf (previous default)
- **What it does:** Manages versions of Ruby, Python, Node, Go, Elixir, etc.
- **Install:** Automatic (included in `run_once_install-packages.sh.tmpl`)
- **Initialization:** Automatic in `~/.zshrc` via `eval "$(mise activate zsh)"`

**Installation happens first time you run:**
```bash
chezmoi init --apply github.com/dreamingblackcat/dotfiles
```

**Using mise:**
```bash
# Install a language runtime
mise use ruby@3.2.0
mise use python@3.11
mise use node@20

# List available versions
mise versions ruby
```

---

### 2. **Zellij is now auto-installed and aliased to `z`**

- **What it is:** Modern terminal multiplexer (like tmux)
- **Alias:** `z` → `zellij`
- **Install method:**
  - **macOS:** Homebrew (`brew install zellij`)
  - **Linux/Arch:** Installed via Rust/cargo
  - Automatic in `run_once_install-packages.sh.tmpl`

**Note:** Zellij will be installed on first chezmoi apply. Cargo/Rust installation takes ~5-10 minutes on first run.

---

### 3. **Zoxide is now integrated as `cd` replacement**

- **What it does:** Smart directory jumping (remembers frequently visited dirs)
- **Original `cd` preserved:** Available as `cdo` if you need standard cd behavior
- **Aliases:**
  - `cd` → `zoxide` (smart jump)
  - `cdo` → original `cd` (fallback)
  - `cdi` → `zoxide` interactive selection

**Usage:**
```bash
cd ~                    # Use smart jump
cd ~/projects/myapp     # Zoxide remembers this path
cd myapp                # Zoxide jumps to ~/projects/myapp automatically
cdo /tmp                # Use original cd if needed
```

---

### 4. **Tailscale is auto-installed**

- **What it is:** VPN service for secure networking
- **Install:** Automatic on all platforms (macOS, Linux)
- **First use:** Run `tailscale up` to authenticate
- **Install location:**
  - **macOS:** Homebrew → `/opt/homebrew/bin/tailscale`
  - **Linux:** System install

---

### 5. **Docker runtime is now conditional**

**Choice during setup:**
When you run `chezmoi init`, you'll be prompted (on macOS/Linux):

```
Docker engine (macOS/Linux)?
  - none (no Docker)
  - colima (lightweight on macOS)
  - podman (OCI-compliant, independent)
  - docker-desktop (full Docker Desktop)
```

**Install method:** Separate script `run_once_install-docker-runtime.sh.tmpl` handles installation based on your choice.

**Set via environment variable:**
```bash
export CHEZMOI_DOCKER_ENGINE="colima"
chezmoi init --apply github.com/dreamingblackcat/dotfiles
```

**Configuration:** Automatically configures `DOCKER_HOST` based on choice in `~/.zshrc`.

---

### 6. **Optional Ruby version managers**

**Extracted to:** `~/.ruby_managers.sh` (included but COMMENTED OUT in zshrc)

This file contains initialization code for:
- **RVM** (Ruby Version Manager)
- **rbenv** (simpler Ruby manager)
- **pyenv** (Python alternative)
- **nvm** (Node.js alternative)

**Why commented out?** mise is the primary manager. If you prefer one of these alternatives:

1. **Uncomment** the specific manager in `~/.ruby_managers.sh`
2. **Reload** your shell: `source ~/.zshrc`
3. **Initialize** the tool: e.g., `rvm install ruby-3.2.0`

**To enable RVM, for example:**

Edit `~/.ruby_managers.sh`:
```bash
# ── RVM (Ruby Version Manager) ────────────────────────────────────────────────
# Uncomment to use RVM instead of mise
export PATH="$PATH:$HOME/.rvm/bin"
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
```

Then in `~/.zshrc`, uncomment:
```bash
[ -f "$HOME/.ruby_managers.sh" ] && source "$HOME/.ruby_managers.sh"
```

Reload: `reload!`

---

## Installation Flow

### First Time Setup

```bash
# Clone and initialize
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply \
  github.com/dreamingblackcat/dotfiles --branch chezmoi-migration

# You'll be prompted for:
# 1. Full name
# 2. Email address
# 3. Work machine? (y/n)
# 4. Docker engine? (macOS/Linux only)
```

### What Gets Installed Automatically

| Component | Install Method | Time |
|---|---|---|
| Git, Zsh, Tmux, Neovim | Homebrew / apt | ~2-3 min |
| fzf, ripgrep, eza, gh | Homebrew / apt | ~1 min |
| mise | curl install script | ~2 min |
| zellij | cargo build (Linux) or Homebrew (macOS) | ~5-10 min |
| zoxide, direnv | curl / apt | ~1 min |
| Oh My Zsh + plugins | Git clone | ~1 min |
| Powerlevel10k theme | Git clone | ~30 sec |
| Tmux Plugin Manager | Git clone | ~30 sec |
| Docker runtime | Based on choice | ~2-5 min |
| Tailscale | Homebrew / apt | ~1 min |

**Total first-run time:** ~20-30 minutes (mostly zellij compilation on Linux)

---

## Environment Variables for Automation

You can pre-set answers to avoid prompts:

```bash
# Full non-interactive setup
export CHEZMOI_NAME="Your Name"
export CHEZMOI_EMAIL="your.email@example.com"
export CHEZMOI_WORK="false"
export CHEZMOI_DOCKER_ENGINE="colima"

chezmoi init --apply github.com/dreamingblackcat/dotfiles
```

---

## Verifying Installation

After setup completes, verify everything installed:

```bash
# Check mise
mise --version
mise plugins list

# Check zellij
zellij --version
z                # Should start zellij

# Check zoxide
zoxide query -i  # Interactive jump

# Check tools
nvim --version
tmux -V
fzf --version

# Check Tailscale
tailscale status
```

---

## Troubleshooting

### "mise: command not found"
- Ensure `~/.cargo/bin` is in PATH: `echo $PATH`
- Reload shell: `exec zsh`

### Zellij compilation stalls (Linux)
- Cargo build can take 10+ minutes. Monitor disk space.
- On very slow systems, consider skipping zellij and using tmux instead.

### Docker connection refused
- Ensure your chosen Docker runtime is running:
  - **Colima:** `colima start`
  - **Podman:** `podman machine start`
  - **Docker Desktop:** Launch app manually

### Tailscale won't authenticate
- Run: `tailscale up`
- Open the browser link to authenticate
- Verify: `tailscale status`

---

## Next Steps

1. **Test mise:** `mise use ruby@3.2 && ruby --version`
2. **Configure zellij:** Create `~/.config/zellij/layout.kdl` for custom keybindings
3. **Enable optional managers:** Uncomment in `~/.ruby_managers.sh` if needed
4. **Check work config:** If you answered "work machine" as true, work tools are available

---

## File Structure

```
~/.zshrc                      # Main shell config (sourced automatically)
~/.ruby_managers.sh           # Optional Ruby managers (commented out by default)
~/.local/share/chezmoi/       # Chezmoi source files
  ├── .chezmoi.toml           # Your configuration
  ├── dot_zshrc.tmpl          # Template for ~/.zshrc
  └── run_once_install-packages.sh.tmpl
  └── run_once_install-docker-runtime.sh.tmpl
```

---

## Updating Tools

After setup, update tools with their own commands:

```bash
# mise
mise self-update

# Homebrew
brew upgrade

# Linux apt
sudo apt update && sudo apt upgrade

# Zellij
z --version  # Check version
cargo install zellij --force  # Update via cargo
```

