local M = { "nvim-telescope/telescope.nvim" }

M.tag = "0.1.8"

M.dependencies = {
    "nvim-lua/plenary.nvim"
}

M.keys = {
    { "<C-f><C-f>", "<cmd>Telescope find_files theme=ivy<cr>", desc = "Find files" },
    { "<C-f>", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find words" },
    { "<C-f><C-h>", "<cmd>Telescope help_tags theme=ivy<cr>", desc = "Find help" },
    { "<C-f><C-k>", "<cmd>Telescope keymaps theme=ivy<cr>", desc = "Find keymaps" },
    { "<C-f><C-r>", "<cmd>Telescope registers theme=ivy<cr>", desc = "Find registers" },
    { "<C-f>m", "<cmd>Telescope man_pages theme=ivy<cr>", desc = "Find man pages" },
    { "grr", "<cmd>Telescope lsp_references theme=ivy<cr>", desc = "Find man pages" },
    { "grd", "<cmd>Telescope diagnostics theme=ivy<cr>", desc = "Find man pages" },
}

return M
