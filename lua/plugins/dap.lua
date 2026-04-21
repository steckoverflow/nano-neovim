--Debugger config
vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap", version = "45a69eba683a2c448dd9ecfc4de89511f0646b5f" },
	{ src = "https://github.com/nvim-neotest/nvim-nio", version = vim.version.range("1.10.1") },
	{ src = "https://github.com/rcarriga/nvim-dap-ui", version = vim.version.range("4.0.0") },
	{
		src = "https://github.com/mfussenegger/nvim-dap-python",
		version = "1808458eba2b18f178f990e01376941a42c7f93b",
	}, --2026-04-1
}, { confirm = false, load = true })

local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

local function cleanup_dap_terminals()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) then
			local name = vim.api.nvim_buf_get_name(buf)
			if name:match("^%[dap%-terminal%]") then
				pcall(vim.api.nvim_buf_delete, buf, { force = true })
			end
		end
	end
end

-- Automatically open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Work around old nvim-dap terminal buffer reuse bug on restart.
dap.listeners.before.launch["dap_terminal_cleanup"] = cleanup_dap_terminals
dap.listeners.before.attach["dap_terminal_cleanup"] = cleanup_dap_terminals
dap.listeners.before.event_terminated["dap_terminal_cleanup"] = cleanup_dap_terminals
dap.listeners.before.event_exited["dap_terminal_cleanup"] = cleanup_dap_terminals

local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"
require("dap-python").setup(mason_packages .. "debugpy/venv/bin/python")
