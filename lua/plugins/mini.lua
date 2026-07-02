vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim" },
}, { confirm = false, load = true })

require("mini.starter").setup({
	autoopen = true,
	items = nil,
	header = function()
		local v = vim.version()
		local versionstring = string.format("  Neovim Version: %d.%d.%d", v.major, v.minor, v.patch)
		local image = [[
         ___ . .  _
"T$$$P"   |  |_| |_
 :$$$     |  | | |_
 :$$$                                                      "T$$$$$$$b.
 :$$$     .g$$$$$p.   T$$$$b.    T$$$$$bp.                   BUG    "Tb      T$b      T$P   .g$P^^T$$  ,gP^^T$$
  $$$    d^"     "^b   $$  "Tb    $$    "Tb    .s^s. :sssp   $$$     :$; T$$P $^b.     $   dP"     `T :$P    `T
  :$$   dP         Tb  $$   :$;   $$      Tb  d'   `b $      $$$     :$;  $$  $ `Tp    $  d$           Tbp.
  :$$  :$;         :$; $$   :$;   $$      :$; T.   .P $^^    $$$    .dP   $$  $   ^b.  $ :$;            "T$$p.
  $$$  :$;         :$; $$...dP    $$      :$;  `^s^' .$.     $$$...dP"    $$  $    `Tp $ :$;     "T$$      "T$b
  $$$   Tb.       ,dP  $$"""Tb    $$      dP ""$""$" "$"$^^  $$$""T$b     $$  $      ^b$  T$       T$ ;      $$;
  $$$    Tp._   _,gP   $$   `Tb.  $$    ,dP    $  $...$ $..  $$$   T$b    :$  $       `$   Tb.     :$ T.    ,dP
  $$$;    "^$$$$$^"   d$$     `T.d$$$$$P^"     $  $"""$ $"", $$$    T$b  d$$bd$b      d$b   "^TbsssP" 'T$bgd$P
  $$$b.____.dP                                 $ .$. .$.$ss,d$$$b.   T$b.
.d$$$$$$$$$$P                                                      `T$b.
]]
		local finalimage = image .. versionstring
		return finalimage
	end,
})

local MiniFiles = require("mini.files")
MiniFiles.setup()
vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader>-", function()
	MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" })

require("mini.notify").setup({
	content = {
		format = function(notif)
			return notif.msg
		end,
	},
})

require("mini.cmdline").setup({
	autocorrect = { enable = false },
})
require("mini.surround").setup()

local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()
vim.keymap.set("n", "<leader>ff", function()
	MiniPick.builtin.files()
end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>fg", function()
	MiniPick.builtin.grep_live({ method = "plain" })
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fh", function()
	MiniPick.builtin.help()
end, { desc = "Mini Help" })
vim.keymap.set("n", "<leader>fx", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "Mini Picker Diagnostics" })
vim.keymap.set("n", "<leader>fk", function()
	MiniExtra.pickers.keymaps()
end, { desc = "Search keymaps" })

require("mini.pairs").setup()
vim.keymap.set("n", "<leader>ap", function()
	local enabled = vim.b.minipairs_disable
	if enabled then
		vim.b.minipairs_disable = nil
		vim.notify("Auto pairs: ON", vim.log.levels.INFO)
	else
		vim.b.minipairs_disable = true
		vim.notify("Auto pairs: OFF", vim.log.levels.INFO)
	end
end, { desc = "Toggle Auto Pairs" })

local miniclue = require("mini.clue")
miniclue.setup({
	triggers = {
		-- Leader triggers
		{ mode = "n", keys = "<leader>" },
	},
	window = {
		delay = 100,
	},
})

local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
	snippets = {
		MiniSnippets.gen_loader.from_lang(),
	},
})
MiniSnippets.start_lsp_server({ match = false })

local imap_expr = function(lhs, rhs)
	vim.keymap.set("i", lhs, rhs, { expr = true })
end
imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

require("mini.icons").setup()
require("mini.completion").setup({
	lsp_completion = {
		auto_setup = true,
	},
})
