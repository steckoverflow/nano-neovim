--Debugger config
vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap", version = "45a69eba683a2c448dd9ecfc4de89511f0646b5f" },
	{ src = "https://github.com/nvim-neotest/nvim-nio", version = vim.version.range("1.10.1") },
	{ src = "https://github.com/rcarriga/nvim-dap-ui", version = "13888eb35faaba48efaf49130b83e0d12e042e1b" },
	{
		src = "https://github.com/mfussenegger/nvim-dap-python",
		version = "1808458eba2b18f178f990e01376941a42c7f93b",
	},
	{ src = "https://github.com/leoluz/nvim-dap-go", version = "b4421153ead5d726603b02743ea40cf26a51ed5f" },
}, { confirm = false, load = true })

require("dap")
-- require("dap").set_log_level("TRACE")
local dapui = require("dapui")
dapui.setup()
require("dap-python").setup("/Users/ts-air/.pyenv/versions/3.13.2/bin/python3")
require("dap-go").setup()
