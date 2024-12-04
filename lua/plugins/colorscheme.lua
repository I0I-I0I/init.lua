return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function ()
			function SetColor(color, bg)
				vim.opt.bg = "dark"
				vim.cmd.colorscheme(color)
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
						"rose-pine",
					}
				end
			})
		end
	},
}
