local M = {}

local function get_hl(name)
	local hl = vim.api.nvim_get_hl(0, {
		name = name,
		link = false,
	})
	return hl
end

local function color(value, fallback)
	if value then
		return string.format("#%06x", value)
	end
	return fallback
end

local function get_theme_colors()
	local normal = get_hl("Normal")
	local statusline = get_hl("StatusLine")
	local diff_add = get_hl("DiffAdd")
	local diff_change = get_hl("DiffChange")
	local diff_delete = get_hl("DiffDelete")
	local diagnostic_error = get_hl("DiagnosticError")
	local diagnostic_warn = get_hl("DiagnosticWarn")
	local diagnostic_info = get_hl("DiagnosticInfo")
	local diagnostic_hint = get_hl("DiagnosticHint")
	local normal_fg = color(normal.fg, "#ebdbb2")
	local normal_bg = color(normal.bg, "NONE")
	local statusline_fg = color(statusline.fg, normal_fg)
	local statusline_bg = color(statusline.bg, normal_bg)
	return {
		normal_fg = normal_fg,
		normal_bg = normal_bg,
		statusline_fg = statusline_fg,
		statusline_bg = statusline_bg,
		mode_bg = color(get_hl("ModeMsg").bg, statusline_bg),
		mode_fg = color(get_hl("ModeMsg").fg, statusline_fg),
		git_bg = color(get_hl("Directory").bg, statusline_bg),
		git_fg = color(get_hl("Directory").fg, statusline_fg),
		add = color(diff_add.fg, "#89b482"),
		change = color(diff_change.fg, "#d8a657"),
		delete = color(diff_delete.fg, "#ea6962"),
		error = color(diagnostic_error.fg, "#ea6962"),
		warn = color(diagnostic_warn.fg, "#d8a657"),
		info = color(diagnostic_info.fg, "#7daea3"),
		hint = color(diagnostic_hint.fg, "#a9b665"),
		location_bg = color(get_hl("CursorLine").bg, statusline_bg),
		location_fg = color(get_hl("CursorLine").fg, statusline_fg),
		percent_bg = color(get_hl("Search").bg, statusline_bg),
		percent_fg = color(get_hl("Search").fg, statusline_fg),
	}
end

local function hi(group, opts)
	local cmd = { "highlight!", group }
	if opts.guibg then
		table.insert(cmd, "guibg=" .. opts.guibg)
	end
	if opts.guifg then
		table.insert(cmd, "guifg=" .. opts.guifg)
	end
	if opts.gui then
		table.insert(cmd, "gui=" .. opts.gui)
	end
	vim.cmd(table.concat(cmd, " "))
end

local function setup_highlights()
	local colors = get_theme_colors()
	hi("StatusLine", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})
	hi("StatusLineNC", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})
	hi("StatusMode", {
		guibg = colors.mode_bg,
		guifg = colors.mode_fg,
		gui = "bold",
	})
	hi("StatusModeToNorm", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})
	hi("StatusGit", {
		guibg = colors.git_bg,
		guifg = colors.git_fg,
		gui = "bold",
	})
	hi("StatusGitToNorm", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})
	hi("StatusDiffAdd", {
		guibg = colors.statusline_bg,
		guifg = colors.add,
		gui = "bold",
	})
	hi("StatusDiffChange", {
		guibg = colors.statusline_bg,
		guifg = colors.change,
		gui = "bold",
	})
	hi("StatusDiffDelete", {
		guibg = colors.statusline_bg,
		guifg = colors.delete,
		gui = "bold",
	})
	hi("StatusFile", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
		gui = "bold",
	})
	hi("StatusFileToNorm", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})
	hi("StatusLSP", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
		gui = "bold",
	})
	hi("StatusLSPToNorm", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})

	hi("StatusErrorIcon", {
		guibg = colors.statusline_bg,
		guifg = colors.error,
		gui = "bold",
	})
	hi("StatusWarnIcon", {
		guibg = colors.statusline_bg,
		guifg = colors.warn,
		gui = "bold",
	})

	hi("StatusInfoIcon", {
		guibg = colors.statusline_bg,
		guifg = colors.info,
		gui = "bold",
	})
	hi("StatusHintIcon", {
		guibg = colors.statusline_bg,
		guifg = colors.hint,
	})

	hi("StatusBuffer", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})

	hi("StatusType", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})
	hi("StatusTypeToNorm", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})

	hi("StatusNorm", {
		guibg = colors.statusline_bg,
		guifg = colors.statusline_fg,
	})

	hi("StatusLocation", {
		guibg = colors.location_bg,
		guifg = colors.location_fg,
	})

	hi("StatusPercent", {
		guibg = colors.percent_bg,
		guifg = colors.percent_fg,
		gui = "bold",
	})
end

local fn = vim.fn
local _diag_cache = {} -- [bufnr] -> { e=n, w=n, i=n, h=n }

vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function(args)
		local buf = args.buf
		local sev = vim.diagnostic.severity
		local counts = vim.diagnostic.count(buf)
		_diag_cache[buf] = {
			e = counts[sev.ERROR] or 0,
			w = counts[sev.WARN] or 0,
			i = counts[sev.INFO] or 0,
			h = counts[sev.HINT] or 0,
		}
	end,
})

local _wc_state = { words = 0, timer = nil }

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter" }, {
	callback = function()
		local ft = vim.bo.filetype
		if not (ft:match("md") or ft:match("markdown") or ft == "text") then
			return
		end
		if _wc_state.timer then
			_wc_state.timer:stop()
			_wc_state.timer:close()
		end
		_wc_state.timer = vim.defer_fn(function()
			_wc_state.timer = nil
			_wc_state.words = fn.wordcount().words or 0
		end, 500)
	end,
})

