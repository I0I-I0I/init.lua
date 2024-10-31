local M = { "mhartington/oceanic-next" }

M.config = function ()
	vim.cmd.colorscheme("OceanicNext")
	local color = "#000000"
	vim.cmd.hi("Normal guibg=" .. color)
	vim.cmd([[
		hi NormalNC guibg=Normal
		hi EndOfBuffer guibg=Normal
		hi LineNr guibg=Normal
		hi SignColumn guibg=Normal
	]])
end

return M
