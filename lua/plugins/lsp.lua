local M = { "neovim/nvim-lspconfig" }

M.event = { "BufRead", "BufNewFile" }

M.dependencies = {
    "williamboman/mason.nvim",
    "artemave/workspace-diagnostics.nvim",
    "j-hui/fidget.nvim",
}

local function setup_servers(servers)
    local lsp = require("lspconfig")
    local diagnostics = require("workspace-diagnostics")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    for name, config in pairs(servers) do
        if config.populate_diagnostic then
            config.on_attach = function(client, bufnr)
                diagnostics.populate_workspace_diagnostics(client, bufnr)
            end
        end
        config.capabilities = capabilities
        lsp[name].setup(config)
    end
end

function M.config()
    require("mason").setup()
    require("fidget").setup()

    setup_servers({
        ["html"] = {},
        ["cssls"] = {},
        ["css_variables"] = {},
        ["emmet_ls"] = { filetypes = { "css", "html", "less", "sass", "scss", "svelte", "pug" } },
        ["pyright"] = { populate_diagnostic = true },
        ["ts_ls"] = { populate_diagnostic = true },
        ["clangd"] = {
            populate_diagnostic = true,
            cmd = { "clangd", "--compile-commands-dir=." },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            init_options = {
                usePlaceholders = false,
                completeUnimported = true,
                clangdFileStatus = true,
                compilationDatabasePath = ".",

                -- for coding on Linux for Windows
                fallbackFlags = {
                    "-I/usr/x86_64-w64-mingw32/include",
                    "-target", "x86_64-w64-mingw32-gcc"
                },
            },
        },
        ["lua_ls"] = {
            populate_diagnostic = true,
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
                },
            },
        }
    })

    vim.diagnostic.config({
        virtual_text = {
            current_line = true,
            virt_text_pos = "eol_right_align"
        },
        underline = false,
        severity_sort = true,
        jump = { float = false },
        float = { border = "rounded", header = "" }
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { buffer = event.buf }
            vim.keymap.set("n", "<leader><C-]>", vim.lsp.buf.type_definition,
                { table.insert(opts, { desc = "vim.lsp.buf.type_definition()" }) })
            vim.keymap.set({ "n", "v" }, "grf", vim.lsp.buf.format,
                { table.insert(opts, { desc = "vim.lsp.buf.format()" }) })

            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if not client then return end

            if client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = false })
            end

            local triggers = { ".", "->", "::" }
            for _, trigger in ipairs(triggers) do
                vim.keymap.set("i", trigger, trigger .. "<C-x><C-o>", { buffer = event.buf })
            end
        end
    })
end

return M
