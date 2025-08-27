vim.loader.enable()

require("tabline").setup()

vim.g.mapleader = " "
vim.g.maplocalleader = "" -- <C-x>
vim.o.lazyredraw = true
vim.o.updatetime = 300
vim.o.swapfile = false
vim.o.mouse = "a"
vim.o.hidden = true
vim.o.wildmode = "list,full"
vim.o.wildmenu = true
vim.o.laststatus = 0
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.cmdheight = 0
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "no"
vim.o.cursorline = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.winborder = "single"
vim.o.showtabline = 3
vim.o.completeopt = "menu,menuone,noinsert,popup,preview"
vim.o.colorcolumn = "120"
vim.o.undofile = true
vim.o.undolevels = 10000000
vim.o.undoreload = 10000000
vim.o.foldnestmax = 1
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-y>", "3<C-y>")
vim.keymap.set("n", "<C-e>", "3<C-e>")
vim.keymap.set("n", "gh", "diffget \\1")
vim.keymap.set("n", "gl", "diffget \\2")
vim.keymap.set("n", "gw", "<cmd>bp|bd #<cr>", { silent = true })
vim.keymap.set("n", "<localleader><C-f>", ":e <C-r>=expand('%:p:h')<CR>/<C-d>")
vim.keymap.set("n", "<localleader><C-s>", ":sp <C-r>=expand('%:p:h')<CR>/<C-d>")
vim.keymap.set("n", "<localleader><C-v>", ":vs <C-r>=expand('%:p:h')<CR>/<C-d>")
vim.keymap.set("n", "<localleader><C-n>", ":tabnew <C-r>=expand('%:p:h')<CR>/<C-d>")
vim.keymap.set("n", "<M-c>", ":let @+=expand('%')<cr>", { silent = true })
vim.keymap.set("n", "<M-S-c>", ":let @+=expand('%') . ':' . line('.')<cr>", { silent = true })
vim.keymap.set("n", "<C-s>", "<cmd>!tmux neww tmux-sessionizer<cr>", { silent = true })
vim.keymap.set("n", "<leader>n", ":tabnew ~/Dropbox/notes/.md<Left><Left><Left>")
vim.keymap.set("c", "<C-w>", "<backspace><C-w>")
vim.keymap.set("i", "<C-space>", "<C-x><C-o>")

vim.diagnostic.config({
	-- virtual_text = false,
	signs = false,
	virtual_lines = { current_line = true },
	-- jump = { float = true },
	-- float = { source = true }
})

vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
    autocmd TextYankPost * silent! lua vim.hl.on_yank({higroup="IncSearch", timeout=100})
    autocmd FocusGained,BufEnter * checktime
]])

local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- Colors
Plug("https://github.com/vim-scripts/zenesque.vim")
Plug("https://github.com/ntk148v/komau.vim")
Plug("https://github.com/vague2k/vague.nvim")
Plug("https://github.com/craftzdog/solarized-osaka.nvim")
Plug("https://github.com/aktersnurra/no-clown-fiesta.nvim")
-- Utils
Plug("https://github.com/nvim-lua/plenary.nvim")
Plug("https://github.com/nvim-treesitter/nvim-treesitter")
Plug("https://github.com/i0i-i0i/zenmode.nvim")
Plug("https://github.com/i0i-i0i/sessions.nvim")
Plug("https://github.com/jake-stewart/multicursor.nvim")
-- LSP
Plug("https://github.com/mason-org/mason-lspconfig.nvim")
Plug("https://github.com/mason-org/mason.nvim")
Plug("https://github.com/neovim/nvim-lspconfig")
Plug("https://github.com/artemave/workspace-diagnostics.nvim")
Plug("https://github.com/nvimdev/guard.nvim")
Plug("https://github.com/nvimdev/guard-collection")
Plug("https://github.com/bassamsdata/namu.nvim")
-- Tools
Plug("https://github.com/A7Lavinraj/fyler.nvim")
Plug("https://github.com/nvim-telescope/telescope.nvim")
Plug("https://github.com/Exafunction/windsurf.nvim")
Plug("https://github.com/NeogitOrg/neogit")
Plug("https://github.com/sindrets/diffview.nvim")
-- UI
Plug("https://github.com/echasnovski/mini.icons")
Plug("https://github.com/OXY2DEV/markview.nvim")
-- Frontend
Plug("https://github.com/pmizio/typescript-tools.nvim")
Plug("https://github.com/dmmulroy/ts-error-translator.nvim")
-- Python
Plug("https://github.com/joshzcold/python.nvim")
Plug("https://github.com/mfussenegger/nvim-dap")
Plug("https://github.com/mfussenegger/nvim-dap-python")
Plug("https://github.com/neovim/nvim-lspconfig")
Plug("https://github.com/L3MON4D3/LuaSnip", { ["do"] = "make install_jsregexp" })
Plug("https://github.com/nvim-neotest/neotest")
Plug("https://github.com/nvim-neotest/neotest-python")
Plug("https://github.com/Jamsjz/django.nvim")

