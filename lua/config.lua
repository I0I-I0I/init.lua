vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "node_modules/,^\\.\\=/\\=$,^\\.\\.\\=/\\=$"
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000000
vim.opt.undoreload = 10000000
vim.opt.swapfile = false
vim.opt.lazyredraw = true
vim.opt.grepprg = "rg --vimgrep"
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.smartindent = true
vim.opt.expandtab = true -- false == tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup", "fuzzy" }
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

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*.*",
    callback = function()
        vim.fn.execute("normal! '\"zz", "silent")
    end,
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


local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>j", "<cmd>bn<cr>", opts)
vim.keymap.set("n", "<leader>k", "<cmd>bp<cr>", opts)
vim.keymap.set("n", "<C-y>", "3<C-y>", opts)
vim.keymap.set("n", "<C-e>", "3<C-e>", opts)
vim.keymap.set("n", "<leader><leader>", "<cmd>nohl<cr>")
vim.keymap.set("n", "<C-w>C", "<cmd>tabc<cr>")
vim.keymap.set("n", "<C-t>", "<cmd>silent !tmux neww tmux-sessionizer<cr>", { desc = "Sessionizer" })
vim.keymap.set("n", "<C-Space>", function ()
    local current_path = vim.fn.expand("%:p:h")
    current_path = string.gsub(current_path, "^oil://", "")
    vim.cmd("silent !tmux neww tmux-yazi " .. current_path)
end, { desc = "Yazi" })

vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true, noremap = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true, noremap = true })
vim.keymap.set("x", "P", '"0P')

vim.keymap.set("c", "<C-b>", "<Left>", { noremap = true })
vim.keymap.set("c", "<A-b>", "<C-Left>", { noremap = true })
vim.keymap.set("c", "<C-l>", "<Right>", { noremap = true })
vim.keymap.set("c", "<A-l>", "<C-Right>", { noremap = true })
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true })
vim.keymap.set("c", "<C-d>", "<Del>", { noremap = true })
vim.keymap.set("c", "<A-d>", "<C-Del>", { noremap = true })
