local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
	group = highlight_group,
})

-- local format_group = augroup("FormatOnSave", { clear = true })
-- autocmd("BufWritePre", {
-- 	group = format_group,
-- 	callback = function(args)
-- 		local clients = vim.lsp.get_clients({
-- 			bufnr = args.buf,
-- 			method = "textDocument/formatting",
-- 		})
-- 		if #clients > 0 then
-- 			vim.lsp.buf.format({
-- 				bufnr = args.buf,
-- 				async = false,
-- 				timeout_ms = 2000,
-- 			})
-- 		end
-- 	end,
-- })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime", { clear = true }),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(event)
		-- local exclude = { "gitcommit" } -- don't remember position in commit messages
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
		local lcount = vim.api.nvim_buf_line_count(event.buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
