local M = { "ThePrimeagen/harpoon" }

M.branch = "harpoon2"

M.config = function()
	local harpoon = require("harpoon")
	harpoon:setup()
end

M.keys = function()
	local harpoon = require("harpoon")

	return {
		{
			"<leader>a",
			function()
				harpoon:list():add()
			end,
			desc = "Add file (Harpoon)",
		},
		{
			"",
			function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Open list of files (Harpoon)",
		},
		{
			"<C-s>",
			function()
				harpoon:list():select(1)
			end,
			desc = "Select 1 (Harpoon)",
		},
		{
			"<C-h>",
			function()
				harpoon:list():select(2)
			end,
			desc = "Select 2 (Harpoon)",
		},
		{
			"<C-j>",
			function()
				harpoon:list():select(3)
			end,
			desc = "Select 3 (Harpoon)",
		},
		{
			"<C-k>",
			function()
				harpoon:list():select(4)
			end,
			desc = "Select 4 (Harpoon)",
		},
		{
			"<C-l>",
			function()
				harpoon:list():select(5)
			end,
			desc = "Select 5 (Harpoon)",
		},
	}
end

return M