vim.call("plug#end")

BG = "NONE"
local function set_bg(color)
	color = color or BG
	vim.cmd.hi("Normal guibg=" .. color)
	vim.cmd.hi("CursorLineNr guibg=" .. color)
	vim.cmd.hi("NormalNC guibg=" .. color)
	vim.cmd.hi("EndOfBuffer guibg=" .. color)
	vim.cmd.hi("SignColumn guibg=" .. color)
	vim.cmd.hi("Folded guibg=" .. color)
	vim.cmd.hi("LineNr guibg=" .. color)
	vim.cmd.hi("TabLine guibg=" .. color)
	vim.cmd.hi("TabLineFill guibg=" .. color)
	vim.cmd.hi("StatusLine guibg=" .. color)
	vim.cmd.hi("NormalFloat guibg=" .. color)
	vim.cmd.hi("Float guibg=" .. color)
	vim.cmd.hi("FloatBorder guibg=" .. color)
	vim.cmd.hi("FloatTitle guibg=" .. color)
	vim.cmd.hi("FloatFooter guibg=" .. color)
	vim.cmd.hi("RenderMarkdownCode guibg=" .. color)
	vim.cmd.hi("WinSeparator guibg=" .. color)
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		set_bg()
	end,
})
vim.cmd.colo("no-clown-fiesta")

require("vim._extui").enable({
	enable = true,
	msg = { target = "cmd", timeout = 4000 },
})

local markview_ok, markview = pcall(require, "markview")
if markview_ok then
	markview.setup({ experimental = { check_rtp = false } })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "markdown" },
		callback = function()
			vim.keymap.set("n", "<C-m>", "<cmd>Markview Toggle<cr>", { silent = true })
		end,
	})
else
	print("markview not found")
end

local treesitter_ok, _ = pcall(require, "nvim-treesitter")
if treesitter_ok then
	---@diagnostic disable-next-line
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
		sync_install = false,
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
		textobjects = { enable = true },
	})
end

local zenmode_ok, zenmode = pcall(require, "zenmode.nvim")
if zenmode_ok then
	zenmode.setup({
		default_width = 15,
		options = {
			number = false,
			relativenumber = false,
			foldcolumn = "0",
			list = false,
			signcolumn = "no",
			laststatus = 0,
		},
	})
	vim.keymap.set("n", "<leader>z", "<cmd>ZenmodeToggle<cr>", { silent = true })
else
	print("zenmode not found")
end

local sessions_ok, sessions = pcall(require, "sessions")
if sessions_ok then
	local prev = { name = "", path = "" }
	local builtins = sessions.setup()
	local goto_prev = function(new_session)
		prev = builtins.get_current()
		if new_session.path ~= "" and prev.path ~= new_session.path then
			builtins.attach({ path = new_session.path })
		end
	end
	vim.keymap.set("n", "<leader><C-^>", function()
		if zenmode_ok then
			vim.cmd("ZenmodeClose")
		end
		builtins.save()
		vim.cmd("wa")
		vim.cmd("silent! bufdo bd")
		goto_prev(prev)
	end)
	vim.api.nvim_create_user_command("CustomSessionAttach", function(input)
		prev = builtins.get_current()
		vim.cmd("SessionAttach " .. input.args)
		vim.cmd("ZenmodeOpen")
	end, { nargs = "?" })
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			if zenmode_ok then
				vim.cmd("ZenmodeClose")
			end
			builtins.save()
		end,
	})
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			if vim.fn.argc() == 0 then
				vim.schedule(function()
					vim.cmd("CustomSessionAttach")
				end)
			end
		end,
	})
	vim.keymap.set("n", "<leader>s", "<cmd>CustomSessionAttach<cr>", { desc = "Attach session" })
else
	print("sessions not found")
end

local neogit_ok, neogit = pcall(require, "neogit")
if neogit_ok then
	require("diffview").setup({ use_icons = false })
	neogit.setup()
	vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", { silent = true })
else
	print("neogit not found")
end

local codeium_ok, codeium = pcall(require, "codeium")
if codeium_ok then
	codeium.setup({
		enable_cmp_source = false,
		virtual_text = { enabled = true },
	})
else
	print("codeium not found")
end

local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
	telescope.setup()
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
	vim.keymap.set("n", "", builtin.live_grep, { desc = "Telescope live grep" })
	vim.keymap.set("n", "<C-h>", builtin.help_tags, { desc = "Telescope help tags" })
	vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "Telescope help tags" })
else
	print("Telescope.nvim not found")
end

