local M = { "augmentcode/augment.vim" }

M.cond = true

M.lazy = false

vim.g.augment_workspace_folders = {
    "~/code/personal/real-time-chat/",
    "~/code/personal/track-mouse/"
}

M.keys = {
    { "<localleader><C-a>c", "<cmd>Augment chat<cr>", mode = { "n", "v" } },
    { "<localleader><C-a>t", "<cmd>Augment chat-toggle<cr>" },
    { "<localleader><C-a>n", "<cmd>Augment chat-new<cr>" },
    { "<localleader><C-a>s", "<cmd>Augment status<cr>" }
}

return M
