local ok, python = pcall(require, "python")
if not ok then
    print("You need to install python.nvim")
    return
end

ok, _ = pcall(require, "nvim-treesitter")
if not ok then
    print("You need to install treesetter")
    return
end

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

python.setup()
