require("vim._core.ui2").enable({})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocommands")
require("core.misc")

-- run without plugins nvim --cmd ":lua vim.g.nop=1"
if vim.g.nop == nil then
  require("core.pack")
  require("core.theme").load_default()
end

require("core.statusline")
