# Neovim Configuration

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) — a minimal, well-documented starting point.

## Structure

```
dotfiles/nvim/
└── .config/
    └── nvim/           ← symlinked to ~/.config/nvim via GNU Stow
        ├── init.lua        ← main config (kickstart base)
        ├── lua/
        │   └── custom/
        │       └── plugins/
        │           └── render-markdown.lua   ← markdown preview plugin
        └── doc/
```

## Installation

### 1. Install Neovim ≥ 0.10 (AppImage — no root required)

```bash
mkdir -p ~/.local/bin ~/.local/share/nvim-appimage
curl -Lo ~/.local/share/nvim-appimage/nvim.appimage \
  https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x ~/.local/share/nvim-appimage/nvim.appimage
ln -sf ~/.local/share/nvim-appimage/nvim.appimage ~/.local/bin/nvim
```

### 2. Link config with Stow

```bash
stow -d ~/dotfiles -t ~ nvim
```

### 3. Install dependencies (Ubuntu)

```bash
# ripgrep (Telescope live grep)
sudo apt install ripgrep

# fd (Telescope file search) — Ubuntu installs as fdfind
sudo apt install fd-find
ln -sf $(which fdfind) ~/.local/bin/fd
```

### 4. First launch

```bash
nvim
```

Lazy.nvim will bootstrap itself and install all plugins. Wait for it to finish, then `:q` and reopen.

## Installed Plugins (beyond kickstart defaults)

| Plugin | Purpose | Toggle |
|--------|---------|--------|
| `render-markdown.nvim` | In-buffer markdown rendering | `<leader>um` |

## Useful Commands

| Key | Action |
|-----|--------|
| `<leader>sh` | Search help (Telescope) |
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader>um` | Toggle markdown render (in .md files) |
| `:Lazy` | Plugin manager UI |
| `:Mason` | LSP/tool installer |
| `:checkhealth` | Diagnose issues |

## Tmux Integration

The `dotfiles/tmux/.tmux.conf` is configured with:
- `tmux-256color` as `default-terminal`
- True-color (`Tc`) for both xterm-256color and Ghostty
- Undercurl support for Neovim diagnostic underlines

## Glow — CLI Markdown Preview

Quick viewer for markdown files without opening Neovim:

```bash
glow README.md      # render a file
glow .              # browse markdown files in current dir
```

Installed at `~/.local/bin/glow` (v2.1.1).
