local M = { "nvim-treesitter/nvim-treesitter" }

M.build = ":TSUpdate"
M.lazy = true
M.event = "BufReadPre"

M.config = function()
    local configs = require("nvim-treesitter.configs")

    local highlight = true
    if vim.g.colorscheme.theme == "ocean" then
        highlight = false
    end

    configs.setup({
        ensure_installed = {
            "c",
            "cpp",
            "lua",
            "python",
            "typescript",
            "javascript",
            "vimdoc",
            "vim",
            "html",
            "css",
            "http",
        },
        auto_install = true,
        highlight = { enable = highlight },
        indent = { enable = true },
    })
end

return M