local _icon_cache = {} -- [bufnr] -> icon string

vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
	callback = function(args)
		_icon_cache[args.buf] = nil
	end,
})

local function get_git_branch()
	local ok, mini_git = pcall(require, "mini.git")
	if not ok then
		return ""
	end
	local data = mini_git.get_buf_data(0)
	if not data or not data.head_name or data.head_name == "" then
		return ""
	end
	local repo_name = data.root and vim.fn.fnamemodify(data.root, ":t") or ""
	if repo_name == "" then
		return data.head_name
	end
	return repo_name .. "/" .. data.head_name
end

local function build_git_diff()
	local data = require("mini.diff").get_buf_data(0)
	if not data or not data.summary then
		return ""
	end
	local summary = data.summary
	local added = summary.add or 0
	local changed = summary.change or 0
	local deleted = summary.delete or 0
	local diff_str = ""
	if added > 0 then
		diff_str = diff_str .. "%#StatusDiffAdd# " .. added .. " "
	end
	if changed > 0 then
		diff_str = diff_str .. "%#StatusDiffChange# " .. changed .. " "
	end
	if deleted > 0 then
		diff_str = diff_str .. "%#StatusDiffDelete# " .. deleted .. " "
	end
	if diff_str == "" then
		return ""
	end
	return diff_str .. "%#StatusLine#"
end

-- Diagnostics symbols
local function get_diagnostics()
	local buf = vim.api.nvim_get_current_buf()
	local c = _diag_cache[buf] or {}
	local s = ""
	if (c.e or 0) > 0 then
		s = s .. "%#StatusErrorIcon# " .. c.e .. " "
	end
	if (c.w or 0) > 0 then
		s = s .. "%#StatusWarnIcon# " .. c.w .. " "
	end
	if (c.i or 0) > 0 then
		s = s .. "%#StatusInfoIcon# " .. c.i .. " "
	end
	if (c.h or 0) > 0 then
		s = s .. "%#StatusHintIcon# " .. c.h .. " "
	end
	if s == "" then
		return ""
	end
	return s .. "%#StatusLine#" -- reset to StatusLine for following text
end

-- File icon
local function get_file_icon()
	local bufnr = vim.api.nvim_get_current_buf()
	if _icon_cache[bufnr] ~= nil then
		return _icon_cache[bufnr]
	end
	local name = vim.api.nvim_buf_get_name(bufnr)
	local filename = vim.fn.fnamemodify(name, ":t")
	local icon = require("mini.icons").get("file", filename)
	local result = icon and icon .. " " or ""
	_icon_cache[bufnr] = result
	return result
end

-- Word count & reading time
local function word_reading()
	local ft = vim.bo.filetype
	if ft:match("md") or ft:match("markdown") or ft == "text" then
		local w = _wc_state.words
		if w == 0 then
			return ""
		end
		return w .. "w " .. " " .. math.ceil(w / 200) .. "m"
	end
	return ""
end

-- Mode icons
local mode_icons = {
	n = " N",
	c = " C",
	t = " T",
	i = " I",
	R = " R",
	V = " V-L",
	[""] = " V-B", -- Visual Block
	r = " R-P",
	v = " V",
}

-- 4) Build statusline
function M.build()
	local st = ""

	-- A: mode
	local m = fn.mode()
	st = st .. "%#StatusMode# " .. (mode_icons[m] or m) .. " " .. "%#StatusModeToNorm#"

	-- B: git
	local br = get_git_branch()
	if br ~= "" then
		st = st .. "%#StatusGit# " .. " " .. br .. " " .. "%#StatusGitToNorm#"

		local git_diff = build_git_diff()
		if git_diff ~= "" then
			st = st .. git_diff .. "%#StatusGitToNorm#"
		end
	end

	-- C: filename
	-- local fnm = fn.expand("%:t")
	local fnm = fn.expand("%:.")
	if fnm ~= "" then
		st = st .. "%#StatusFile# " .. fnm .. " " .. (vim.bo.modified and " " or "") .. "%#StatusFileToNorm#"
	end

	local di = get_diagnostics()
	if di ~= "" then
		st = st .. di
	end

	-- right align
	st = st .. "%="

	-- LSP progress (e.g. "indexing…" from language servers)
	local progress = vim.ui.progress_status and vim.ui.progress_status() or ""
	if progress ~= "" then
		st = st .. "%#StatusLSP# " .. progress .. " %#StatusLine#"
	end

	-- X: filetype
	local ft = vim.bo.filetype
	if ft ~= "" then
		st = st .. "%#StatusType# " .. get_file_icon() .. ft .. "%#StatusTypeToNorm#"
	end

	-- Y: word/reading
	local wr = word_reading()
	if wr ~= "" then
		st = st .. "%#StatusBuffer# " .. " " .. wr
	end

	-- Z: encoding, format, location, percent
	st = st
		.. "%#StatusBuffer# "
		.. vim.bo.fileencoding
		.. " "
		.. vim.bo.fileformat
		.. " "
		.. "%#StatusLocation# %l:%c "
		.. "%#StatusPercent# %p%% "

	return st
end

vim.opt.laststatus = 3 -- global statusline
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.o.statusline = "%!v:lua.require('config.statusline').build()"

setup_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		setup_highlights()
		vim.cmd("redrawstatus")
	end,
})

return M
