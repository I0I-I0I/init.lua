local M = { "neovim/nvim-lspconfig" }

M.event = { "BufRead", "BufNewFile" }

M.dependencies = {
    "williamboman/mason.nvim",
    "artemave/workspace-diagnostics.nvim",
    "j-hui/fidget.nvim",
    "saghen/blink.cmp",
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
        config.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
        lsp[name].setup(config)
    end
end

function M.config()
    require("mason").setup()
    require("fidget").setup()
    local is_win = os.getenv("OS") == "win"

    local fallbackFlags
    if is_win then
        fallbackFlags = {
            "-I/usr/x86_64-w64-mingw32/include",
            "-target", "x86_64-w64-mingw32-gcc"
        }
    end

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
                fallbackFlags = fallbackFlags
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

    vim.keymap.set("n", "grd", set_diagnostics_to_quickfix, { noremap = true, silent = true })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { buffer = event.buf }
            vim.keymap.set("n", "<C-g><C-]>", vim.lsp.buf.type_definition,
                { table.insert(opts, { desc = "vim.lsp.buf.type_definition()" }) })
            vim.keymap.set({ "n", "v" }, "grf", vim.lsp.buf.format,
                { table.insert(opts, { desc = "vim.lsp.buf.format()" }) })
        end
    })

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
        fuzzy = { implementation = "lua" },
        completion = {
            menu = { auto_show = true },
            documentation = { auto_show = true, auto_show_delay_ms = 10 },
            trigger = {
                show_on_keyword = true,
                -- show_on_trigger_character = true,
                -- show_on_blocked_trigger_characters = { ' ', '\n', '\t' }
            },
            -- ghost_text = { enabled = true }
        },
        signature = { enabled = true },
    })
end

return M
