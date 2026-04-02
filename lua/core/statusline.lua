---=============================================================================
--- Builin
--------------------------------------------------------------------------------
--- Statusline ====================================================================
Statusline = {}

function Statusline.active()
	-- `%P` shows the scroll percentage but says 'Bot', 'Top' and 'All' as well.
	return "[%f]%=%y [%P %l:%c]"
end

function Statusline.inactive()
	return " %t"
end
