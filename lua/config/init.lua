require("config.options")
require("config.keymaps")
require("config.autocommands")
require("config.ui2")
require("config.diagnostics")
require("config.statusline")

-- run without plugins nvim --cmd ":lua vim.g.nop=1"
if vim.g.nop == nil then
	require("config.pack")
	require("config.theme").load_default()
end
