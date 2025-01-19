vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "node_modules/,^\\.\\=/\\=$,^\\.\\.\\=/\\=$"
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000000
vim.opt.undoreload = 10000000
vim.opt.swapfile = false
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.smartindent = true
vim.opt.expandtab = true -- false == tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.completeopt = { "menu", "menuone", "fuzzy", "noinsert", "popup" }
vim.opt.linebreak = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.rnu = true
vim.opt.nu = true
vim.opt.path = "**"
vim.opt.wildignore:append("*/node_modules/*,*/dist/*,*/build/*,*/env/*")

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


local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-y>", "3<C-y>", opts)
vim.keymap.set("n", "<C-e>", "3<C-e>", opts)
vim.keymap.set("n", "<leader><leader>", "<cmd>nohl<cr>")
vim.keymap.set("n", "-", "<cmd>Ex<cr>")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true, noremap = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true, noremap = true })
vim.keymap.set("x", "P", '"0P')
vim.keymap.set("n", "<C-t>", "<cmd>silent !tmux neww tmux-sessionizer<cr>", { desc = "Sessionizer" })
vim.keymap.set("n", "R", function ()
    vim.ui.input({ prompt = "Run: " }, function (input)
        if not input or input == "" then return end
        vim.cmd("silent !tmux neww tmux-run " .. input)
    end)
end, { desc = "Run terminal app" })
vim.keymap.set("n", "<C-Space>", function ()
    local current_path = vim.fn.expand("%:p:h")
    vim.cmd("silent !tmux neww tmux-yazi " .. current_path)
end, { desc = "Yazi" })
