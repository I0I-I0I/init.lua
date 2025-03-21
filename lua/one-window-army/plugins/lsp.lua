local M = { "neovim/nvim-lspconfig" }

M.dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "artemave/workspace-diagnostics.nvim",
    "j-hui/fidget.nvim",
    "saghen/blink.cmp",
}

function M.config()
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        pattern = "*.*",
        callback = function()
            vim.lsp.buf.document_highlight()
        end
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        pattern = "*.*",
        callback = function()
            vim.lsp.buf.clear_references()
        end
    })

    local fallbackFlags
    local is_win = os.getenv("OS") == "win"
    if is_win then
        fallbackFlags = {
            "-I/usr/x86_64-w64-mingw32/include",
            "-target", "x86_64-w64-mingw32-gcc"
        }
    end

    local servers = {
        emmet_ls = { filetypes = { "css", "html", "less", "sass", "scss", "svelte", "pug" } },
        ts_ls = { populate_diagnostics = true },
        pyright = { populate_diagnostics = true },
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
        end
    })

    require("fidget").setup()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd", "ts_ls", "pyright", "html", "cssls", "css_variables", "emmet_ls", "jsonls" },
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
        float = { border = "rounded", header = "" }
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "h", "hpp" },
        callback = function ()
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
    end, { noremap = true, silent = true })

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
end

return M
