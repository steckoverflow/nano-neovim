---=============================================================================
--- Autocommands
--------------------------------------------------------------------------------
--- General ====================================================================
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

--- File =======================================================================
-- Auto format before save
local lsp_format_group = vim.api.nvim_create_augroup("LspAutoFormat", { clear = true })

local function pick_format_client(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/formatting" })
	if #clients == 0 then
		return nil
	end

	for _, client in ipairs(clients) do
		if client.name == "ruff" then
			return client
		end
	end

	return clients[1]
end

vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_format_group,
	callback = function(event)
		local client = pick_format_client(event.buf)
		if not client then
			return
		end

		vim.lsp.buf.format({
			bufnr = event.buf,
			async = false,
			filter = function(format_client)
				return format_client.id == client.id
			end,
		})
	end,
})

--- Statusline =================================================================
local statusline = augroup("Statusline", { clear = true })

autocmd({ "WinEnter", "BufEnter" }, {
	group = statusline,
	desc = "Activate statusline on focus",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.active()"
	end,
})

autocmd({ "WinLeave", "BufLeave" }, {
	group = statusline,
	desc = "Deactivate statusline when unfocused",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
	end,
})

--- LSP & Autocomplete ================================================================
autocmd("LspAttach", {
	group = augroup("native_lsp_completion", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

autocmd("LspAttach", {
	group = augroup("lsp_keymaps", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local opts = { buffer = ev.buf }
		local map = vim.keymap.set
		map("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		map(
			"n",
			"<leader>gi",
			vim.lsp.buf.implementation,
			vim.tbl_extend("force", opts, { desc = "Go to implementation" })
		)
		map("n", "<leader>gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
		map("n", "<leader>gf", vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "Format" }))
	end,
})

--- Treesitter ==================================================================
local treesitter = augroup("Treesitter", { clear = true })

autocmd("FileType", {
	group = treesitter,
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
