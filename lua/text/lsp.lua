local ok, mason = pcall(require, 'mason')
if not ok then
    error("Mason is not installed")
    return
end

local ok, lint = pcall(require, 'lint')
if not ok then
    error("Lint is not installed")
    return
end

local ok, format = pcall(require, 'conform')
if not ok then
    error("conform.nvim is not installed")
    return
end

local ok, _ = pcall(require, 'workspace-diagnostics')
if not ok then
    error("workspace-diagnostics is not installed")
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

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set("n", "<leader>f", format.format)

lint.linters_by_ft = {
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    cpp = { "cpplint" },
    c = { "cpplint" },
    markdown = { "cspell" },
    text = { "cspell" },
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
        print("Errors was not found")
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

-- LSP configs

vim.lsp.config("*", {
    root_markers = { '.git', '.hg' },
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    }
})

vim.lsp.config("ruff", {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = {"pyproject.toml", "setup.py"},
    init_opts = {
        settings = {
            lint = { preview = true },
            format = { preview = true }
        },
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil
        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
    end
})

vim.lsp.config("basedpyright", {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = vim.fs.root(0, {"pyproject.toml", "setup.py"}),
    settings = {
        basedpyright = {
            typeCheckingMode = "standard",
            diagnosticMode = "workspace",
        },
        python = {
            pythonPath = ".venv/bin/python"
        }
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil
        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
    end
})

vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    root_dir = vim.fs.root(0, {"lua"}),
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
            },
            complition = { callSnippet = "Replace" },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
            hint = {
                enable = true,
                arrayIndex = "Auto",
                await = true,
                paramName = "All",
                paramType = true,
                semicolon = "SameLine",
                setType = true,
            },
        },
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.semanticTokensProvider = nil
        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
    end
})

vim.lsp.enable({ "basedpyright", "ruff", "lua_ls" })
