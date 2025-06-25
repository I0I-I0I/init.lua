local ok, mason = pcall(require, 'mason')
if not ok then
    print("Mason is not installed")
    return
end

local ok, lint = pcall(require, 'lint')
if not ok then
    print("Lint is not installed")
    return
end

local ok, format = pcall(require, 'conform')
if not ok then
    print("conform.nvim is not installed")
    return
end

-- Config --

mason.setup()

format.setup({
    formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        htmldjango = { "prettierd" },
        css = { "prettierd" },
    },
    -- format_on_save = {
    --     timeout_ms = 500,
    --     lsp_format = "fallback",
    -- },
})

vim.keymap.set("n", "<leader>f", format.format)

vim.lsp.config('ruff', {
    init_options = {
        settings = {
            lint = { preview = true },
            format = { preview = true }
        }
    }
})

vim.lsp.enable('ruff')

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { noremap = true, buffer = true })
        vim.lsp.start({
            name = "ruff",
            cmd = { "ruff", "server" },
            root_dir = vim.fs.root(0, {"pyproject.toml"})
        })
    end
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

lint.linters_by_ft = {
    typescript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    javascript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    cpp = { 'cpplint' },
    c = { 'cpplint' },
    markdown = { 'cspell' },
    text = { 'cspell' },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = {
        "*.c",
        "*.cpp",
        "*.js",
        "*.jsx",
        "*.ts",
        "*.tsx",
        "*.py",
        "*.md",
        "*.txt",
    },
    callback = function()
        require("lint").try_lint()
    end,
})

vim.diagnostic.config({
    virtual_text = false,
    jump = { float = true },
    float = { source = true }
})
