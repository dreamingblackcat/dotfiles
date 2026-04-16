# Binary & Tool Installation Analysis

**Last scanned:** 2026-04-17  
**Analysis based on:** `dot_zshrc.tmpl` PATH variables and tool initializations

---

## PATH Analysis

### Extracted from `.zshrc`

#### macOS-specific paths:
```
/opt/homebrew/Cellar/zsh/5.9/bin
/opt/homebrew/bin
/usr/local/mysql/bin
/usr/local/opt/mysql@5.7/bin
/usr/local/opt/imagemagick@6/bin
/opt/podman/bin
/usr/local/go/bin
```

#### Linux-specific paths:
```
/opt/nvim-linux64/bin
```

#### Cross-platform paths:
```
$HOME/.rvm/bin           (Ruby Version Manager)
$HOME/.cargo/bin         (Rust)
$HOME/.local/bin         (Local user binaries)
```

---

## Category 1: Version Managers & Runtime Environments

| Tool | Current Status | macOS Install | Linux Install | Notes |
|------|---|---|---|---|
| **RVM** (Ruby) | ✓ Sourced in zshrc | `curl -sSL https://get.rvm.io \| bash` | `curl -sSL https://get.rvm.io \| bash` | Ruby version management |
| **asdf** | ✓ Sourced & installed | `git clone ~/.asdf` | `git clone ~/.asdf` | Universal version manager |
| **rbenv** | ❓ Mentioned in install script | `brew install rbenv` | `apt install rbenv` | Ruby specific (alternative to RVM) |
| **pyenv** | ❓ Mentioned in install script | `brew install pyenv` | `apt install pyenv` | Python version management |
| **nvm** | ❓ Mentioned in install script | `brew install nvm` | `curl \| bash` | Node.js version manager |
| **GHCup** | ✓ Sourced in zshrc | `curl -sSL https://get-ghcup.haskell.org \| sh` | Same | Haskell toolkit |
| **Conda/Anaconda** | ✓ Sourced in zshrc | `brew install anaconda` | `wget https://repo.anaconda.com/...` | Python environments |

---

## Category 2: Language Runtimes

| Language | Installation Method | macOS | Linux | Status |
|---|---|---|---|---|
| **Ruby** | RVM/rbenv | `rvm install ruby` | `rvm install ruby` | ✓ Managed by RVM |
| **Python** | pyenv/Conda | `brew install python` | `apt install python3` | ✓ Multiple managers available |
| **Go** | Homebrew/Direct | `brew install go` | `apt install golang-go` | ✓ Path configured |
| **Node.js** | nvm/Homebrew | `brew install node` | `apt install nodejs` | ✓ nvm available |
| **Rust** | rustup | `brew install rustup` | `curl --proto https --tlsv1.2 https://sh.rustup.rs \| sh` | ✓ Cargo configured |
| **Elixir** | asdf/Homebrew | `brew install elixir` | `apt install elixir` | ❓ Referenced but not auto-installed |

---

## Category 3: Development & CLI Tools

| Tool | Current Status | Install Method | Auto-installed? | Notes |
|---|---|---|---|---|
| **Neovim** | ✓ Aliased in macOS | Homebrew / apt / tarball | ✓ (apt in Linux script) | Main editor, binary in PATH |
| **Git** | ✓ OMZ plugin | Homebrew / apt | ✓ (apt in Linux script) | Version control |
| **Tmux** | ✓ .tmux.conf present | Homebrew / apt | ✓ (apt in Linux script) | Terminal multiplexer |
| **Docker** | ✓ OMZ plugin | Homebrew / Docker Desktop | ✓ (Homebrew on macOS) | Containerization |
| **Docker Compose** | ✓ OMZ plugin | Homebrew / apt | ✓ (Homebrew on macOS) | Multi-container Docker |
| **Zellij** | ✓ Alias `z` | `brew install zellij` | ❌ **MISSING** | Terminal multiplexer (alternative to tmux) |
| **Exercism CLI** | ✓ Alias `exc` | Direct download / Homebrew | ❌ **MISSING** | Code exercise platform |
| **GitHub CLI (`gh`)** | ✓ Path configured | Homebrew / apt | ✓ (apt in Linux script) | GitHub CLI tool |
| **MySQL 5.7** | ✓ Path configured | `brew install mysql@5.7` | ❌ **MISSING** | Database server |
| **ImageMagick 6** | ✓ Path configured | `brew install imagemagick@6` | ❌ **MISSING** | Image processing |
| **Podman** | ✓ Path configured | `brew install podman` | ❌ **MISSING** | Container management (macOS) |
| **Colima** | ✓ Installed in script | `brew install colima` | ✓ (Homebrew on macOS) | Container runtime for macOS |
| **fzf** | ✓ Sourced in zshrc | Homebrew / apt | ✓ (apt in Linux script) | Fuzzy finder |
| **ripgrep (`rg`)** | ✓ OMZ plugin | Homebrew / apt | ✓ (apt in Linux script) | Fast grep alternative |
| **zoxide (`z`)** | ✓ Alias in zshrc | Homebrew / apt / curl | ✓ (curl in Linux script) | Smart directory jumper |
| **direnv** | ✓ Sourced in zshrc | Homebrew / apt | ✓ (apt in Linux script) | Environment manager |
| **exa** (now `eza`) | ✓ Alias in zshrc | Homebrew / apt | ✓ (apt in Linux script) | ls replacement |
| **Tailscale** | ✓ Aliased on macOS | `brew install --cask tailscale` | ❌ **MISSING** | VPN tool (macOS) |

