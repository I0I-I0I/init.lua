local M = { "NeogitOrg/neogit" }

M.config = function()
	require("neogit").setup({
		commit_editor = { kind = "split" },
		commit_select_view = { kind = "vsplit" },
		commit_view = { kind = "vsplit" },
		log_view = { kind = "floating" },
		rebase_editor = { kind = "auto" },
		reflog_view = { kind = "floating" },
		merge_editor = { kind = "auto" },
		description_editor = { kind = "auto" },
		tag_editor = { kind = "auto" },
		preview_buffer = { kind = "floating_console" },
		popup = { kind = "split" },
		stash = { kind = "vsplit" },
		refs_view = { kind = "floating" },
	})
end

M.keys = {
	{ "<leader>g", "<cmd>Neogit<cr>", desc = "Open git", { silent = true } }
}

return M
