local M = { "kristijanhusak/vim-dadbod-ui" }

M.dependencies = {
	{ "tpope/vim-dadbod", lazy = true },
	{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }
}

M.cmd = {
	"DBUI",
	"DBUIToggle",
	"DBUIAddConnection",
	"DBUIFindBuffer",
}

M.init = function()
	vim.g.db_ui_use_nerd_fonts = 1
	vim.cmd([[
		autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
	]])
end

M.keys = {
	{ "<C-g><C-d>", "<cmd>tabnew<cr><cmd>DBUIToggle<cr>", desc = "Open DataBase UI", silent = true }
}

return M
