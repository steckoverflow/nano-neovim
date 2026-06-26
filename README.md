# nano-neovim

A compact Neovim config built around native `vim.pack`, native `vim.lsp` configs in `lsp/`, Treesitter, `mini.nvim`, DAP, and a small theme picker.

## Requirements

- Neovim `>= 0.12`
- `git` for plugin downloads
- `ripgrep` / `rg` for `mini.pick` grep
- A compiler toolchain (`cc`/`clang`/`gcc` and `make`) for Treesitter parsers
- A Nerd Font-compatible font for diagnostic icons
- `lazygit` for the `<leader>gg` terminal popup

## Language Runtime Dependencies

Language servers and tools are configured with Neovim's native `vim.lsp` loader from files in `lsp/`. Install the command-line tools you need yourself:

```bash
brew install lua-language-server gopls ruff stylua taplo ty delve
npm install -g vscode-langservers-extracted yaml-language-server typescript vtsls eslint
python -m venv ~/.local/share/nvim/debugpy/venv
~/.local/share/nvim/debugpy/venv/bin/python -m pip install debugpy
```

Notes:

- `vscode-langservers-extracted` provides `vscode-html-language-server`, `vscode-css-language-server`, and `vscode-json-language-server`.
- `yaml-language-server` provides YAML support.
- `vtsls` is the default TypeScript server. Set `vim.g.lsp_typescript_server` before loading the config to use another configured TypeScript server.
- ESLint only starts when an ESLint flat config is found and is skipped when an Oxlint config is present.
- Python DAP uses `debugpy`; install it into the virtualenv path configured in `lua/plugins/dap.lua`.

## Install

```bash
git clone git@github.com:steckoverflow/nano-neovim.git ~/.config/nvim
nvim
```

On first start, Neovim fetches plugins with `vim.pack`. LSP servers and tools must already be available on your `PATH`.

To start without plugins, run:

```bash
nvim --cmd ":lua vim.g.nop=1"
```

## Included Plugins

- `nvim-treesitter` for parser installation and highlighting
- `mini.nvim` modules: starter, files, notify, cmdline, surround, pick, extra, pairs, clue, completion, snippets
- Native `vim.lsp` with config files under `lsp/`
- `nvim-dap`, `nvim-dap-ui`, `nvim-dap-python`, and `nvim-nio`
- `todo-comments.nvim`
- Themes: Tokyo Night, GitHub, Newpaper, Rose Pine, and SpaceDuck

## Treesitter

The config installs parsers for:

- Go, Rust, TypeScript, JavaScript, TSX
- HTML, CSS, JSON, Bash, HTTP, Dockerfile, Python

Treesitter highlighting starts automatically for filetypes with an available parser.

## Editing Behavior

- Space is the leader key.
- `jk` exits insert mode.
- Files format on save when an attached LSP client supports formatting.
- Diagnostics show inline virtual text and sign-column icons.
- Undo history is persistent; swap and backup files are disabled.
- Completion uses native popup/fuzzy options plus `mini.completion` LSP capabilities.
- Snippets are loaded through `mini.snippets` from language snippet collections.
- Default colorscheme is `newpaper`; theme selection is available through `<leader>uT`.

## Keymaps

| Key | Action |
| --- | --- |
| `<leader>ps` | Update plugins with `vim.pack.update()` |
| `<leader>uT` | Select a theme |
| `<leader>e` | Open `mini.files` |
| `<leader>-` | Reveal current file in `mini.files` when plugins are enabled |
| `<leader>_` | Horizontal split |
| `<leader>ff` | Pick files |
| `<leader>fg` | Grep the word under the cursor |
| `<leader>fh` | Search help |
| `<leader>fx` | Search diagnostics |
| `<leader>fk` | Search keymaps |
| `<leader>ap` | Toggle auto pairs for the current buffer |
| `gd` | Go to definition |
| `K` / `<leader>k` | Hover documentation |
| `grt` | Go to type definition |
| `grx` | Run code lens |
| `<leader>ca` | Code action |
| `<leader>cl` | LSP fix all / ESLint fix all |
| `<leader>cr` | Rename symbol |
| `<leader>cw` | Workspace diagnostics |
| `<leader>fo` | Format buffer |
| `<leader>uf` | Toggle format on save |
| `<leader>cd` | Show diagnostic details |
| `]d` / `[d` | Next / previous diagnostic |
| `]e` / `[e` | Next / previous error |
| `]w` / `[w` | Next / previous warning |
| `<leader>dn` / `<leader>dp` | Next / previous diagnostic |
| `<leader>ds` | Send diagnostics to location list |
| `<leader>gg` | Open lazygit in a floating terminal |
| `<leader>|` | Vertical split |
| `<C-S-Up/Down/Left/Right>` | Resize windows |
| `<C-h/j/k/l>` | Move between windows |
| `<A-j>` / `<A-k>` | Move line or visual selection down / up |
| `<C-d>` / `<C-u>` | Half-page scroll and center cursor |
| `n` / `N` | Next / previous search result and center cursor |
| `gl` / `gh` | Go to end / start of line |
| `zv` | Close all folds except current fold |
| `zj` | Close current fold and open next fold |
| `<leader>w` | Write file |
| `<leader>q` | Quit window |
| `<leader>x` | Delete terminal buffers and quit all |

## Debugging

Python debugging is configured through `nvim-dap-python` using the local `debugpy` virtualenv.

| Key | Action |
| --- | --- |
| `<leader>dr` | Run / continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dq` | Terminate session |
| `<leader>du` | Toggle DAP UI |

The DAP UI opens when a session starts and closes when the session terminates or exits.
