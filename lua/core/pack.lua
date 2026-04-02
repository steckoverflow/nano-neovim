-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
-- diagnostics = { disable = { 'missing-fields' } }
require("plugins.ui.treesitter")
require("plugins.ui.themes")
require("plugins.mason")
require("plugins.mini")

vim.pack.add({
	-- Optional =================================================================
	{ src = "https://github.com/folke/todo-comments.nvim" },
})

require("todo-comments").setup({})
