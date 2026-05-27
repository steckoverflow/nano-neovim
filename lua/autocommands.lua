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

local format_group = augroup("FormatOnSave", { clear = true })
autocmd("BufWritePre", {
  group = format_group,
  callback = function(args)
    local clients = vim.lsp.get_clients({
      bufnr = args.buf,
      method = "textDocument/formatting",
    })
    if #clients > 0 then
      vim.lsp.buf.format({
        bufnr = args.buf,
        async = false,
        timeout_ms = 2000,
      })
    end
  end,
})
