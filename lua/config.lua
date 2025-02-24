vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "node_modules/,^\\.\\=/\\=$,^\\.\\.\\=/\\=$"
vim.g.netrw_altfile = 1
vim.g.netrw_fastbrowse = 0

vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000000
vim.opt.undoreload = 10000000
vim.opt.swapfile = false
vim.opt.lazyredraw = true
vim.opt.grepprg = "rg --vimgrep --hidden --smart-case --no-heading --trim --follow --glob '!libs'"
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.smartindent = true
vim.opt.expandtab = true -- false == tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
-- vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup", "fuzzy" }
vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup", "nosort" }
vim.opt.linebreak = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.wildignore:append("*/node_modules/*,*/dist/*,*/build/*,*/env/*,/usr/include/*,/usr/local/include/*")
vim.opt.path = "**"

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})

vim.cmd([[
    augroup vimrc_autocmds
        autocmd!
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
        autocmd FileType fugitive nmap q <cmd>clo<cr>
        autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
        autocmd BufWritePre * %s/\s\+$//e
        autocmd FocusGained,BufEnter * checktime
        autocmd FileType netrw setl bufhidden=wipe
    augroup END
]])

local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = ""

vim.keymap.set("c", "W!","w !sudo tee > /dev/null %")
vim.keymap.set("n", "-", "<cmd>Ex<cr>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*","*zzzv")
vim.keymap.set("n", "#","#zzzv")
vim.keymap.set("n", "<leader>j", "<cmd>bn<cr>", opts)
vim.keymap.set("n", "<leader>k", "<cmd>bp<cr>", opts)
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true, noremap = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true, noremap = true })
vim.keymap.set("n", "<C-y>", "3<C-y>", opts)
vim.keymap.set("n", "<C-e>", "3<C-e>", opts)
vim.keymap.set("n", "<C-w>C", "<cmd>tabc<cr>", { silent = true })
vim.keymap.set("n", "<C-z>", "<cmd>bd<cr>", { silent = true })
vim.keymap.set("n", "<leader><C-z>", "<cmd>bd!<cr>", { silent = true })
vim.keymap.set("n", "<leader><leader>", "<cmd>nohl<cr>", { silent = true })
vim.keymap.set("n", "<A-o>", "<cmd>tabn<cr>", { silent = true })
vim.keymap.set("n", "<A-i>", "<cmd>tabp<cr>", { silent = true })
vim.keymap.set("n", "<A-O>", "<cmd>tabmove +<cr>", { silent = true })
vim.keymap.set("n", "<A-I>", "<cmd>tabmove -<cr>", { silent = true })

vim.keymap.set("n", "<leader>q", "<cmd>copen | wincmd p<cr>", { silent = true })
vim.keymap.set("n", "<C-n>", "<cmd>cn<cr>zz", { silent = true })
vim.keymap.set("n", "<C-p>", "<cmd>cp<cr>zz", { silent = true })

vim.keymap.set("c", "<C-b>", "<Left>", { noremap = true })
vim.keymap.set("c", "<A-b>", "<C-Left>", { noremap = true })
vim.keymap.set("c", "<C-f>", "<Right>", { noremap = true })
vim.keymap.set("c", "<A-f>", "<C-Right>", { noremap = true })
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true })
vim.keymap.set("c", "<C-d>", "<Del>", { noremap = true })
vim.keymap.set("c", "<A-d>", "<C-Del>", { noremap = true })

vim.keymap.set("n", "<C-t>", "<cmd>silent !tmux neww tmux-sessionizer<cr>", { desc = "Sessionizer" })
vim.keymap.set("n", "<C-Space>", function () vim.cmd("silent !tmux neww tmux-yazi " .. vim.fn.expand("%:p:h")) end, { desc = "Yazi" })
