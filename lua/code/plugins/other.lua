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
        "airblade/vim-gitgutter"
    }
}
