local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "artemave/workspace-diagnostics.nvim",
    "j-hui/fidget.nvim",
    "saghen/blink.cmp",

    -- Other tools
    "mfussenegger/nvim-lint",

    -- TypeScript
    "dmmulroy/tsc.nvim",
    "pmizio/typescript-tools.nvim"
}

function M.config()
    local fallbackFlags
    local is_win = os.getenv("OS") == "win"
    if is_win then
        fallbackFlags = {
            "-I/usr/x86_64-w64-mingw32/include",
            "-target", "x86_64-w64-mingw32-gcc"
        }
    end

    local servers = {
        html = {},
        cssls = {},
        css_variables = {},
        jsonls = {},
        emmet_ls = { filetypes = { "css", "html", "less", "sass", "scss", "svelte", "pug" } },
        basedpyright = { populate_diagnostics = true },
        clangd = {
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
        },
        lua_ls = {
            populate_diagnostics = true,
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
    }

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { buffer = event.buf }
            vim.keymap.set("n", "<C-g><C-]>", vim.lsp.buf.type_definition,
                { table.insert(opts, { desc = "vim.lsp.buf.type_definition()" }) })
            vim.keymap.set({ "n", "v" }, "grf", vim.lsp.buf.format,
                { table.insert(opts, { desc = "vim.lsp.buf.format()" }) })

            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if not client then return end

            if not client:supports_method("textDocument/documentHighlight") then
                return
            end

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
    })

    local ensure_installed = {}
    for server, _ in pairs(servers) do
        table.insert(ensure_installed, server)
    end
    require("fidget").setup()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = {
            function(server_name)
                local lsp = require("lspconfig")
                local diagnostics = require("workspace-diagnostics")
                local capabilities = {
                    textDocument = {
                        completion = {
                            completionItem = {
                                snippetSupport = true
                            }
                        },
                        semanticTokens = {
                            multilineTokenSupport = true,
                        },
                        foldingRange = {
                            dynamicRegistration = true,
                            lineFoldingOnly = true
                        }
                    }
                }

                local config = servers[server_name] or {}
                config.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

                if servers[server_name] and servers[server_name].populate_diagnostics then
                    config.on_attach = function(client, bufnr)
                        diagnostics.populate_workspace_diagnostics(client, bufnr)
                    end
                end
                lsp[server_name].setup(config)
            end,
        }
    })

    vim.diagnostic.config({
        virtual_text = false,
        underline = false,
        severity_sort = true,
        jump = { float = true },
        float = { border = "rounded", header = "", source = true }
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "h", "hpp" },
        callback = function()
            vim.keymap.set("n", "<A-s>", "<cmd>ClangdSwitchSourceHeader<cr>")
        end
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

    require("blink.cmp").setup({
        cmdline = { enabled = false },
        keymap = { preset = "default" },
        sources = {
            default = { "lsp", "path", "buffer" },
            providers = {
                dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
            },
            per_filetype = {
                sql = { "dadbod", "buffer" },
            },
        },
        fuzzy = {
            implementation = "prefer_rust",
            prebuilt_binaries = { force_version = 'v1.0.0' },
        },
        completion = {
            menu = {
                auto_show = true,
                draw = {
                    treesitter = { 'lsp' },
                    columns = { { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 }, { "kind" } },
                }
            },
            trigger = {
                show_on_keyword = true,
            },
            list = {
                selection = { preselect = true, auto_insert = false },
            },
            documentation = { auto_show = true, auto_show_delay_ms = 10 },
            ghost_text = {
                enabled = true,
                show_with_menu = false
            }
        },
        signature = { enabled = true },
    })

    --
    -- TypeScript --
    --
    require("tsc").setup({
        auto_open_qflist = true,
        use_trouble_qflist = false,
        use_diagnostics = false,
        run_as_monorepo = false,
        enable_progress_notifications = true,
        enable_error_notifications = true,
        hide_progress_notifications_from_history = true,
        pretty_errors = true,
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function()
            vim.keymap.set("n", "grd", vim.cmd.TSC, { buffer = true, noremap = true, silent = true })
            vim.keymap.set("n", "grD", function()
                vim.cmd("mark B")
                set_diagnostics_to_quickfix()
            end, { noremap = true, silent = true, buffer = true })
        end
    })

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

    require('lint').linters_by_ft = {
        markdown = {'vale'},
        python = {'ruff'},
    }
end

return M
