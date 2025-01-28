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
        ["emmet_ls"] = { filetypes = { "css", "html", "less", "sass", "scss", "svelte", "pug" }, },
        ["pyright"] = { populate_diagnostic = true },
        ["ts_ls"] = { populate_diagnostic = true },
        ["clangd"] = {
            populate_diagnostic = true,
            init_options = {
                usePlaceholders = false,
                completeUnimported = true,
                clangdFileStatus = true,
                fallbackFlags = { "-std=c++2a" },
            }
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
        virtual_lines = true,
        signs = true,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
        jump = { float = false },
        float = {
            border = "rounded",
            source = "if_many",
        }
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { buffer = event.buf }
            vim.keymap.set("n", "<leader><C-]>", vim.lsp.buf.type_definition,
                { table.insert(opts, { desc = "vim.lsp.buf.type_definition()" }) })
            vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
                { table.insert(opts, { desc = "vim.lsp.buf.format()" }) })
        end
    })
end

return M