local mc_ok, mc = pcall(require, "multicursor-nvim")
if mc_ok then
	mc.setup()
	vim.keymap.set({ "n", "v" }, "<A-j>", function()
		mc.lineAddCursor(1)
	end)
	vim.keymap.set({ "n", "v" }, "<A-k>", function()
		mc.lineAddCursor(-1)
	end)
	vim.keymap.set({ "n", "v" }, "<A-S-j>", function()
		mc.lineSkipCursor(1)
	end)
	vim.keymap.set({ "n", "v" }, "<A-S-k>", function()
		mc.lineSkipCursor(-1)
	end)
	vim.keymap.set({ "n", "v" }, "<A-n>", function()
		mc.matchAddCursor(1)
	end)
	vim.keymap.set({ "n", "v" }, "<A-p>", function()
		mc.matchAddCursor(-1)
	end)
	vim.keymap.set({ "n", "v" }, "<A-S-n>", function()
		mc.matchSkipCursor(1)
	end)
	vim.keymap.set({ "n", "v" }, "<A-S-p>", function()
		mc.matchSkipCursor(-1)
	end)
	vim.keymap.set({ "n", "v" }, "<A-a>", mc.matchAllAddCursors)
	vim.keymap.set({ "n", "v" }, "<A-l>", mc.nextCursor)
	vim.keymap.set({ "n", "v" }, "<A-h>", mc.prevCursor)
	vim.keymap.set({ "n", "v" }, "<A-x>", mc.deleteCursor)
	vim.keymap.set("n", "<A-leftmouse>", mc.handleMouse)
	vim.keymap.set({ "n", "v" }, "<A-q>", mc.toggleCursor)
	vim.keymap.set({ "n", "v" }, "<A-S-q>", mc.duplicateCursors)
	vim.keymap.set("n", "<esc>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		elseif mc.hasCursors() then
			mc.clearCursors()
		end
	end)
	vim.keymap.set("n", "<C-[>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		elseif mc.hasCursors() then
			mc.clearCursors()
		end
	end)
	vim.keymap.set("n", "<A-g><A-v>", mc.restoreCursors)
	vim.keymap.set("n", "<A-S-a>", mc.alignCursors)
	vim.keymap.set("v", "S", mc.splitCursors)
	vim.keymap.set("v", "I", mc.insertVisual)
	vim.keymap.set("v", "A", mc.appendVisual)
	vim.keymap.set("v", "M", mc.matchCursors)
	vim.keymap.set({ "v", "n" }, "<c-i>", mc.jumpForward)
	vim.keymap.set({ "v", "n" }, "<c-o>", mc.jumpBackward)
else
	print("multicursor-nvim not found")
end

local fyler_ok, fyler = pcall(require, "fyler")
if fyler_ok then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "fyler" },
		callback = function()
			vim.cmd([[
                set <buffer> nonu
                set <buffer> norelativenumber
            ]])
		end,
	})
	fyler.setup({})
	vim.keymap.set("n", "<C-b>", "<cmd>Fyler kind=float<cr>", { noremap = true })
else
	print("fyler not found")
end

local mason_ok, mason = pcall(require, "mason")
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if mason_ok and mason_lspconfig_ok then
	vim.lsp.config("*", {
		on_attach = function(client, bufnr)
			local workspace_diagnostics_ok, workspace_diagnostics = pcall(require, "workspace-diagnostics")
			if not workspace_diagnostics_ok then
				return
			end
			workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
		end,
	})
	mason.setup()
	mason_lspconfig.setup({
		ensure_installed = {
			"basedpyright",
			"ruff",
			"clangd",
			"bashls",
			"lua_ls",
			"cssls",
			"css_variables",
			"emmet_ls",
			"html",
			"jsonls",
		},
	})
else
	print("mason or mason-lspconfig not found")
end

local guard_ok, ft = pcall(require, "guard.filetype")
if guard_ok then
	ft("typescript,javascript,typescriptreact,javascriptreact"):lint("eslint_d"):fmt("prettierd")
	ft("html,htmldjango,css"):fmt("prettierd")
	ft("cpp,c"):lint({
		cmd = "cpplint",
		args = { "--quiet" },
		stdin = true,
	})
	ft("python"):fmt("ruff")
	ft("lua"):fmt("stylua")
else
	print("guard not found")
end

local namu_ok, namu = pcall(require, "namu")
if namu_ok then
	namu.setup()
	vim.keymap.set("n", "grd", "<cmd>Namu diagnostics<cr>", { silent = true })
	vim.keymap.set("n", "grD", "<cmd>Namu diagnostics workspace<cr>", { silent = true })
	vim.keymap.set("n", "grc", "<cmd>Namu call both<cr>", { silent = true })
	vim.keymap.set("n", "<leader>t", "<cmd>Namu colorscheme<cr>", { silent = true })
	vim.keymap.set("n", "<C-f>", "<cmd>Namu workspace<cr>", { silent = true })
	vim.keymap.set("n", "<C-j>", "<cmd>Namu symbols<cr>", { silent = true })
	vim.keymap.set("n", "<C-k>", "<cmd>Namu watchtower<cr>", { silent = true })
else
	print("namu not found")
end

local python_ok, python = pcall(require, "python")
if python_ok then
	python.setup()
else
	print("python not found")
end

local django_ok, django = pcall(require, "django")
if django_ok then
	django.setup()
else
	print("django not found")
end
