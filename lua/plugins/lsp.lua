local M = { "neovim/nvim-lspconfig" }

M.event = { "BufRead", "BufNewFile" }

M.dependencies = {
    "williamboman/mason.nvim",
    "artemave/workspace-diagnostics.nvim",
}

local function setup_servers(servers)
    local lsp = require("lspconfig")
    local diagnostics = require("workspace-diagnostics")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local exclude = { "html", "cssls", "css_variables", "emmet_ls" }
    for name, config in pairs(servers) do
        if not vim.tbl_contains(exclude, name) then
            config.on_attach = function (client, bufnr)
                diagnostics.populate_workspace_diagnostics(client, bufnr)
            end
        end
        config.capabilities = capabilities
        lsp[name].setup(config)
    end
end

function M.config()
    require("mason").setup()

    setup_servers({
        ["html"] = {},
        ["cssls"] = {},
        ["css_variables"] = {},
        ["pyright"] = {},
        ["ts_ls"] = {
            init_options = {
                completions = {
                    completeFunctionCalls = true,
                },
                preferences = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = false,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                    importModuleSpecifierPreference = 'non-relative',
                    includeCompletionsForModuleExports = true,
                    quotePreference = "double",
                    displayPartsForJSDoc = true,
                    generateReturnInDocTemplate = true,
                },
            }
        },
        ["emmet_ls"] = {
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "svelte",
                "pug",
                "typescriptreact",
                "vue"
            },
            init_options = {
                html = {
                    options = { ["bem.enabled"] = true, },
                }
            }
        },
        ["clangd"] = {},
        ["lua_ls"] = {
            settings = {
                Lua = {
                    hint = { enable = true },
                    runtime = { version = "LuaJIT" },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME },
                    },
                    complition = { callSnippet = "Replace" },
                    telemetry = { enable = false },
                    diagnostics = { globals = { "vim", "Snacks" } },
                },
            },
            single_file_support = true
        }
    })

    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        underline = false,
        update_in_insert = false,
        severity_sort = true,
    })

    -- Attach/Mappings
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { buffer = event.buf }
            vim.keymap.set("n", "<C-S-]>", vim.lsp.buf.type_definition,
            { table.insert(opts, { desc = "vim.lsp.buf.type_definition()" }) })
            -- vim.keymap.set("n", "grd", vim.diagnostic.setqflist,
            -- { table.insert(opts, { desc = "vim.diagnostic.setqflist()" }) })
            vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
            vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)

            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if not client then return end

            if client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client.id, event.buf,
                { autotrigger = false })
            end

            local triggers = { ".", "->", "::" }
            for _, trigger in ipairs(triggers) do
                vim.keymap.set("i", trigger, trigger .. "<C-x><C-o>", { buffer = event.buf })
            end

            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true)
            end
        end
    })
end

return M
