local M = { "lewis6991/gitsigns.nvim" }

M.config = function ()
	require("gitsigns").setup()
end

M.keys = function()
	local gitsigns = require("gitsigns")
	return {
		{ "<leader>gb", gitsigns.blame_line, desc = "Git Blame Line" },
		{ "<leader>gs", gitsigns.stage_hunk, desc = "Git Stage Hunk" },
		{ "<leader>gS", gitsigns.show, desc = "Git Show Previus Version" },
		{ "<leader>gd", gitsigns.diffthis, desc = "Git Show Diff" },
		{ "]h", gitsigns.next_hunk, desc = "Goto next hunk" },
		{ "[h", gitsigns.prev_hunk, desc = "Goto previous hunk" },
	}
end

return M
