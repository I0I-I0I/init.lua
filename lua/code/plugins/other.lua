return {
    {
        lazy = true,
        "stevearc/quicker.nvim",
        event = "FileType qf",
        opts = {
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
            },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = { "BufReadPost" },
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk)
                map('n', '<leader>hr', gitsigns.reset_hunk)

                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end)

                map('n', '<leader>hd', gitsigns.diffthis)

                map('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end)

                map('n', 'grc', function() gitsigns.setqflist('all') end)
                map('n', '<leader>hq', gitsigns.setqflist)

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>tw', gitsigns.toggle_word_diff)

                -- Text object
                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)

                vim.cmd([[
                    hi GitSignsAdd guibg=NONE
                    hi GitSignsChange guibg=NONE
                    hi GitSignsDelete guibg=NONE
                    hi GitSignsCurrentLineBlame guibg=NONE

                    hi GitSignsStaged guibg=NONE
                    hi GitSignsStagedAdd guibg=NONE
                    hi GitSignsStagedDelete guibg=NONE
                    hi GitSignsStagedChange guibg=NONE
                ]])
            end
        }
    },

    ---@module 'python'
    {
        "joshzcold/python.nvim",
        lazy = true,
        ft = { "python" },
        config = function()
            vim.keymap.set("n", "]t", "<cmd>Neotest jump next<cr>")
            vim.keymap.set("n", "[t", "<cmd>Neotest jump prev<cr>")
            vim.keymap.set("n", "<leader>td", "<cmd>Neotest output<cr>")
            vim.keymap.set("n", "<leader>to", "<cmd>Neotest output-panel<cr>")
            vim.keymap.set("n", "<leader>ts", "<cmd>Neotest summary<cr>")

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "python" },
                callback = function()
                    vim.keymap.set("n", "<leader>tm", "<cmd>PythonTestMethod<cr>", { buffer = true, noremap = true })
                    vim.keymap.set("n", "<leader>tf", "<cmd>PythonTestFile<cr>", { buffer = true, noremap = true })
                    vim.keymap.set("n", "<leader>tt", "<cmd>PythonTest<cr>", { buffer = true, noremap = true })
                    vim.keymap.set("n", "<leader>tt", "<cmd>PythonTest<cr>", { buffer = true, noremap = true })
                end
            })

            require("python").setup()
        end
    },

    {
        "A7Lavinraj/fyler.nvim",
        dependencies = { "echasnovski/mini.icons" },
        lazy = false,
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "fyler" },
                callback = function()
                    vim.cmd([[
                        set <buffer> nonu
                        set <buffer> norelativenumber
                    ]])
                end
            })
            require("fyler").setup({
                default_explorer = true,
                close_on_select = true,
                git_status = true,
                indentscope = {
                    enabled = true,
                    group = "FylerDarkGrey",
                    marker = "│",
                },

                views = {
                    explorer = {
                        width = 0.8,
                        height = 0.8,
                        kind = "float",
                        border = "rounded",
                    },
                    confirm = {
                        width = 0.5,
                        height = 0.4,
                        kind = "float",
                        border = "rounded",
                    },
                },
                mappings = {
                    explorer = {
                        n = {
                            ["q"] = "CloseView",
                            ["<Tab>"] = "Select",
                        },
                    },
                },

            })
        end,
        keys = {
            { "-", "<cmd>Fyler<cr>", { noremap = true } },
        }
    },
}
