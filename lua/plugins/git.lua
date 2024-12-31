local M = {}

M.neogit = { "NeogitOrg/neogit" }
M.gitsigns = { "lewis6991/gitsigns.nvim" }
M.diffview = { "sindrets/diffview.nvim" }

M.neogit.config = function()
	require("neogit").setup({
		commit_editor = { kind = "floating" },
		commit_select_view = { kind = "floating" },
		commit_view = { kind = "vsplit" },
		log_view = { kind = "floating" },
		rebase_editor = { kind = "auto" },
		reflog_view = { kind = "floating" },
		merge_editor = { kind = "auto" },
		description_editor = { kind = "auto" },
		tag_editor = { kind = "auto" },
		preview_buffer = { kind = "floating_console" },
		popup = { kind = "split" },
		stash = { kind = "floating" },
		refs_view = { kind = "floating" },
	})
end

M.gitsigns.config = function ()
	require("gitsigns").setup()
end

M.diffview.config = function ()
	require("diffview").setup()
end

M.neogit.keys = {
	{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Open git", { silent = true } }
}

return {
	M.neogit,
	M.gitsigns,
	M.diffview,
}
