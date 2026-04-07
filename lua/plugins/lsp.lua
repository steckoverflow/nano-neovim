--LSP via Mason
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig", version = vim.version.range("2.7.0") }, -- default configs for lsps
	{ src = "https://github.com/mason-org/mason.nvim", version = vim.version.range("2.2.1") },
	-- NOTE: has a default feature to auto enable LSP servers.
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim", version = vim.version.range("2.1.0") }, -- lspconfig bridge
	{
		src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		version = "443f1ef8b5e6bf47045cb2217b6f748a223cf7dc",
	}, --2026-04-1
}, { confirm = false, load = true })

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
		"rust_analyzer",
		"gopls",
		"zls",
		"ty",
		"ruff",
		"prettierd",
		"stylua",
		"taplo",
		"goimports",
	},
})
