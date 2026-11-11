--- diagnostic settings
local map = vim.keymap.set

vim.fn.sign_define("DapBreakpoint", {
	text = "", -- a large dot; change as desired
	texthl = "DiagnosticError", -- follows the colorscheme
	linehl = "", -- no full-line highlight
	numhl = "", -- no number-column highlight
})

local sev = vim.diagnostic.severity

vim.diagnostic.config({
	-- keep underline & severity_sort on for quick scanning
	underline = true,
	severity_sort = true,
	update_in_insert = false, -- less flicker
	float = {
		border = "rounded",
		source = true,
	},
	-- keep signs & virtual text, but tune them as you like
	signs = {
		text = {
			[sev.ERROR] = "",
			[sev.WARN] = "",
			[sev.INFO] = "",
			[sev.HINT] = "󰌵",
		},
		-- built-in Diff groups follow the colorscheme (light and dark)
		linehl = {
			[sev.ERROR] = "DiffDelete",
			[sev.WARN] = "DiffChange",
			[sev.INFO] = "DiffText",
			[sev.HINT] = "DiffAdd",
		},
	},
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
})

-- diagnostic keymaps
local diagnostic_goto = function(next, severity)
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		vim.diagnostic.jump({ count = next and 1 or -1, float = true, severity = severity })
	end
end

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>dn", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "<leader>ds", function()
	vim.diagnostic.setloclist()
end, { desc = "Diagnostic list" })
map("n", "<leader>dN", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
