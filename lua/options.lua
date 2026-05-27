local o = vim.opt

o.number = true
o.wrap = false
o.clipboard = "unnamedplus"
o.mouse = "a"
o.tabstop = 2                                               -- Number of spaces a <Tab> character displays as
o.shiftwidth = 2                                            -- Number of spaces for auto-indent (>>, <<, ==)
o.softtabstop = 2                                           -- Number of spaces <Tab> inserts in insert mode
o.expandtab = true                                          -- Convert tabs to spacjs when typing
o.smartindent = true                                        -- Auto-indent new lines based on syntax (e.g., after {)
o.ignorecase = true                                         -- Ignore case when searching (e.g., /foo matches FOO)
o.smartcase = true                                          -- Override ignorecase if search contains uppercase
o.hlsearch = true                                           -- Highlight all matches of the search pattern
o.incsearch = true                                          -- Show matches incrementally as you type the pattern
o.showtabline = 2                                           -- Always show tabline (0 = never, 1 = if multiple tabs, 2 = always)
o.laststatus = 2                                            -- Show statusline (2 = always, 3 = global statusline)
o.cmdheight = 0                                             -- Hide cmdline when not in use
o.termguicolors = true                                      -- Enable 24-bit RGB colors (required for modern themes)
o.signcolumn = "yes"                                        -- Always show sign column (prevents text shifting)
o.cursorline = true                                         -- Highlight the line containing the cursor
o.scrolloff = 12                                            -- Keep 8 lines visible above/below cursor when scrolling
o.sidescrolloff = 8                                         -- Keep 8 columns visible left/right of cursor
o.colorcolumn = "88"                                        -- Highlight column 80
o.splitright = true                                         -- Open vertical splits to the right of current window
o.splitbelow = true                                         -- Open horizontal splits below current window
o.backspace = "indent,eol,start"                            -- Allow backspace over everything in insert mode
o.undofile = true                                           -- Persist undo history to disk (survives closing file)
o.swapfile = false                                          -- Don't create swap files (we have undo history)
o.backup = false                                            -- Don't create backup files before saving
o.updatetime = 100                                          -- Milliseconds of idle time before CursorHold event fires
o.completeopt = { "menuone", "noselect", "popup", "fuzzy" } -- Options for completion menu
o.autocomplete = true
o.conceallevel = 0                                          -- Hide markup characters in markdown/latex
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
