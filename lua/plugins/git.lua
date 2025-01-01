local M = { "lewis6991/gitsigns.nvim" }

M.lazy = true
M.event = { "BufRead", "BufNewFile" }

M.config = function ()
	require("gitsigns").setup()
end

M.keys = function()
	local gitsigns = require("gitsigns")
	return {
		{ "<leader>gs", gitsigns.stage_hunk, desc = "Git Stage Hunk" },
		{ "<leader>gp", gitsigns.preview_hunk, desc = "Git Preview Hunk" },
		{ "<leader>gS", gitsigns.show, desc = "Git Show Previus Version" },
		{ "<leader>gd", gitsigns.diffthis, desc = "Git Show Diff" },
		{ "]h", gitsigns.next_hunk, desc = "Goto next hunk" },
		{ "[h", gitsigns.prev_hunk, desc = "Goto previous hunk" },
	}
end

return M
