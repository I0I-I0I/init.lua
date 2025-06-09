local M = { "mason-org/mason.nvim" }

M.dependencies = {
    "neovim/nvim-lspconfig",
    "mason-org/mason-lspconfig.nvim",
    "artemave/workspace-diagnostics.nvim",
    {
        "saghen/blink.cmp",
        version = "*",
        build = "cargo build --release",
        opts = {
            cmdline = { enabled = false },
            keymap = { preset = "default" },
            sources = { default = { "lsp", "path", "buffer" } },
            fuzzy = { implementation = "rust" },
            completion = {
                menu = {
                    auto_show = true,
                    draw = {
                        treesitter = { 'lsp' },
                        columns = { { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 }, { "kind" } },
                    }
                },
                trigger = { show_on_keyword = true },
                list = {
                    selection = { preselect = true, auto_insert = false },
                },
                documentation = { auto_show = true, auto_show_delay_ms = 10 },
            },
            signature = { enabled = true },
        }
    },

    -- Other tools
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters_by_ft = {
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
        },
        config = function()
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end
    },
    {
        "stevearc/conform.nvim",
        opts = {
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
        }
    },
}

M.opts = {
    servers = {
        html = { filetypes = { "html", "htmldjango", "typescriptreact", "javascriptreact"} },
        djlsp = {},
        cssls = {},
        css_variables = {},
        jsonls = {},
        emmet_ls = { filetypes = { "css", "html", "htmldjango", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "javascriptreact" } },
        basedpyright = {
            settings = {
                basedpyright = {
                    typeCheckingMode = "standard",
                },
            },
            on_attach = function(client, bufnr)
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
            end,
        },
        clangd = {
            cmd = { "clangd", "--compile-commands-dir=." },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            init_options = {
                usePlaceholders = false,
                completeUnimported = true,
                clangdFileStatus = true,
                compilationDatabasePath = ".",
            },
            on_attach = function(client, bufnr)
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

                vim.api.nvim_create_autocmd("FileType", {
                    buffer = bufnr,
                    callback = function()
                        vim.keymap.set("n", "<A-s>", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = bufnr })
                    end
                })
            end,
        },
        lua_ls = {
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
                        setType = false,
                    },
                },
            },
            on_attach = function(client, bufnr)
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
            end,
        }
    },
}

M.init = function()
    vim.diagnostic.config({
        virtual_text = false,
        underline = false,
        severity_sort = true,
        jump = { float = true },
        float = { border = "rounded", header = "", source = true }
    })
end

M.config = function(_, opts)
    local servers = {}
    for server, _ in pairs(opts.servers) do
        table.insert(servers, server)
    end
    require("mason").setup()
    require("mason-lspconfig").setup({ ensure_installed = servers })
    for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            vim.keymap.set("n", "<C-g><C-]>", vim.lsp.buf.type_definition,
                { table.insert({ buffer = ev.buf }, { desc = "vim.lsp.buf.type_definition()" }) })
            vim.keymap.set({ "n", "v" }, "grf", vim.lsp.buf.format,
                { table.insert({ buffer = ev.buf }, { desc = "vim.lsp.buf.format()" }) })

            local client = vim.lsp.get_client_by_id(ev.data.client_id)

            if not client then return end
            if not client:supports_method("textDocument/documentHighlight") then
                return
            end

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.document_highlight()
                end
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                end
            })
        end
    })
end


local front = {
    {
        "dmmulroy/tsc.nvim",
        lazy = true,
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        opts = {
            auto_open_qflist = true,
            use_trouble_qflist = true,
            use_diagnostics = true,
            run_as_monorepo = false,
            enable_progress_notifications = true,
            enable_error_notifications = true,
            hide_progress_notifications_from_history = true,
            pretty_errors = true,
        },
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
                callback = function()
                    vim.keymap.set("n", "grD", vim.cmd.TSC, { buffer = true, noremap = true, silent = true })
                end
            })
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        lazy = true,
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        config = function()
            require("typescript-tools").setup({
                settings = {
                    -- spawn additional tsserver instance to calculate diagnostics on it
                    separate_diagnostic_server = true,
                    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
                    publish_diagnostic_on = "insert_leave",
                    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
                    -- "remove_unused_imports"|"organize_imports") -- or string "all"
                    -- to include all supported code actions
                    -- specify commands exposed as code_actions
                    expose_as_code_action = "all",
                    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
                    -- not exists then standard path resolution strategy is applied
                    tsserver_path = nil,
                    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
                    -- (see 💅 `styled-components` support section)
                    tsserver_plugins = {},
                    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
                    -- memory limit in megabytes or "auto"(basically no limit)
                    tsserver_max_memory = "auto",
                    -- locale of all tsserver messages, supported locales you can find here:
                    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
                    tsserver_locale = "en",
                    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
                    complete_function_calls = false,
                    include_completions_with_insert_text = true,
                    -- CodeLens
                    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
                    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
                    code_lens = "references_only",
                    -- by default code lenses are displayed on all referencable values and for some of you it can
                    -- be too much this option reduce count of them by removing member references from lenses
                    disable_member_code_lens = true,
                    -- JSXCloseTag
                    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
                    -- that maybe have a conflict if enable this feature. )
                    jsx_close_tag = {
                        enable = true,
                        filetypes = { "javascriptreact", "typescriptreact" },
                    },
                    tsserver_file_preferences = {
                        includeInlayParameterNameHints = "all",
                        includeCompletionsForModuleExports = true,
                        quotePreference = "auto",
                    },
                    tsserver_format_options = {
                        allowIncompleteCompletions = false,
                        allowRenameOfImportPath = false,
                    }
                },
            })
        end
    }
}

return { M, front }
