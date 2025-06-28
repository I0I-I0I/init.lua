--[[
install PlugVim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
--]]

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
Plug('paradigm/SkyBison')

vim.call('plug#end')

vim.cmd("colo OceanicNext")
vim.cmd.Setbg("NONE")

require("text.ml")
require("text.lsp")
require("text.harpoon")

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

-- SkyBison (emacs like cmdline)

vim.keymap.set("n", "<localleader><C-f>", function()
    local exp = vim.fn.expand("%:p:h")
    vim.cmd("call SkyBison(\"e " .. exp .. "/\")")
end)
vim.keymap.set("n", "<localleader>b", "<cmd>call SkyBison('b ')<cr>")
vim.keymap.set("n", "<localleader>h", "<cmd>call SkyBison('h ')<cr>")
vim.keymap.set("c", "<C-l>", "<c-r>=SkyBison('')<cr><cr>")
vim.g.skybison_fuzz = 0
