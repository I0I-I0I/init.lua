local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
Plug('mhartington/oceanic-next')

-- Dev tools
Plug('tpope/vim-fugitive')
Plug('skywind3000/asyncrun.vim')
Plug('mistweaverco/kulala.nvim')

-- IDE features
Plug('jake-stewart/multicursor.nvim')
Plug('augmentcode/augment.vim')
Plug('i0i-i0i/sessions.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-lua/plenary.nvim')
-- Plug('neovim/nvim-lspconfig')
-- Plug("williamboman/mason.nvim")
-- Plug("artemave/workspace-diagnostics.nvim")

-- UI Enhancements
Plug('AnotherProksY/ez-window')
Plug('mbbill/undotree')

-- Debug
Plug('mfussenegger/nvim-dap')
Plug('igorlfs/nvim-dap-view')
Plug('julianolf/nvim-dap-lldb')

-- Database
Plug('tpope/vim-dadbod')
Plug('kristijanhusak/vim-dadbod-ui')
Plug('kristijanhusak/vim-dadbod-completion')

vim.call('plug#end')

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/army/config.vim")
-- require("army.nvim_lsp")
require("army.nvim_sessions")
require("army.nvim_dap")
require("army.nvim_ml")
require("army.nvim_kulala")
