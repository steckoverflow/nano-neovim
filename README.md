# nano-neovim

A compact Neovim config built around native `vim.pack`, Treesitter, Mason-managed LSP/tools, `mini.nvim`, DAP, and a small theme picker.

## Requirements

- Neovim `>= 0.12`
- `git` for plugin downloads
- `ripgrep` / `rg` for `mini.pick` grep
- A compiler toolchain (`cc`/`clang`/`gcc` and `make`) for Treesitter parsers
- A Nerd Font-compatible font for diagnostic icons
- `lazygit` for the `<leader>gg` terminal popup

## Language Runtime Dependencies

Mason installs the configured language servers, formatters, linters, and debug adapter on first start:

- LSP: `lua_ls`, `vtsls`, `eslint`, `html`, `cssls`, `jsonls`, `yamlls`, `svelte`, `ty`, `ruff`
- Formatting/tools: `prettierd`, `stylua`, `taplo`
- Debugging: `debugpy`

Install the runtimes for the languages you use:

- Node.js + npm for TypeScript, JavaScript, Svelte, HTML, CSS, JSON, YAML, ESLint, and Prettier tooling
- Python for `ty`, `ruff`, and `debugpy`
- Lua tooling support through `lua_ls` and `stylua`
- Rust toolchain if you use TOML/Rust-adjacent workflows with `taplo`

## Install

```bash
git clone git@github.com:steckoverflow/nano-neovim.git ~/.config/nvim
nvim
```

On first start, Neovim fetches plugins with `vim.pack`; Mason then installs the configured LSP servers, tools, and Python debug adapter.

To start without plugins, run:

```bash
nvim --cmd ":lua vim.g.nop=1"
```

## Included Plugins

- `nvim-treesitter` for parser installation and highlighting
- `mini.nvim` modules: starter, files, notify, cmdline, surround, pick, extra, pairs, clue, completion, snippets
- `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`, and `mason-tool-installer.nvim`
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
| `<leader>-` | Open a horizontal split; in the mini files module this also maps to reveal current file |
| `<leader>ff` | Pick files |
| `<leader>fg` | Grep the word under the cursor |
| `<leader>fh` | Search help |
| `<leader>fx` | Search diagnostics |
| `<leader>fk` | Search keymaps |
| `<leader>ap` | Toggle auto pairs for the current buffer |
| `gd` | Go to definition |
| `<leader>f` / `<leader>fo` | Format buffer |
| `df` / `<leader>dd` | Show diagnostic details |
| `<leader>dn` / `<leader>dp` | Next / previous diagnostic |
| `<leader>ds` | Send diagnostics to location list |
| `<leader>gg` | Open lazygit in a floating terminal |
| `<leader>|` | Vertical split |
| `<C-h/j/k/l>` | Move between windows |
| `<A-j>` / `<A-k>` | Move line or visual selection down / up |
| `<leader>w` | Write file |
| `<leader>q` | Quit window |
| `<leader>x` | Delete terminal buffers and quit all |

## Debugging

Python debugging is configured through `nvim-dap-python` using Mason's `debugpy` environment.

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
