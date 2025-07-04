--[[
install PlugVim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
--]]

local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("ntk148v/komau.vim")
Plug("jake-stewart/multicursor.nvim")
Plug("stevearc/quicker.nvim")
Plug("williamboman/mason.nvim")
Plug("mfussenegger/nvim-lint")
Plug("stevearc/conform.nvim")
Plug("artemave/workspace-diagnostics.nvim")
Plug("i0i-i0i/sessions.nvim")
Plug("i0i-i0i/zenmode.nvim")

-- Debug
-- Plug("mfussenegger/nvim-dap")
-- Plug("rcarriga/nvim-dap-ui")
-- Plug("nvim-neotest/nvim-nio")
-- Plug("mfussenegger/nvim-dap-python")

vim.call("plug#end")

local night_start = 22
local night_end   = 6

local function check_and_switch()
    local hour = tonumber(os.date("%H"))
    if hour >= night_start or hour < night_end then
        vim.cmd("colo komau")
        vim.cmd.Colors()
        vim.cmd.Setbg("none")
    else
        vim.cmd("colo zenesque")
        vim.cmd.Colors()
    end
end

local timer = vim.loop.new_timer()
timer:start(0, 60 * 1000 * 10, vim.schedule_wrap(check_and_switch))

require("text.ml")
require("text.lsp")
require("text.sessions")
require("text.zenmode")

-- Quicker (better qflist)

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
