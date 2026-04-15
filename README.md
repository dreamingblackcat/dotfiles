# dotfiles — managed by chezmoi

Personal dotfiles for **dreamingblackcat**, managed with [chezmoi](https://www.chezmoi.io/).

Supports macOS (Apple Silicon & Intel) and Linux (Debian/Ubuntu/Arch).

---

## Quick Start (One-Command Bootstrap)

### macOS

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dreamingblackcat
```

### Linux

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dreamingblackcat
```

> chezmoi will prompt you for your name, email address, and whether this is a work machine. These values are stored in `~/.config/chezmoi/chezmoi.toml` and used to personalise configs like `~/.gitconfig`.

---

## What Gets Installed & Configured

### Shell
| File | Destination | Notes |
|------|-------------|-------|
| `dot_zshrc.tmpl` | `~/.zshrc` | Oh My Zsh + Powerlevel10k, OS-specific paths |
| `dot_p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k prompt config |
| `dot_workcloud_config.sh.tmpl` | `~/.workcloud_config.sh` | Work aliases (only on work machines) |
| `dot_conda_shell_init.sh` | `~/.conda_shell_init.sh` | Conda/Anaconda initialisation |

### Git
| File | Destination | Notes |
|------|-------------|-------|
| `dot_gitconfig.tmpl` | `~/.gitconfig` | Git identity templated from your answers |
| `dot_githelpers` | `~/.githelpers` | Pretty log / branch / head helpers |

### Editors
| File | Destination | Notes |
|------|-------------|-------|
| `dot_vimrc` | `~/.vimrc` | Vim + Vundle plugins |
| `dot_spacemacs` | `~/.spacemacs` | Spacemacs config |
| `dot_config/nvim/` | `~/.config/nvim/` | LazyVim-based Neovim setup |

### Terminal Multiplexer
| File | Destination | Notes |
|------|-------------|-------|
| `dot_tmux.conf` | `~/.tmux.conf` | tmux with TPM plugins (resurrect, continuum) |

### Language Tooling
| File | Destination | Notes |
|------|-------------|-------|
| `dot_irbrc` | `~/.irbrc` | Ruby IRB history + Rails console prompt |
| `dot_asdfrc` | `~/.asdfrc` | asdf legacy version file support |

### SSH
| File | Destination | Notes |
|------|-------------|-------|
| `private_dot_ssh/config.tmpl` | `~/.ssh/config` | SSH client config, 600 perms, OS-aware |

### Packages & Plugins (run-once scripts)
| Script | When it runs |
|--------|-------------|
| `run_once_install-chezmoi.sh` | Once, if chezmoi is not installed |
| `run_once_install-packages.sh.tmpl` | Once per content change — installs Homebrew (macOS) or apt/pacman (Linux) packages, Oh My Zsh, Powerlevel10k, zsh plugins, and TPM |

---

## Repository Structure

```
dotfiles/                         ← chezmoi source directory
├── .chezmoi.toml.tmpl            ← machine config (prompts for name/email/work)
├── .chezmoiignore                ← paths chezmoi should not manage
├── .chezmoitemplates/            ← shared template fragments
│   └── os-check                 ← OS/arch detection comment fragment
│
├── run_once_install-chezmoi.sh   ← bootstrap: installs chezmoi itself
├── run_once_install-packages.sh.tmpl  ← installs all packages & plugins
│
├── dot_zshrc.tmpl                → ~/.zshrc
├── dot_p10k.zsh                  → ~/.p10k.zsh
├── dot_gitconfig.tmpl            → ~/.gitconfig
├── dot_githelpers                → ~/.githelpers
├── dot_tmux.conf                 → ~/.tmux.conf
├── dot_vimrc                     → ~/.vimrc
├── dot_spacemacs                 → ~/.spacemacs
├── dot_irbrc                     → ~/.irbrc
├── dot_asdfrc                    → ~/.asdfrc
├── dot_conda_shell_init.sh       → ~/.conda_shell_init.sh
├── dot_workcloud_config.sh.tmpl  → ~/.workcloud_config.sh (work only)
│
├── private_dot_ssh/              → ~/.ssh/ (chmod 700)
│   └── config.tmpl               → ~/.ssh/config (chmod 600)
│
└── dot_config/                   → ~/.config/
    └── nvim/                     → ~/.config/nvim/
        ├── init.lua
        ├── lazyvim.json
        ├── stylua.toml
        ├── dot_neoconf.json      → ~/.config/nvim/.neoconf.json
        ├── lazy-lock.json
        └── lua/
            ├── config/
            │   ├── autocmds.lua
            │   ├── keymaps.lua
            │   ├── lazy.lua
            │   └── options.lua
            └── plugins/
                ├── mason.lua
                ├── neo-tree.lua
                └── nvim-treesitter.lua
```

---

## How chezmoi File Naming Works

chezmoi uses filename prefixes to determine where and how files are deployed:

| Prefix | Meaning |
|--------|---------|
| `dot_` | Adds a leading `.` — e.g. `dot_zshrc` → `~/.zshrc` |
| `private_` | Sets permissions to 600 (files) / 700 (directories) |
| `executable_` | Sets the executable bit (`+x`) |
| `.tmpl` suffix | File is a Go template, rendered before writing |
| `run_once_` prefix | Shell script run once (or when content changes) |
| `run_onchange_` prefix | Shell script run whenever file content changes |

---

## Template System

Templates are Go text/template files (`.tmpl` extension) that chezmoi renders before writing to your home directory. Available variables:

```
{{ .chezmoi.os }}        # "darwin" or "linux"
{{ .chezmoi.arch }}      # "amd64" or "arm64"
{{ .chezmoi.hostname }}  # your machine's hostname
{{ .chezmoi.username }}  # your OS username
{{ .name }}              # your full name (from chezmoi.toml)
{{ .email }}             # your email (from chezmoi.toml)
{{ .work }}              # true/false (from chezmoi.toml)
```

### Conditional example

```
{{- if eq .chezmoi.os "darwin" }}
# macOS-only config
{{- else if eq .chezmoi.os "linux" }}
# Linux-only config
{{- end }}
```

The `-` after `{{` or before `}}` trims surrounding whitespace/newlines, keeping rendered output clean.

### Where templates are used

- **`dot_zshrc.tmpl`** — OS-specific plugin lists, PATH entries, tool aliases, and macOS-only config (iTerm2, Homebrew, MySQL, ImageMagick, Colima).
- **`dot_gitconfig.tmpl`** — User `name` and `email` filled from `chezmoi.toml`.
- **`dot_workcloud_config.sh.tmpl`** — Entire file only rendered when `work = true`.
- **`private_dot_ssh/config.tmpl`** — `UseKeychain yes` added only on macOS.
- **`run_once_install-packages.sh.tmpl`** — Separate install paths for macOS (Homebrew) and Linux (apt/pacman).
- **`.chezmoi.toml.tmpl`** — Asks for name, email, and work flag on first init.

---

## Daily Usage

### Apply changes from the repo

```sh
chezmoi update
```

This pulls the latest commits from GitHub and applies them.

### Edit a managed file

```sh
chezmoi edit ~/.zshrc
# Edit in your $EDITOR — chezmoi opens the source file, not the target
chezmoi apply
```

### Add a new dotfile

```sh
chezmoi add ~/.mynewconfig
# Then commit it
cd $(chezmoi source-path) && git add dot_mynewconfig && git commit -m "add mynewconfig"
git push
```

### Add a new dotfile with templating

```sh
chezmoi add ~/.mynewconfig
# Rename the source file to add .tmpl extension
mv $(chezmoi source-path)/dot_mynewconfig $(chezmoi source-path)/dot_mynewconfig.tmpl
# Edit with Go template syntax
chezmoi edit ~/.mynewconfig
chezmoi apply
```

### See what chezmoi would change before applying

```sh
chezmoi diff
```

### Check status of managed files

```sh
chezmoi status
```

### Re-run the package install script (e.g. after adding a new package)

Edit `run_once_install-packages.sh.tmpl` (any content change triggers a re-run):

```sh
chezmoi edit $(chezmoi source-path)/run_once_install-packages.sh.tmpl
chezmoi apply
```

---

## Setting Up a New Machine

1. **Install chezmoi** (or let the bootstrap do it):

   ```sh
   sh -c "$(curl -fsLS get.chezmoi.io)"
   ```

2. **Initialise and apply** in one step:

   ```sh
   chezmoi init --apply dreamingblackcat
   ```

   You'll be prompted for:
   - Your full name
   - Your email address
   - Whether this is a work machine

3. **Done.** chezmoi will:
   - Write all dotfiles to `~`
   - Run `run_once_install-packages.sh.tmpl` to install packages and plugins
   - Set correct permissions on `~/.ssh/config`

---

## Syncing Between Machines

On an existing machine, pull and apply the latest changes:

```sh
chezmoi update
```

Or manually:

```sh
cd $(chezmoi source-path) && git pull
chezmoi apply
```

---

## Secrets & Sensitive Values

Do **not** commit secrets (API tokens, passwords) directly into dotfiles.

Options:
- Use chezmoi's [secret manager integrations](https://www.chezmoi.io/user-guide/secrets/) (1Password, Bitwarden, pass, etc.)
- Use environment variables sourced from a file **not** managed by chezmoi
- Use chezmoi's `keepassxc` or `vault` support

Example with a secret from `pass`:

```
export INFLUX_TOKEN={{ passRaw "influxdb/token" }}
```

---

## Neovim Setup

The Neovim config at `dot_config/nvim/` uses [LazyVim](https://www.lazyvim.org/) as a base distribution with many language extras enabled (Ruby, Python, TypeScript, Go, Rust, Elixir, Haskell, etc.).

On first launch, Lazy.nvim will auto-install all plugins. Mason will install LSP servers, formatters, and linters as needed.

---

## tmux Setup

The tmux config uses [TPM](https://github.com/tmux-plugins/tpm) to manage plugins. After chezmoi apply, install plugins with:

```
tmux new-session
# Inside tmux:
<prefix> + I   (Ctrl-s then I)
```

Plugins installed:
- `tmux-resurrect` — save/restore sessions
- `tmux-continuum` — auto-save and auto-restore sessions

---

## Credits

Dotfiles structure inspired by the [chezmoi documentation](https://www.chezmoi.io/) and community best practices. Git log helpers from [Gary Bernhardt's dotfiles](https://github.com/garybernhardt/dotfiles).
