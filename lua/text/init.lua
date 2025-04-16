local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
Plug('neanias/everforest-nvim')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- Utils
Plug('skywind3000/asyncrun.vim')
Plug('tpope/vim-fugitive')
Plug('jake-stewart/multicursor.nvim')
Plug('i0i-i0i/sessions.nvim')

-- Debug
Plug('mfussenegger/nvim-dap')
Plug('igorlfs/nvim-dap-view')
Plug('julianolf/nvim-dap-lldb')

-- Database
Plug('tpope/vim-dadbod')
Plug('kristijanhusak/vim-dadbod-ui')
Plug('kristijanhusak/vim-dadbod-completion')

vim.call('plug#end')

require("everforest").setup({
    background = "hard",
    italics = true,
    spell_foreground = true,
})
require("everforest").load()

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/text/config.vim")
require("text.nvim_ml")
require("text.nvim_sessions")
require("text.nvim_dap")
require("text.nvim_treesitter")
