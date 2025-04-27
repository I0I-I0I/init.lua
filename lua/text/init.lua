local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
Plug('mhartington/oceanic-next')

-- Utils
Plug('jake-stewart/multicursor.nvim')
Plug('i0i-i0i/sessions.nvim')

-- LSP/Lint
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('mfussenegger/nvim-lint')

-- Debug
Plug('mfussenegger/nvim-dap')
Plug('rcarriga/nvim-dap-ui')
Plug('nvim-neotest/nvim-nio')
Plug('mfussenegger/nvim-dap-python')

vim.call('plug#end')

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/text/config.vim")

vim.cmd("colo OceanicNext")
vim.cmd.Setbg("#000001")

require("text.ml")
require("text.sessions")
require("text.lsp")
require("text.dap")
