# mnvim

A minimal Neovim config built around native `vim.pack`, Treesitter, Mason LSP/tool management, and a few `mini.nvim` modules.

## Requirements

- Neovim `>= 0.12`
- `git` (plugin downloads from GitHub)
- `ripgrep` / `rg` (used by `mini.pick` live grep)
- A compiler toolchain (`cc`/`clang`/`gcc` and `make`) for Treesitter parsers

## Language Runtime Dependencies

This config auto-installs Mason tools such as `vtsls`, `eslint`, `ruff`, `gopls`, `rust_analyzer`, and `zls`.
Install runtimes for the languages you use:

- Node.js + npm (TypeScript/JavaScript tools like `vtsls`, `eslint`, `prettierd`)
- Python (tools like `ruff`, `ty`)
- Go (tools like `gopls`, `goimports`)
- Rust (for `rust_analyzer` workflows)
- Zig (for `zls`)

## Install

```bash
git clone https://github.com/<your-user>/mnvim ~/.config/mnvim
nvim
```

On first start, Neovim will fetch plugins and Mason will install configured LSP servers/tools.
