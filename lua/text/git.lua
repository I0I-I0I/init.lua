local ok, git = pcall(require, "neogit")
if not ok then
    print("NeoGit is not installed")
    return
end

local ok, diffview = pcall(require, "diffview")
if not ok then
    print("DiffView is not installed")
    return
end

vim.keymap.set("n", "<localleader>g", "<cmd>Neogit<cr>", { desc = "Open neogit", silent = true })
vim.keymap.set("n", "<localleader><C-g>d", "<cmd>DiffviewOpen<cr>", { desc = "Open diffview", silent = true } )
vim.keymap.set("n", "<localleader><C-g>c", "<cmd>DiffviewClose<cr>", { desc = "Close diffview", silent = true } )
vim.keymap.set("n", "<localleader><C-g>r", "<cmd>DiffviewRefresh<cr>", { desc = "Refresh diffview", silent = true } )
vim.keymap.set("n", "<localleader><C-g>L", "<cmd>DiffviewFileHistory<cr>", { desc = "Open history", silent = true })

diffview.opts = { use_icons = false }
