vim.pack.add({
	-- Mini =====================================================================
	{ src = "https://github.com/nvim-mini/mini.pairs" }, --- Autoclose pairs
	{ src = "https://github.com/nvim-mini/mini.pick" }, --- Picker
	{ src = "https://github.com/nvim-mini/mini.starter" }, --- Start menu
	{ src = "https://github.com/nvim-mini/mini.files" }, --- File explorer
	{ src = "https://github.com/nvim-mini/mini.clue" }, --- Mini clues
}, { confirm = false, load = true })

require("mini.starter").setup({
	autoopen = true,
	items = nil,
	header = function()
		local v = vim.version()
		local versionstring = string.format("  Neovim Version: %d.%d.%d", v.major, v.minor, v.patch)
		local image = [[
┌─────────────────────────────────────────┐
│                                         │
│    ███╗   ███╗██2╗   ██╗██╗███╗   ███╗   │
│    ████╗ ████║██║   ██║██║████╗ ████║   │
│    ██╔████╔██║██║   ██║██║██╔████╔██║   │
│    ██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║   │
│    ██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║   │
│    ╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝   │
└─────────────────────────────────────────┘
]]
		local finalimage = image .. versionstring
		return finalimage
	end,
})

require("mini.files").setup({})
require("mini.pick").setup({})
require("mini.pairs").setup()

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<leader>" },
	},
})
