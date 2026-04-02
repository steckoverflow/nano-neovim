local o = vim.opt

-- Critical
o.number = true -- absolute numbers
o.wrap = false
o.clipboard = "unnamedplus"
o.mouse = "a" -- Enable mouse support in all modes
-- a = all modes (normal, visual, insert, command-line)
-- Useful for scrolling, selecting, and resizing splits

-- Tabs
o.tabstop = 2 -- Number of spaces a <Tab> character displays as
o.shiftwidth = 2 -- Number of spaces for auto-indent (>>, <<, ==)
o.softtabstop = 2 -- Number of spaces <Tab> inserts in insert mode
o.expandtab = true -- Convert tabs to spacjs when typing
o.smartindent = true -- Auto-indent new lines based on syntax (e.g., after {)

-- Search
o.ignorecase = true -- Ignore case when searching (e.g., /foo matches FOO)
o.smartcase = true -- Override ignorecase if search contains uppercase
o.hlsearch = true -- Highlight all matches of the search pattern
o.incsearch = true -- Show matches incrementally as you type the pattern

-- Appearance
o.showtabline = 2 -- Always show tabline (0 = never, 1 = if multiple tabs, 2 = always)
o.laststatus = 2 -- Show statusline (2 = always, 3 = global statusline)
o.cmdheight = 0 -- Hide cmdline when not in use
o.termguicolors = true -- Enable 24-bit RGB colors (required for modern themes)
o.signcolumn = "yes" -- Always show sign column (prevents text shifting)
o.cursorline = true -- Highlight the line containing the cursor
o.scrolloff = 12 -- Keep 8 lines visible above/below cursor when scrolling
o.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
o.colorcolumn = "80" -- Highlight column 80
-- Splits
o.splitright = true -- Open vertical splits to the right of current window
o.splitbelow = true -- Open horizontal splits below current window

-- Backspace
o.backspace = "indent,eol,start" -- Allow backspace over everything in insert mode
-- indent: backspace over auto-indent
-- eol: backspace over line breaks (join lines)
-- start: backspace over start of insert

-- Undofile and backup
o.undofile = true -- Persist undo history to disk (survives closing file)
-- Undo files are stored in ~/.local/state/nvim/undo/
o.swapfile = false -- Don't create swap files (we have undo history)
o.backup = false -- Don't create backup files before saving

-- Timing
o.updatetime = 100 -- Milliseconds of idle time before CursorHold event fires

-- Completion
o.completeopt = { "menuone", "popup", "noinsert" } -- Options for completion menu
-- menu: show popup menu even for one match
-- menuone: show menu even with only one match
-- noselect: don't auto-select first item (user must choose)

-- Visual
o.conceallevel = 0 -- Hide markup characters in markdown/latex
-- 0: show all, 1: conceal with replacement char, 2: hide completely

-- Show invisible characters
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Window title
o.title = true -- Show file info in terminal/window title
o.titlestring = "%t%m - NVIM" -- %t = filename, %m = modified flag [+]
