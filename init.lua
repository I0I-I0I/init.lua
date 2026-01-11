vim.loader.enable()

-- Theme
vim.o.bg = "dark"
vim.pack.add({ "https://github.com/ntk148v/komau.vim" })

vim.cmd.colo("komau")
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#222222" })

-- Settings
vim.g.mapleader = " "
vim.o.lazyredraw = true
vim.o.swapfile = false
vim.o.wildmode = "longest:list,full"
vim.o.wildmenu = true
vim.o.laststatus = 3
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "80"
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.completeopt = "menu,menuone,noinsert,popup,fuzzy"
vim.o.undofile = true
vim.o.undolevels = 10000000
vim.o.undoreload = 10000000
vim.o.grepprg = "rg --vimgrep --no-heading"
vim.o.path = "**"
vim.o.wildignore =
    "**/node_modules/**,**/.git/**,**/__pycache__/**,**/.mypy_cache/**,**/.venv/**,**/.pytest_cache/**,**/.ruff_cache/**"
vim.o.spell = true
vim.o.spelllang = "en,ru"

-- Abbreviations
vim.cmd.cabbrev("W w")
vim.cmd.cabbrev("Wa wa")
vim.cmd.cabbrev("n norm")

-- Keymaps

-- duplicate current line
vim.keymap.set({ "n", "i", "v" }, "<C-l>", "<cmd>t.<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<C-f>", "<C-\\><C-n>:sp <C-r>=expand('%:p:h')<cr>/<C-d>", { noremap = true })
vim.keymap.set("n", "<C-\\><C-f>", "<C-\\><C-n>:sp <C-r>=getcwd()<cr>/<C-d>", { noremap = true })
vim.keymap.set({ "i", "n" }, "<C-p>", "<esc>:sf ", { noremap = true })
vim.keymap.set("n", "<C-\\><C-t>", "<cmd>e ~/TODO.md<cr>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { silent = true, noremap = true })

vim.keymap.set("n", "<C-d>", "<cmd>keepjumps normal! <C-d><cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-u>", "<cmd>keepjumps normal! <C-u><cr>", { silent = true, noremap = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true, noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, noremap = true })

vim.keymap.set({ "t", "n", "i" }, "<M-i>", "<cmd>tabprevious<cr>", { silent = true, noremap = true })
vim.keymap.set({ "t", "n", "i" }, "<M-o>", "<cmd>tabnext<cr>", { silent = true, noremap = true })
vim.keymap.set({ "t", "n", "i" }, "<M-S-i>", "<cmd>tabmove -<cr>", { silent = true, noremap = true })
vim.keymap.set({ "t", "n", "i" }, "<M-S-o>", "<cmd>tabmove +<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<M-c>", ":let @+=expand('%:p')<cr>", { silent = true, noremap = true })

-- Auto commands
vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
    autocmd TextYankPost * silent! lua vim.hl.on_yank({higroup="IncSearch", timeout=150})
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   silent! normal! g`"zz |
        \ endif
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p") ]])

-- Plugins
vim.pack.add({ "https://github.com/chentoast/marks.nvim" })

require("marks").setup({ builtin_marks = { ".", "<", ">", "^" } })
