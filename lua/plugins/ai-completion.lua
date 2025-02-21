local M = { "augmentcode/augment.vim" }

M.cond = true

M.lazy = false

vim.g.augment_workspace_folders = {
    "~/code/personal/real-time-chat/server/",
    "~/code/personal/real-time-chat/frontend/",
    "~/code/personal/track-mouse/"
}

M.keys = {
    { "<leader>ac", "<cmd>Augment chat<cr>", mode = { "n", "v" } },
    { "<leader>at", "<cmd>Augment chat-toggle<cr>" },
    { "<leader>an", "<cmd>Augment chat-new<cr>" },
    { "<leader>as", "<cmd>Augment status<cr>" }
}

return M
