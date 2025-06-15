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

lint.linters_by_ft = {
    typescript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    javascript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    python = { 'ruff' },
    cpp = { 'cpplint' },
    c = { 'cpplint' },
    markdown = { 'cspell' },
    text = { 'cspell' },
}

format.setup({
    formatters_by_ft = {
        python = { "ruff_format" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        htmldjango = { "prettierd" },
        css = { "prettierd" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.diagnostic.config({
    underline = true,
    jump = { float = true },
    float = { source = true }
})
