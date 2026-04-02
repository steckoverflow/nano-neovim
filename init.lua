--- Requires:
--- Nvim >= 0.12
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- TODO:
-- - DAP
-- - Maybe native LSP over Mason?
-- - Evaluate AutoComplete

require("core.options")
require("core.keymaps")
require("core.autocommands")
require("core.misc")

-- run without plugins nvim --cmd ":lua vim.g.nop=1"
if vim.g.nop == nil then
	require("core.pack")
	vim.cmd.colorscheme("spaceduck")
end

require("core.statusline")
