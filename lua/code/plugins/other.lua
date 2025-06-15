return {
    {
        'stevearc/quicker.nvim',
        event = "FileType qf",
        opts = {
            mappings = {
                '<C-u>', '<C-d>',
                '<C-y>', '<C-e>',
                'zt', 'zz', 'zb',
            },
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
        "declancm/cinnamon.nvim",
        version = "*",
        priority = 1000,
        lazy = false,
        config = function()
            local cinnamon = require("cinnamon")

            cinnamon.setup {
                keymaps = {
                    basic = true,
                    extra = true,
                },
            }

            vim.keymap.set("n", "<C-y>", "3<C-y>", { noremap = true })
            vim.keymap.set("n", "<C-e>", "3<C-e>", { noremap = true })
        end
    },

    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "kkharji/sqlite.lua",           module = "sqlite" },
        },
        opts = {
            enable_persistent_history = true,
            prompt = nil,
            content_spec_column = true,
            dedent_picker_display = true,
            keys = { telescope = { i = { paste = "<c-v>" } } }
        },
        keys = {
            {
                "<M-v>",
                function()
                    require("telescope").extensions.neoclip.default(
                        require("telescope.themes").get_cursor()
                    )
                end,
                mode = { "n", "v", "i" },
                desc = "Neoclip"
            },
        }
    }
}
