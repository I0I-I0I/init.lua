local M = { "NeogitOrg/neogit" }

M.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim"
}

M.config = true

M.keys = {
	{ "<leader>g", "<cmd>Neogit<cr>", desc = "Open git", { silent = true } },
}

return M
