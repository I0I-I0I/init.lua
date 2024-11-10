--
-- Config
--
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
vim.opt.rnu = true
vim.opt.nu = true

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

--
-- Mappings
--
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "''", "''zz")
vim.keymap.set("n", "<C-y>", "3<C-y>")
vim.keymap.set("n", "<C-e>", "3<C-e>")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<cr>zz", { table.insert(opts, { desc = "Next qfix" }) })
vim.keymap.set("n", "<C-p>", "<cmd>cprevious<cr>zz", { table.insert(opts, { desc = "Previous qfix" }) })

vim.keymap.set("n", "<leader><leader>", "<cmd>nohlsearch<cr>", { table.insert(opts, { desc = "Turn off search highlight" }) })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set("n", "<C-t>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
vim.keymap.set("n", "<C-Space>", "<cmd>silent !tmux-yazi<cr>")

vim.keymap.set("v", "x", '"_x')
vim.keymap.set({ "n", "v" }, "Y", '"+y')
vim.keymap.set("x", "P", '"0P')

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.*",
	callback = function ()
		vim.keymap.set("n", "-", "mB<cmd>Ex<cr>",
		{ desc = "Open netrw", silent = true, buffer = true })
	end
})

--
-- Plugins
--
local lazypath = vim.fn.stdpath("data") .. "/lazy-mini/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "plugins",
	change_detection = { notify = false },
	root = vim.fn.stdpath("data") .. "/lazy-mini",
	state = vim.fn.stdpath("state") .. "/lazy-mini/state.json",
})

require("theme")
