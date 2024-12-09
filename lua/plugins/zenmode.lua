local local_plugins = vim.fn.stdpath("config") .. "/plugins/"

local M = { dir = local_plugins .. "zenmode" }

M.cmd = {
	"ZenmodeToggle",
	"ZenmodeCloseAll",
	"ZenmodeClose",
	"ZenmodeOpenAll",
	"ZenmodeOpen"
}

M.keys = function()
	local o = vim.opt
	local defaults = {
		rnu = o.rnu,
		nu = o.nu,
		laststatus = o.laststatus,
		fillchars = o.fillchars,
		foldlevel = o.foldlevel
	}

	local on_open = {
		fillchars = "eob:\\u00A0,vert:\\u00A0",
		rnu = false,
		nu = false,
		laststatus = 0,
		foldlevel = 0
	}

	local function setOpts(arr)
		for key, value in pairs(arr) do
			o[key] = value
		end
	end

	return {
		{ "<leader>zf",  function()
				vim.cmd("ZenmodeOpenAll 40")
				setOpts(on_open)
			end, { silent = true } },

		{ "<leader>zo",  function()
				setOpts(defaults)
				o.fillchars = "eob:\\u00A0,vert:\\u00A0"
				o.foldlevel = 0
				vim.cmd("ZenmodeOpenAll 20")
			end, { silent = true } },

		{ "<leader>zc", function()
				vim.cmd("ZenmodeCloseAll")
				setOpts(defaults)
			end, { silent = true } }
	}
end

return M
