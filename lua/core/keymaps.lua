---=============================================================================
--- KEYMAPS
--------------------------------------------------------------------------------
--- General ====================================================================
local map = vim.keymap.set

map("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })
map("n", "<space>", "<Nop>", { desc = "Disable space in normal mode" })
map("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>fo", ":lua vim.lsp.buf.format()<CR>", { desc = "Format buffer (LSP)" })
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>", { desc = "Update plugins" })

-- Split window keymaps
map("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>-", ":split<CR>", { desc = "Horizontal split" })

--- Navigation =================================================================
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

--- Save & Load ================================================================
map("n", "<leader>w", "<cmd>w!<CR>", { silent = true, desc = "Write file" })
map("n", "<leader>s", ":source $HOME/.config/mnvim-min/init.lua<CR>", { desc = "Source config" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit Window" })

--Diagnostics
-- This is supposed to save and exit Neovim
map("n", "<leader>x", function()
	-- Close all terminal buffers first
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
	vim.cmd("wqa")
end, { desc = "Kill terminals and exit" })

-- VISUAL MODE INDENTING
-- =============================================================================
-- When indenting in visual mode, stay in visual mode (don't exit)
-- Default behavior exits visual mode after < or >, which is annoying
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- LINE MOVEMENT
-- =============================================================================
-- Move current line or selection up/down using Alt + j/k
-- == re-indents the line after moving to match surrounding context
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
-- In visual mode, use :m command with marks to move selection
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- PASTE IMPROVEMENT
-- =============================================================================
-- When pasting over a selection, don't yank the replaced text
-- "_d deletes to the black hole register (discards text)
-- P pastes before cursor
map("v", "p", '"_dP', { desc = "Paste without yanking replaced text" })

-- SCROLLING
-- =============================================================================
-- Keep cursor centered when scrolling half-pages and searching
-- zz centers the cursor line on screen
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- TOGGLE AUTO PAIRS
-- =============================================================================
-- Toggle mini.pairs auto pairs feature on/off
map("n", "<leader>ap", function()
	local enabled = vim.b.minipairs_disable
	if enabled then
		vim.b.minipairs_disable = nil
		vim.notify("Auto pairs: ON", vim.log.levels.INFO)
	else
		vim.b.minipairs_disable = true
		vim.notify("Auto pairs: OFF", vim.log.levels.INFO)
	end
end, { desc = "Toggle Auto Pairs" })

-- FILES & PICKING
-- =============================================================================
map("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "Help tags" })
map("n", "<leader>e", "<cmd>lua MiniFiles.open()<cr>", { desc = "Toggle explorer" })

-- DEBUGGING
-- =============================================================================
map("n", "<leader>dr", function()
	require("dap").continue()
end, { desc = "Run/Continue" })
map("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "Step Over" })
map("n", "<leader>dO", function()
	require("dap").step_out()
end, { desc = "Step Out" })
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dq", function()
	require("dap").terminate()
end, { desc = "Quit" })
map("n", "<leader>du", function()
	require("dap").toggle()
end, { desc = "Toggle UI" })

-- Diagnostics
map("n", "<leader>dn", function()
	vim.diagnostic.jump({ count = 1, direction = 1 })
end, { desc = "Next diagnostic" })
map("n", "<leader>dp", function()
	vim.diagnostic.jump({ count = 1, direction = -1 })
end, { desc = "Previous diagnostic" })
map("n", "<leader>dd", function()
	vim.diagnostic.open_float()
end, { desc = "Diagnostic details" })
map("n", "<leader>ds", function()
	vim.diagnostic.setloclist()
end, { desc = "Diagnostic list" })
