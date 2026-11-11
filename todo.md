# TODO (from audit)

Fix first: 1, 7, 8. Then 2–6.

## Must fix

- [ ] **1. No-plugins mode breaks statusline** (`lua/config/statusline.lua:299`)
  `require("mini.icons")` is called without a guard, so it fails when `vim.g.nop=1`. Fix: `local ok, icons = pcall(require, "mini.icons")`, return `""` if not ok.
- [ ] **2. Treesitter indent never enabled** (`lua/plugins/treesitter.lua:53`)
  `vim.treesitter.indentexpr` is nil and the line only touches the startup buffer. Fix: delete line 53. In the `FileType` callback, after `vim.treesitter.start`, set `vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"`.
- [ ] **3. Whole-line diagnostic colors never show** (`lua/config/diagnostics.lua:4-14, 48-54`)
  `linehl` is ignored at the top level and only works inside `signs`. The colors are dark, but the default theme is light. Fix: move `linehl` into `signs`, or delete the palette, the 4 `nvim_set_hl` calls and `linehl` (~18 lines).
- [ ] **4. Breakpoint sign loses color after theme switch** (`lua/config/diagnostics.lua:15-21`)
  Fix: `texthl = "DiagnosticError"` and delete the `nvim_set_hl` line.
- [ ] **5. `<leader>uf` can need two presses** (`lua/plugins/lsp.lua:163-172`)
  The local `auto_format` flag drifts from `:FormatDisable`. Fix: delete the flag and use `vim.cmd(vim.g.disable_autoformat and "FormatEnable" or "FormatDisable")`.
- [ ] **6. HTML never formats** (`lsp/html.lua:7`)
  Fix: add `init_options = { provideFormatter = true }` (same as `cssls.lua`) and delete the top-level `embeddedLanguages`.
- [ ] **7. `vim.tbl_flatten` deprecation warning on every start** (`lua/plugins/dap.lua:5`)
  The pinned nvim-dap-ui (Mar 2024) calls it in `dapui/logging.lua:42`. Fix: bump the pin to a current commit or remove `version`.

## Should fix

- [ ] **8. ~31 ms of startup spent on `node --version`** (`lsp/vtsls.lua:5-27`)
  Fix: make `cmd` a function: `cmd = function(d, c) return vim.lsp.rpc.start(get_vtsls_cmd(), d, { cwd = c.cmd_cwd, env = c.cmd_env }) end`.
- [ ] **9. Lockfile lists 11 unused plugins** (`nvim-pack-lock.json`)
  Run `:lua vim.pack.del({"gitsigns.nvim","lazygit.nvim","mason.nvim","mason-lspconfig.nvim","mason-tool-installer.nvim","nvim-lspconfig","mini.clue","mini.files","mini.pairs","mini.pick","mini.starter"})`, then commit the lockfile.
- [ ] **10. README misses `tree-sitter-cli`** (`README.md`, Requirements)
  nvim-treesitter (main) needs `tree-sitter-cli` 0.26.1 or later. Add it to Requirements and to the `brew install` line.
- [ ] **11. `gf` / `:find` can freeze in JS repos** (`lua/config/options.lua:65`)
  `path:append("**")` walks `node_modules` and `.git`. Fix: delete the line, since `<leader>ff` already finds files.
- [ ] **12. No startup check** (repo)
  Add a script or README line that runs `nvim --headless "+qa"` and `nvim --headless --cmd "lua vim.g.nop=1" README.md "+qa"`, and fails on any output.
- [ ] **13. Defaults and dead flags in `options.lua`** (`lua/config/options.lua`, ~25 lines)
  - Dead flags: `vim.g.autoformat`, `vim.g.trouble_lualine`, the `vim.g.vscode` check.
  - Already defaults: `messagesopt`, `hidden`, `autoindent`, `backspace`, `encoding`, `incsearch`, `wildmenu`, `modifiable`, `errorbells`, `autochdir`, `winfixbuf`, `smoothscroll`, `list`, `relativenumber`, `winblend`, `foldmethod`.
  - Set twice: `shiftwidth`, and `laststatus`/`showmode` (also in `statusline.lua:396-397`).
  - `diffopt`: two values are defaults, as its own comment says.
- [ ] **14. Dead code and duplicate keymaps in `lsp.lua`** (`lua/plugins/lsp.lua:24-37, 49, 65-69, 138-142`, ~25 lines)
  - Unused `completion` and the commented completion block.
  - Unused `vim.g.lsp_on_demands`, with a wrong eslint comment.
  - `K`, `grt` and `grx` are already 0.12 defaults.
- [ ] **15. Statusline bloat** (`lua/config/statusline.lua:55-181, 184-225, 292-303`, ~90 lines)
  - Use `%#StatusLine#` instead of the 9 duplicate groups.
  - Delete the unused `StatusNorm` and `StatusLSPToNorm`.
  - Drop the icon cache, which goes stale after `:w foo.py`, and call `mini.icons.get` directly.
  - Drop the diagnostic cache and call `vim.diagnostic.count(0)`.
- [ ] **16. Ignored or duplicated LSP settings**
  - `lsp/gopls.lua:85-87`: delete the top-level `completeUnimported`. It is ignored outside `gopls = {}` and is already the default.
  - `lsp/vtsls.lua:40-52`: delete the `valid_filetypes` re-check.
  - `lsp/eslint.lua:65`: delete the stale comment about `oxlint.lua`.
  - `lsp/biome.lua`: optionally drop biome and add `init_options = { provideFormatter = true }` to `jsonls.lua`. Fix the README claim that it "has no formatter".

## Nice to have

- [ ] **17. `%` in a file name breaks the statusline** (`lua/config/statusline.lua:352`)
  Fix: `fnm = fnm:gsub("%%", "%%%%")`.
- [ ] **18. Commit messages reopen at an old line** (`lua/config/autocommands.lua:24-33`)
  Skip `gitcommit` and add an augroup.
- [ ] **19. `<leader>fo` notifies "Code formatted" too early** (`lua/plugins/lsp.lua:43`)
  Fix: delete the `vim.notify` line.
- [ ] **20. Repo hygiene** (`.DS_Store`, `.gitignore`)
  Run `git rm --cached .DS_Store`. Replace `*pack*` with `.DS_Store` and `/pack/` in `.gitignore`.

## Left out (~5 smaller)

- `"v"` vs `"x"` in visual-mode maps.
- The deprecated `vim.highlight` alias.

## Not checked

- Live LSP formatting, including a possible vtsls/eslint format-on-save conflict.
- DAP sessions.
- ui2 and mini.notify message routing.
- Theme plugin code.
