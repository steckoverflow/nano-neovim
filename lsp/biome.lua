-- brew install biome
-- Formats JSON/JSONC (vscode-json-language-server has no formatter).
-- The inline config forces 2-space indent; a project biome.json is still discovered per file.
return {
	cmd = { "biome", "lsp-proxy" },
	filetypes = { "json", "jsonc" },
	settings = {
		biome = {
			inlineConfig = {
				formatter = { indentStyle = "space", indentWidth = 2 },
			},
		},
	},
}
