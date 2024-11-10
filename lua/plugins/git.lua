local M = { "NeogitOrg/neogit" }

M.config = true

M.keys = {
	{ "<leader>g", "<cmd>Neogit<cr>", desc = "Open git", { silent = true } },
}

return M
