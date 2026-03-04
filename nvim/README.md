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

## Keymaps

> `<leader>` = `Space`

### General

| Key | Mode | Action |
|-----|------|--------|
| `<Esc>` | n | Clear search highlights |
| `<leader>q` | n | Open diagnostic quickfix list |
| `<Esc><Esc>` | t | Exit terminal mode |
| `<leader>gg` | n | Open lazygit |
| `<C-h/l/j/k>` | n | Move focus between windows |

### File Explorer (NeoTree)

| Key | Action |
|-----|--------|
| `\` | Toggle NeoTree / reveal current file |

### Telescope (Search)

| Key | Action |
|-----|--------|
| `<leader><leader>` | Find open buffers |
| `<leader>sf` | Search files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Search word under cursor |
| `<leader>sh` | Search help tags |
| `<leader>sk` | Search keymaps |
| `<leader>sd` | Search diagnostics |
| `<leader>sr` | Resume last picker |
| `<leader>s.` | Recent files |
| `<leader>sc` | Search commands |
| `<leader>sn` | Search Neovim config files |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>s/` | Live grep in open files only |

### LSP

| Key | Action |
|-----|--------|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grd` | Go to definition |
| `grr` | Go to references |
| `gri` | Go to implementation |
| `grD` | Go to declaration |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

### Editing

| Key | Action |
|-----|--------|
| `<leader>f` | Format buffer |

### Toggles

| Key | Action |
|-----|--------|
| `<leader>tc` | Toggle Copilot |
| `<leader>um` | Toggle markdown rendering (in .md files) |

### Autocompletion (blink.cmp — Insert mode)

| Key | Action |
|-----|--------|
| `<C-y>` | Accept completion |
| `<C-space>` | Open completion menu |
| `<C-n>` / `<Down>` | Next item |
| `<C-p>` / `<Up>` | Previous item |
| `<C-e>` | Dismiss menu |
| `<C-k>` | Toggle signature help |
| `<Tab>` / `<S-Tab>` | Move within snippet |

### Disabled Plugins (uncomment to activate)

**gitsigns** (`init.lua:937`):

| Key | Action |
|-----|--------|
| `]c` / `[c` | Next / previous git hunk |
| `<leader>hs/hr` | Stage / reset hunk |
| `<leader>hS/hR` | Stage / reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame current line |
| `<leader>hd/hD` | Diff against index / last commit |
| `<leader>tb` | Toggle line blame |
| `<leader>tD` | Toggle show deleted |

**DAP Debugger** (`init.lua:931`):

| Key | Action |
|-----|--------|
| `<F5>` | Start / continue |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<F7>` | Toggle DAP UI |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Conditional breakpoint |

## Neovim Commands

| Command | Action |
|---------|--------|
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
