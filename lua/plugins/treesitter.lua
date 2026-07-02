vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "7caec274fd19c12b55902a5b795100d21531391f",
	},
}, { confirm = false, load = true })

local treesitter = require("nvim-treesitter")

local ensure_installed = {
	"go",
	"rust",
	"typescript",
	"javascript",
	"tsx",
	"html",
	"css",
	"json",
	"bash",
	"http",
	"dockerfile",
	"svelte",
	"python",
}

treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local ft = vim.bo[buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end
		local ok_add = pcall(vim.treesitter.language.add, lang)
		if not ok_add then
			return
		end
		pcall(vim.treesitter.start, buf, lang)
		vim.wo[0].foldmethod = "expr"
		vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
