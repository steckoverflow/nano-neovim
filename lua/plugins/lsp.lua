--LSP via Mason
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig",          version = vim.version.range("2.7.0") }, -- default configs for lsps
  { src = "https://github.com/mason-org/mason.nvim",           version = vim.version.range("2.2.1") },
  -- NOTE: has a default feature to auto enable LSP servers.
  { src = "https://github.com/mason-org/mason-lspconfig.nvim", version = vim.version.range("2.1.0") }, -- lspconfig bridge
  {
    src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    version = "443f1ef8b5e6bf47045cb2217b6f748a223cf7dc",
  }, --2026-04-1
}, { confirm = false, load = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())
vim.lsp.config("*", { capabilities = capabilities })

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua_ls",
    "vtsls",
    "eslint",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "svelte",
    "ty",
    "ruff",
    "prettierd",
    "stylua",
    "taplo",
    "debugpy",
  },
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Local buffer" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
