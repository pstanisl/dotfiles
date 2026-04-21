# Petr's Dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start (New Machine)

```sh
# Install chezmoi and apply dotfiles in one command
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply pstanisl
```

This will:
1. Install chezmoi
2. Clone this repo
3. Prompt for machine-specific values (name, email)
4. Apply all configs
5. Run bootstrap scripts (Homebrew packages, Oh-My-Zsh, TPM, etc.)
6. Generate cached zsh init scripts

## What's Managed

### Shell
- `.zshrc` — Main zsh config (oh-my-zsh, plugins, cached inits)
- `.zprofile` — Homebrew shellenv (templated for arch)
- `.zshenv` — Environment variables (cargo, editor, nvm, poetry)
- `.zsh/` — Modular zsh configs (aliases, brew, nvm, python, conda)

### Git
- `.gitconfig` — Templated (name/email per machine), histogram diff, zdiff3 merge
- `.gitignore` — Global ignores (macOS, Python, Node, C++)

### Terminal & Prompt
- `.config/starship.toml` — Starship prompt config
- `.config/ghostty/config` — Ghostty terminal (Catppuccin Mocha, transparency)
- `.config/tmux/tmux.conf` — Tmux (Ctrl-Space prefix, Catppuccin, vi-mode)

### Editors
- `.vimrc` — Vim config (vim_runtime framework)
- `.config/nvim/init.vim` — Neovim config

### Window Management
- `.config/aerospace/aerospace.toml` — AeroSpace tiling WM (vim-style bindings)
- `.hammerspoon/init.lua` — Hammerspoon automation for recovering windows after monitor disconnects

### Tools
- `.config/atuin/config.toml` — Atuin shell history (sync v2)
- `.config/gh/config.yml` — GitHub CLI
- `.config/btop/btop.conf` — System monitor
- `.hammerspoon/README.txt` — Hammerspoon hotkey and permission notes

### SSH
- `.ssh/config` — Templated (1Password agent path per machine)

## Updating

```sh
# Pull latest and apply
chezmoi update

# See what would change
chezmoi diff

# Add a new file
chezmoi add ~/.config/some/config

# Edit a managed file
chezmoi edit ~/.zshrc

# Re-apply (also re-runs onchange scripts)
chezmoi apply
```

## Regenerating Caches

The zsh init caches are regenerated automatically on `chezmoi apply`. To force:

```sh
fzf --zsh > ~/.zsh/cache/fzf.zsh
starship init zsh > ~/.zsh/cache/starship.zsh
atuin init zsh > ~/.zsh/cache/atuin.zsh
zoxide init zsh > ~/.zsh/cache/zoxide.zsh
```

## Structure

```
~/.local/share/chezmoi/
├── .chezmoi.toml.tmpl          # Machine-specific variables
├── .chezmoiignore              # Files to exclude from apply
├── Brewfile                    # Homebrew packages
├── run_once_01-install-packages.sh.tmpl    # Bootstrap script
├── run_onchange_02-regenerate-zsh-cache.sh.tmpl  # Cache regen
├── dot_zshrc, dot_zprofile.tmpl, dot_zshenv
├── dot_gitconfig.tmpl, dot_gitignore
├── dot_vimrc
├── dot_zsh/                    # Modular shell configs
├── dot_config/                 # XDG configs
│   ├── starship.toml
│   ├── ghostty/, aerospace/, tmux/, atuin/
│   ├── nvim/, gh/, btop/
└── private_dot_ssh/config.tmpl # SSH config (private)
```
