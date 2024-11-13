local M = { 'kristijanhusak/vim-dadbod-ui' }

M.dependencies = {
	{ 'tpope/vim-dadbod', lazy = true },
	{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
}

M.cmd = {
	'DBUI',
	'DBUIToggle',
	'DBUIAddConnection',
	'DBUIFindBuffer',
}

M.init = function()
	vim.g.db_ui_use_nerd_fonts = 1
	vim.cmd([[
		autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
	]])
end

M.keys = {
	{ "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Open DataBase UI", silent = true }
}

return M
-- local M = {
--   "kndndrj/nvim-dbee",
-- }
--
-- M.dependencies = {
-- 	"MunifTanjim/nui.nvim",
-- }
--
-- M.build = function()
-- 	require("dbee").install()
-- end
--
-- M.config = function()
-- 	require("dbee").setup()
-- end
--
-- return M
