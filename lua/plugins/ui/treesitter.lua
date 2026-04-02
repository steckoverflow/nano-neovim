--- Plugins ===================================================================
--- Treesitter Syntax Highlighting
vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "7caec274fd19c12b55902a5b795100d21531391f",
	},
}, { confirm = false, load = true })

require("nvim-treesitter").setup({
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath("data") .. "/site",
	match = {
		enable = true,
	},
	swap = {
		enable = true,
		swap_next = {
			["<leader>rp"] = "@parameter.inner",
		},
		swap_previous = {
			["<leader>rP"] = "@parameter.inner",
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "zi",
			node_incremental = "zn",
			scope_incremental = "zo",
			node_decremental = "zd",
		},
	},
})

require("nvim-treesitter").install({
	"bash",
	"css",
	"go",
	"gomod",
	"gosum",
	"html",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"rust",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
	"zig",
})
