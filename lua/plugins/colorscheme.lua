function SetColor(color, bg)
	vim.cmd.colorscheme(color)
	vim.opt.bg = "dark"
	if color == "quiet" then
		vim.opt.bg = "light"
	end
	if bg == "" then return end
	vim.cmd.hi("Normal guibg=" .. bg)
	vim.cmd([[
		hi NormalNC guibg=Normal
		hi EndOfBuffer guibg=Normal
		hi LineNr guibg=Normal
		hi SignColumn guibg=Normal
		hi StatusLine guibg=#262626 guifg=#b6bbc4
	]])
end

vim.api.nvim_create_user_command("SetColor", function(input)
	if input.fargs[2] == nil then
		input.fargs[2] = ""
	end
	local cmd = "SetColor(\"" .. input.fargs[1] .. "\", \"" .. input.fargs[2] .. "\")"
	local init = vim.fn.expand(vim.fn.stdpath("config") .. "/lua/theme.lua")
	local job_cmd = "echo '" .. cmd .. "' > " .. init
	vim.fn.jobstart(job_cmd)
	SetColor(input.fargs[1], input.fargs[2])
end,
{
	desc = "Set colorscheme",
	nargs = "*",
	complete = function()
		return {
			"OceanicNext",
			"solarized-osaka",
			"habamax",
			"lunaperche",
			"retrobox",
			"quiet",
		}
	end
})

return {
	{ "mhartington/oceanic-next",
		config = function()
			vim.cmd([[
			let g:oceanic_next_terminal_bold = 1
			let g:oceanic_next_terminal_italic = 1
			]])
		end
	},
	{ "craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false
		},
	}
}
