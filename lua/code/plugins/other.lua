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
    }
}
