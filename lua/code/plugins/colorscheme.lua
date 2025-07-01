---@param theme string
---@param callback fun()
local function set_theme(theme, callback)
    if (theme == vim.g.colorscheme.theme) then
        callback()
        if (vim.g.colorscheme.bg ~= nil) then
            vim.cmd.Setbg(vim.g.colorscheme.bg)
        end
    end
end

-- Colors
local osaka = {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = false },
    init = function()
        set_theme("osaka", function()
            vim.cmd.colorscheme("solarized-osaka")
        end)
    end
}

local rose = {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    name = "rose-pine",
    init = function()
        set_theme("rose", function()
            vim.cmd.colorscheme("rose-pine-main")
        end)
    end
}

local kanagawa = {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        compile = true,      -- enable compiling the colorscheme
        undercurl = true,    -- enable undercurls
        transparent = false, -- do not set background color
        theme = "dragon",    -- Load "wave" theme
        background = {       -- map the value of 'background' option to a theme
            dark = "dragon", -- try "dragon" !
            light = "lotus"
        },
    },
    init = function()
        set_theme("kanagawa", function()
            vim.cmd.colorscheme("kanagawa")
            vim.cmd([[
                hi DiffAdd guibg=#002e00
                hi DiffChange guibg=#434200
                hi DiffDelete guibg=#470000
                hi LspReferenceRead guibg=#222222
                hi LspReferenceText guibg=#222222
                hi LspReferenceWrite guibg=#222222

                hi Pmenu guibg=NONE
                hi NormalFloat guibg=NONE
                hi Float guibg=NONE
                hi FloatBorder guibg=NONE
                hi BlinkCmpMenu guibg=NONE
                hi BlinkCmpMenuBorder guibg=NONE
                hi BlinkCmpMenuSelection guibg=NONE guifg=#ffffff
            ]])
        end)
    end
}

local hack = {
    "ntk148v/komau.vim",
    lazy = false,
    priority = 1000,
    name = "komau",
    init = function()
        set_theme("hack", function()
            vim.cmd.colorscheme("komau")
        end)
    end
}

return { rose, osaka, hack, kanagawa }
