local M = { "nvim-telescope/telescope.nvim" }

M.tag = "0.1.8"

M.dependencies = {
    "nvim-lua/plenary.nvim"
}

M.keys = {
    { "<C-f><C-f>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Find words" },
    { "<C-f><C-h>", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
    { "<C-f><C-k>", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
    { "<C-f><C-r>", "<cmd>Telescope registers<cr>", desc = "Find registers" },
    { "<C-f>\", "<cmd>Telescope man_pages<cr>", desc = "Find man pages" },
}

return M
