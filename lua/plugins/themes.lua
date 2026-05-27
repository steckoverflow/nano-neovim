vim.pack.add({
	{
		src = "https://github.com/folke/tokyonight.nvim",
		name = "tokyonight",
		version = vim.version.range("4.14.1"), --2026-04-1
	},
	{
		src = "https://github.com/projekt0n/github-nvim-theme",
		name = "github",
	},
	{
		src = "https://github.com/yorik1984/newpaper.nvim",
		name = "newpaper",
	},
	{
		src = "https://github.com/rose-pine/neovim",
		name = "rose-pine",
	},
	{
		src = "https://github.com/spaceduck-theme/nvim",
		name = "spaceduck",
		version = vim.version.range("1.1.0"), --2026-04-1
	},
}, { confirm = false, load = true })

require("newpaper").setup({
	style = "light",
})
