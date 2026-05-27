require("vim._core.ui2").enable({})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")
require("autocommands")

-- run without plugins nvim --cmd ":lua vim.g.nop=1"
if vim.g.nop == nil then
  require("pack")
  require("theme").load_default()
end
