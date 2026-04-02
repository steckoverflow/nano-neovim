vim.pack.add({
	{
		src = "https://github.com/folke/tokyonight.nvim",
		name = "tokyonight",
		version = vim.version.range("4.14.1"), --2026-04-1
	},
	{
		src = "https://github.com/spaceduck-theme/nvim",
		name = "spaceduck",
		version = vim.version.range("1.1.0"), --2026-04-1
	},
}, { confirm = false, load = true })
