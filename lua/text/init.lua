local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
Plug('mhartington/oceanic-next')

-- Utils
Plug('jake-stewart/multicursor.nvim')
Plug('ThePrimeagen/harpoon', { branch = 'harpoon2' })
Plug('nvim-lua/plenary.nvim')
Plug('stevearc/quicker.nvim')
Plug('williamboman/mason.nvim')
Plug('mfussenegger/nvim-lint')
Plug('stevearc/conform.nvim')

vim.call('plug#end')

vim.cmd("colo OceanicNext")
vim.cmd.Setbg("NONE")

require("text.ml")
require("text.lsp")
require("text.harpoon")

require("quicker").setup({
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
    }
})
