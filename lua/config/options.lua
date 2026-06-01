local opt = vim.opt

opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true -- Highlight current line
opt.wrap = false -- Don't wrap lines
opt.scrolloff = 10 -- Keep 10 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

-- Indentation
opt.tabstop = 2 -- Tab width
opt.shiftwidth = 2 -- Indent width
opt.softtabstop = 2 -- Soft tab stop
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart auto-indenting
opt.autoindent = true -- Copy indent from current line

-- Search settings
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Case sensitive if uppercase in search
opt.hlsearch = false -- Don't highlight search results
opt.incsearch = true -- Show matches as you type

-- Visual settings
opt.termguicolors = true -- Enable 24-bit colors
opt.signcolumn = "yes" -- Always show sign column
opt.showmatch = true -- Highlight matching brackets
opt.matchtime = 2 -- How long to show matching bracket
opt.cmdheight = 1 -- Command line height
opt.showmode = false -- Don't show mode in command line
opt.pumheight = 10 -- Popup menu height
opt.pumblend = 10 -- Popup menu transparency
opt.pummaxwidth = 60 -- cap completion popup width
opt.winblend = 0 -- Floating window transparency
opt.completeopt = "menu,menuone,noselect,popup" -- popup shows completionItem/resolve preview
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.concealcursor = "" -- Don't hide cursor line markup
opt.synmaxcol = 300 -- Syntax highlighting limit
opt.ruler = false -- Disable the default ruler
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5 -- Minimum window width

-- File handling
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory

opt.updatetime = 500
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.ttimeoutlen = 0 -- Key code timeout
opt.autoread = true -- Auto reload files changed outside vim
opt.autowrite = true -- Auto save

-- Behavior settings
opt.hidden = true -- Allow hidden buffers
opt.errorbells = false -- No error bells
opt.backspace = "indent,eol,start" -- Better backspace behavior
opt.autochdir = false -- Don't auto change directory

opt.path:append("**") -- include subdirectories in search
opt.selection = "exclusive" -- Selection behavior
opt.mouse = "a" -- Enable mouse support
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.modifiable = true -- Allow buffer modifications
opt.encoding = "UTF-8" -- Set encoding

-- Folding settings
opt.smoothscroll = false
vim.wo.foldmethod = "manual"
opt.foldlevel = 99 -- Start with all folds open
opt.formatoptions = "jcroqlnt" -- tcqj
opt.nrformats = "unsigned"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep --no-heading --smart-case"

-- Split behavior
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right
opt.splitkeep = "screen"

-- Command-line completion
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options (indent-heuristic + inline:char are now defaults, linematch stays custom)
opt.diffopt:append("linematch:60,indent-heuristic,inline:char")

-- Performance improvements
opt.redrawtime = 10000
opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

vim.g.autoformat = true
vim.g.trouble_lualine = true

-- global floating window border (all vim.lsp, vim.diagnostic, etc.)
opt.winborder = "rounded"
-- completion popup menu border
opt.pumborder = "rounded"
opt.messagesopt = "hit-enter,history:500,progress:c"
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = false -- Show some invisible characters (tabs...)
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })

vim.g.markdown_recommended_style = 0

vim.filetype.add({
	extension = {
		env = "dotenv",
		txt = "markdown",
	},
	filename = {
		[".env"] = "dotenv",
		["env"] = "dotenv",
	},
	pattern = {
		["[jt]sconfig.*.json"] = "jsonc",
		["%.env%.[%w_.-]+"] = "dotenv",
	},
})

-- local o = vim.opt
--
-- o.number = true
-- o.wrap = false
-- o.clipboard = "unnamedplus"
-- o.mouse = "a"
-- o.tabstop = 2 -- Number of spaces a <Tab> character displays as
-- o.shiftwidth = 2 -- Number of spaces for auto-indent (>>, <<, ==)
-- o.softtabstop = 2 -- Number of spaces <Tab> inserts in insert mode
-- o.expandtab = true -- Convert tabs to spacjs when typing
-- o.smartindent = true -- Auto-indent new lines based on syntax (e.g., after {)
-- o.ignorecase = true -- Ignore case when searching (e.g., /foo matches FOO)
-- o.smartcase = true -- Override ignorecase if search contains uppercase
-- o.hlsearch = true -- Highlight all matches of the search pattern
-- o.incsearch = true -- Show matches incrementally as you type the pattern
-- o.showtabline = 2 -- Always show tabline (0 = never, 1 = if multiple tabs, 2 = always)
-- o.laststatus = 2 -- Show statusline (2 = always, 3 = global statusline)
-- o.cmdheight = 0 -- Hide cmdline when not in use
-- o.termguicolors = true -- Enable 24-bit RGB colors (required for modern themes)
-- o.signcolumn = "yes" -- Always show sign column (prevents text shifting)
-- o.cursorline = true -- Highlight the line containing the cursor
-- o.scrolloff = 12 -- Keep 8 lines visible above/below cursor when scrolling
-- o.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
-- o.colorcolumn = "88" -- Highlight column 80
-- o.splitright = true -- Open vertical splits to the right of current window
-- o.splitbelow = true -- Open horizontal splits below current window
-- o.backspace = "indent,eol,start" -- Allow backspace over everything in insert mode
-- o.undofile = true -- Persist undo history to disk (survives closing file)
-- o.swapfile = false -- Don't create swap files (we have undo history)
-- o.backup = false -- Don't create backup files before saving
-- o.updatetime = 100 -- Milliseconds of idle time before CursorHold event fires
-- o.completeopt = { "menuone", "noselect", "popup", "fuzzy" } -- Options for completion menu
-- o.autocomplete = true
-- o.conceallevel = 0 -- Hide markup characters in markdown/latex
-- o.list = true
-- o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
