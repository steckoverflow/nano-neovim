local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })
map("n", "<space>", "<Nop>", { desc = "Disable space in normal mode" })
map("n", "<esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>", { desc = "Update plugins" })
map("n", "<leader>uT", function()
	require("config.theme").select()
end, { desc = "Select theme" })

map("n", "<leader>|", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>_", ":split<CR>", { desc = "Horizontal split" })
--
-- Resize windows with Ctrl+Shift+arrows (macOS friendly)
map("n", "<C-S-Up>", "<cmd>resize +5<CR>", opts)
map("n", "<C-S-Down>", "<cmd>resize -5<CR>", opts)
map("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>", opts)
map("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>", opts)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map("n", "<leader>w", "<cmd>w!<CR>", { silent = true, desc = "Write file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit Window" })
map("n", "<leader>x", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
	vim.cmd("wqa")
end, { desc = "Kill terminals and exit" })
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("v", "p", '"_dP', { desc = "Paste without yanking replaced text" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
--
-- Better line start/end (more comfortable than $ and ^)
map("n", "gl", "$", { desc = "Go to end of line" })
map("n", "gh", "^", { desc = "Go to start of line" })

map("n", "<leader>gg", function()
	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	})
	vim.fn.termopen("lazygit", {
		on_exit = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end,
	})
	vim.cmd("startinsert")
end, { desc = "Lazygit" })

-- Close all fold except the current one.
map("n", "zv", "zMzvzz", {
	desc = "Close all folds except the current one",
})

-- Close current fold when open. Always open next fold.
map("n", "zj", "zcjzOzz", {
	desc = "Close current fold when open. Always open next fold.",
})

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
	require("dapui").toggle()
end, { desc = "Toggle UI" })

-- Diagnostics
map("n", "<leader>dn", function()
	vim.diagnostic.jump({ count = 1, direction = 1 })
end, { desc = "Next diagnostic" })
map("n", "<leader>dp", function()
	vim.diagnostic.jump({ count = 1, direction = -1 })
end, { desc = "Previous diagnostic" })
map("n", "<leader>ds", function()
	vim.diagnostic.setloclist()
end, { desc = "Diagnostic list" })
