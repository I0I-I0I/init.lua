local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
Plug('mhartington/oceanic-next')

-- Debug
Plug('mfussenegger/nvim-dap')
Plug('igorlfs/nvim-dap-view')
Plug('julianolf/nvim-dap-lldb')
Plug('mfussenegger/nvim-dap-python')

-- UI Enhancements
Plug('AnotherProksY/ez-window')
Plug('mbbill/undotree')
Plug('i0i-i0i/sessions.nvim')

-- IDE features
Plug('neovim/nvim-lspconfig')
Plug("williamboman/mason.nvim")
Plug("artemave/workspace-diagnostics.nvim")
Plug("jake-stewart/multicursor.nvim")
Plug('augmentcode/augment.vim')

-- Finder
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-lua/plenary.nvim')

-- Database
Plug('kristijanhusak/vim-dadbod-ui')
Plug('tpope/vim-dadbod')
Plug('kristijanhusak/vim-dadbod-completion')

-- Dev tools
Plug('tpope/vim-fugitive')
Plug('skywind3000/asyncrun.vim')
Plug('mistweaverco/kulala.nvim')

vim.call('plug#end')

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/army/config.vim")
require("army.nvim_lsp")
require("army.nvim_dap")
require("army.nvim_ml")
require("army.nvim_kulala")
require("army.nvim_telescope")
require("army.nvim_sessions")

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
    end,
})
