vim.loader.enable()

vim.opt.termguicolors = true
vim.opt.undodir = "/mnt/d/undo"
vim.opt.undofile = true
vim.opt.undolevels = 10000000
vim.opt.undoreload = 10000000
vim.opt.swapfile = false
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "node_modules/,^\\.\\=/\\=$,^\\.\\.\\=/\\=$"
vim.opt.smartindent = true
vim.opt.expandtab = false -- false == tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.completeopt = { "menu", "menuone", "fuzzy", "noselect", "popup" }
vim.opt.linebreak = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.*",
	command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 100,
		})
	end,
})