---

## Category 4: Build Tools & Utilities

| Tool | Status | Install | Auto-installed? | Notes |
|---|---|---|---|---|
| **build-essential** | ✓ Path configured | `apt install build-essential` | ✓ (Linux) | C/C++ compiler toolchain |
| **Bundler** | ✓ OMZ plugin | `gem install bundler` | ⚠️ **Conditional** | Ruby dependency manager |
| **RuboCop** | ✓ Referenced in aliases | `gem install rubocop` | ❌ **MISSING** | Ruby linter/formatter |
| **Rails** | ✓ Referenced in functions | `gem install rails` | ❌ **MISSING** | Web framework |

---

## Category 5: IDE & Editor Extensions

| Tool | Status | macOS Install | Linux Install | Notes |
|---|---|---|---|---|
| **VS Code / Insiders** | ✓ Detected in zshrc | `brew install --cask visual-studio-code` | `snap install code` | Editor detection |
| **Zed Editor** | ✓ Alias `zedl` | `brew install zed` | Flatpak | Modern Rust-based editor |
| **Solargraph** | ✓ Config in zshrc | `gem install solargraph` | `gem install solargraph` | Ruby LSP for VSCode |

---

## Summary: What Needs Automation

### ✅ Already Auto-installed (in `run_once_install-packages.sh.tmpl`):
- Git, Zsh, Tmux, Curl, Wget, Unzip, Build-essential
- Neovim (apt), fzf, direnv, ripgrep, eza, gh
- Oh My Zsh + plugins (Powerlevel10k, zsh-syntax-highlighting, zsh-autosuggestions)
- asdf, zoxide
- TMux Plugin Manager

### ❌ NOT Auto-installed (needs implementation):

**High Priority (actively used in zshrc):**
1. **Zellij** — Mentioned in alias `z` (conflicts with zoxide!)
2. **RVM** — Ruby environment manager
3. **Exercism CLI** — Referenced in aliases
4. **MySQL 5.7** — Database (macOS specific)
5. **ImageMagick 6** — Image processing (macOS specific)
6. **Podman** — Container tool (macOS specific)
7. **Tailscale** — VPN (macOS specific)

**Medium Priority (conditional/work-specific):**
8. **RuboCop** — Ruby linter
9. **Solargraph** — Ruby LSP
10. **Rails** — Web framework
11. **Bundler** — Ruby package manager
12. **VS Code extensions** — Solargraph language server

**Low Priority (redundant or optional):**
- **rbenv, pyenv, nvm** — Alternative version managers (RVM/asdf sufficient)
- **Conda** — Alternative Python manager (already in zshrc)
- **GHCup** — Only needed if using Haskell

---

## Conflict Issues Found

### ⚠️ Zellij vs Zoxide naming conflict:
- **Line 69:** `alias z="zellij"` 
- **Line 80:** `alias zo="zoxide"`
- **Zellij is NOT installed**, so `z` alias is broken
- **Recommendation:** Install zellij OR change alias to something else (e.g., `alias zj="zellij"`)

### ⚠️ MySQL path mismatch:
- **Lines 152-154:** Configure MySQL 5.7 paths
- **Not installed by default** — needs explicit Homebrew install on macOS
- **Path won't exist if MySQL isn't installed** — could cause issues

### ⚠️ Neovim binary path mismatch (macOS):
- **Line 174:** `alias nvim="$HOME/bin/nvim-macos-arm64/bin/nvim"`
- **This is a custom binary location** — not auto-installed
- **Conflicts with system nvim from Homebrew**

---

## Recommended Automation Strategy

### Phase 1: Fix Conflicts (Immediate)
```bash
# In dot_zshrc.tmpl, fix:
1. Change: alias z="zellij"  →  alias zj="zellij"  (if installing zellij)
   OR Remove zellij reference entirely if not needed
   
2. Document MySQL 5.7 installation as optional:
   export PATH="$PATH:/usr/local/opt/mysql@5.7/bin"  # Only if installed
```

### Phase 2: Create Optional Installation Scripts
Create separate `run_once_*` scripts for:
```
- run_once_install-zellij.sh.tmpl       (if user wants it)
- run_once_install-ruby-tools.sh.tmpl   (RVM + RuboCop + Solargraph)
- run_once_install-macos-optional.sh.tmpl (MySQL, ImageMagick, Podman, Tailscale)
- run_once_install-exercism.sh          (Exercism CLI)
```

### Phase 3: Interactive Setup
For tools with configuration needs:
- Add `.chezmoi.toml.tmpl` prompts:
  - `install_ruby_tools` (default: false)
  - `install_mysql` (default: false, macOS only)
  - `install_zellij` (default: false)
  - `install_imagemagick` (default: false, macOS only)

---

## Questions for User Review

1. **Zellij vs Zoxide:** Do you want Zellij installed? Or should `z` alias remain for zoxide?
2. **Ruby development:** Should RVM, RuboCop, and Solargraph be auto-installed?
3. **macOS optional tools:** Which of these do you want auto-installed?
   - MySQL 5.7
   - ImageMagick 6
   - Podman
   - Tailscale
4. **Custom neovim binary:** Do you still use the `$HOME/bin/nvim-macos-arm64` binary, or should we use system nvim from Homebrew?
5. **Exercism:** Should exercism CLI be auto-installed?

