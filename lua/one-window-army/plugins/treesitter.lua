local M = { "nvim-treesitter/nvim-treesitter" }

M.build = ":TSUpdate"

M.config = function ()
    local configs = require("nvim-treesitter.configs")
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
        highlight = { enable = true },
        indent = { enable = true },
    })
end

return M
