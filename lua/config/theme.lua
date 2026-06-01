local M = {}

local themes = {
	{ label = "Rose Pine Dawn", scheme = "rose-pine-dawn" },
	{ label = "Newpaper Light", scheme = "newpaper" },
	{ label = "GitHub Light", scheme = "github_light" },
	{ label = "GitHub Dark", scheme = "github_dark" },
	{ label = "Tokyo Night", scheme = "tokyonight" },
	{ label = "SpaceDuck", scheme = "spaceduck" },
}

local function apply_theme(scheme)
	local ok, err = pcall(vim.cmd.colorscheme, scheme)
	if not ok then
		vim.notify("Failed to load theme '" .. scheme .. "': " .. err, vim.log.levels.ERROR)
	end
	return ok
end

function M.load_default()
	apply_theme("newpaper")
end

function M.select()
	vim.ui.select(themes, {
		prompt = "Select theme",
		format_item = function(item)
			return item.label
		end,
	}, function(choice)
		if not choice then
			return
		end
		if apply_theme(choice.scheme) then
			vim.notify("Theme: " .. choice.label, vim.log.levels.INFO)
		end
	end)
end

return M
