local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Theme
Plug('mhartington/oceanic-next')

-- Utils
Plug('skywind3000/asyncrun.vim')
Plug('jake-stewart/multicursor.nvim')
Plug('i0i-i0i/sessions.nvim')

-- Git
Plug('NeogitOrg/neogit')
Plug('sindrets/diffview.nvim')
Plug('nvim-lua/plenary.nvim')

-- LSP/Lint
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('mfussenegger/nvim-lint')

-- Debug
Plug('mfussenegger/nvim-dap')
Plug('rcarriga/nvim-dap-ui')
Plug('nvim-neotest/nvim-nio')
Plug('julianolf/nvim-dap-lldb')
Plug('mfussenegger/nvim-dap-python')

vim.call('plug#end')

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/text/config.vim")

vim.cmd("colo OceanicNext")
vim.cmd.Setbg("#000001")

require("text.ml")
require("text.sessions")
require("text.dap")
require("text.lsp")
require("text.git")
