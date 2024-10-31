local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "''", "''zz")
vim.keymap.set("n", "<C-y>", "3<C-y>")
vim.keymap.set("n", "<C-e>", "3<C-e>")

vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set("n", "-", "<cmd>Ex<cr>", { desc = "Toggle netrw", silent = true })
vim.keymap.set("n", "<leader><leader>", "<cmd>nohlsearch<cr>", { table.insert(opts, { desc = "Turn off search highlight" }) })
vim.keymap.set("n", "<C-n>", "<cmd>cnext<cr>", { table.insert(opts, { desc = "Next qfix" }) })
vim.keymap.set("n", "<C-p>", "<cmd>cprevious<cr>", { table.insert(opts, { desc = "Previous qfix" }) })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")

vim.keymap.set({ "v", "n" }, "x", '"_x')
vim.keymap.set({ "v", "n" }, "X", '"_X')
vim.keymap.set({ "v", "n" }, "s", '"_s')
vim.keymap.set({ "v", "n" }, "S", '"_S')
vim.keymap.set("x", "P", '"0P')
