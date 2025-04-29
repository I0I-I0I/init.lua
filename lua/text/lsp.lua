local ok, lsp = pcall(require, 'lspconfig')
if not ok then
    print("lsp-config is not installed")
    return
 end

local ok, lint = pcall(require, 'lint')
if not ok then
    print("Lint is not installed")
    return
 end

local ok, mason = pcall(require, 'mason')
if not ok then
    print("Mason is not installed")
    return
end

mason.setup()

lint.linters_by_ft = {
    markdown = {'vale'},
    python = {'ruff'},
    python = {'ruff'},
    typescript = {'eslint_d'},
    typescriptreact = {'eslint_d'},
    javascript = {'eslint_d'},
    javascriptreact = {'eslint_d'},
    markdown = {'cspell'},
    text = {'cspell'},
    c = {'cpplint'},
    cpp = {'cpplint'}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
    require("lint").try_lint("cspell")
  end,
})

vim.diagnostic.config({
    underline = true,
    jump = { float = true },
    float = { source = true }
})

local function set_diagnostics_to_quickfix()
    local qflist = {}
    local line_errors = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local diagnostics = vim.diagnostic.get(buf)
        for _, diagnostic in ipairs(diagnostics) do
            local key = diagnostic.bufnr .. ":" .. diagnostic.lnum
            if not line_errors[key] then
                line_errors[key] = {
                    bufnr = diagnostic.bufnr,
                    lnum = diagnostic.lnum + 1,
                    col = diagnostic.col + 1,
                    text = diagnostic.message,
                }
            else
                line_errors[key].text = line_errors[key].text .. " | " .. diagnostic.message
            end
        end
    end

    for _, error in pairs(line_errors) do
        table.insert(qflist, error)
    end

    vim.fn.setqflist(qflist, "r")

    vim.cmd.sleep("100m")
    if #qflist == 0 then
        return
    end
    vim.cmd([[
    mark B
    copen | wincmd p
    ]])
    vim.cmd("cc 1")
end

vim.keymap.set("n", "grd", function()
    vim.cmd("mark B")
    set_diagnostics_to_quickfix()
end, { silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "<C-g><C-]>", vim.lsp.buf.type_definition,
        { table.insert(opts, { desc = "vim.lsp.buf.type_definition()" }) })
        vim.keymap.set({ "n", "v" }, "grf", vim.lsp.buf.format,
        { table.insert(opts, { desc = "vim.lsp.buf.format()" }) })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
            vim.keymap.set('i', '<c-space>', function()
                vim.lsp.completion.get()
            end)
        end

        if client:supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.document_highlight()
                end
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                end
            })
        end
    end
})


local capabilities = vim.lsp.protocol.make_client_capabilities()
lsp.basedpyright.setup({ capabilities = capabilities })

local fallbackFlags
local is_win = os.getenv("OS") == "win"
if is_win then
    fallbackFlags = {
        "-I/usr/x86_64-w64-mingw32/include",
        "-target", "x86_64-w64-mingw32-gcc"
    }
end
lsp.clangd.setup({
    populate_diagnostics = true,
    cmd = { "clangd", "--compile-commands-dir=." },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    init_options = {
        usePlaceholders = false,
        completeUnimported = true,
        clangdFileStatus = true,
        compilationDatabasePath = ".",
        fallbackFlags = fallbackFlags
    },
})
