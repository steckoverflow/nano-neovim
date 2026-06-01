-- Install with: npm i -g svelte-language-server

---@type vim.lsp.Config
return {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },
	root_markers = { "package.json", "svelte.config.js", "svelte.config.cjs", "svelte.config.mjs", ".git" },
}
