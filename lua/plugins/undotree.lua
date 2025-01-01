local M = { "mbbill/undotree" }

M.init = function()
	vim.g.undotree_WindowLayout = 3
end

M.keys = {
	{ "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Open UndoTree" }
}

return M
