--Debugger config
vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap", version = vim.version.range("0.10.0") },
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

local mason_packages = vim.fn.stdpath("data") .. "/mason/packages/"
require("dap-python").setup(mason_packages .. "debugpy/venv/bin/python")
