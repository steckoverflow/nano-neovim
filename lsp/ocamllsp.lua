---@brief
---
--- https://github.com/ocaml/ocaml-lsp
---
--- Install:
--- ```sh
--- opam install ocaml-lsp-server ocamlformat
--- ```
---
--- Notes:
--- - Assumes the correct opam switch is already active in the shell that
---   launched Neovim (`eval $(opam env)` / direnv). No switch auto-detection
---   is done here (unlike gopls.lua's GOROOT/GOMODCACHE probing) -- add it
---   later if jump-to-definition into dependency/stdlib source matters to you.
--- - Formatting runs through ocamlformat via ocamllsp's built-in
---   documentFormattingProvider (uses this repo's generic format-on-save).
---   Add a `.ocamlformat` file (can be empty) at your project root so
---   ocamlformat actually formats instead of no-op'ing.
--- - .ml, .mli, .mll, .mly all resolve to Neovim filetype "ocaml" (there is
---   no ocaml.interface/ocamllex/menhir filetype in stock Neovim), so the
---   Treesitter "ocaml" grammar is used for all of them. tree-sitter-ocaml
---   ships a dedicated `ocaml_interface` grammar for .mli specifically, and
---   ocaml-lsp-server can be told the real per-extension languageId via a
---   `get_language_id` function (see nvim-lspconfig's ocamllsp.lua) -- both
---   were skipped here as unnecessary complexity for now.

---@type vim.lsp.Config
return {
	cmd = { "ocamllsp" },
	filetypes = { "ocaml", "dune" },
	root_markers = {
		{ "dune-project", "dune-workspace" },
		{ "*.opam", "opam" },
		{ ".git" },
	},
}
