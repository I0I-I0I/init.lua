local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    print("nvim-treesitter not found")
    return
end

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

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
