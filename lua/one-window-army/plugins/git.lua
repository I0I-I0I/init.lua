local fugitive = { "tpope/vim-fugitive" }
local diffview = { "sindrets/diffview.nvim" }

diffview.opts = { use_icons = false }
diffview.keys = {
    { "<localleader><C-g>d", "<cmd>DiffviewOpen<cr>", desc = "Open diffview", { silent = true } },
    { "<localleader><C-g>c", "<cmd>DiffviewClose<cr>", desc = "Close diffview", { silent = true } },
    { "<localleader><C-g>r", "<cmd>DiffviewRefresh<cr>", desc = "Refresh diffview", { silent = true } },
    { "<localleader><C-g>L", "<cmd>DiffviewFileHistory<cr>", desc = "Open history", { silent = true } }
}

return { fugitive, diffview }
