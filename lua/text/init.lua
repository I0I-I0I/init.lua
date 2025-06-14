local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
Plug('mhartington/oceanic-next')

-- Utils
Plug('jake-stewart/multicursor.nvim')
Plug('kkoomen/vim-doge', { ['do'] = ':call doge#install()' })
Plug('ThePrimeagen/harpoon', { branch = 'harpoon2' })
Plug('nvim-lua/plenary.nvim')
Plug('stevearc/quicker.nvim')
Plug('i0i-i0i/sessions.nvim')

-- LSP/Lint
Plug('neovim/nvim-lspconfig')
Plug('artemave/workspace-diagnostics.nvim')
Plug('williamboman/mason.nvim')
Plug('mfussenegger/nvim-lint')
Plug('stevearc/conform.nvim')

-- Debug
Plug('mfussenegger/nvim-dap')
Plug('rcarriga/nvim-dap-ui')
Plug('nvim-neotest/nvim-nio')
Plug('mfussenegger/nvim-dap-python')

vim.call('plug#end')

vim.cmd("colo OceanicNext")
vim.cmd.Setbg("NONE")

require("text.ml")
require("text.lsp")
require("text.harpoon")
require("text.dap")
require("text.sessions")

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

