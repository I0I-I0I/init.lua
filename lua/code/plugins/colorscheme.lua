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

local hack_dark = {
    "bettervim/yugen.nvim",
    lazy = false,
    priority = 1000,
    init = function ()
        set_theme("hack_dark", function()
            vim.cmd.colorscheme("yugen")
            vim.cmd([[
                hi DiffAdd guibg=#002e00
                hi DiffChange guibg=#434200
                hi DiffDelete guibg=#470000
                hi LspReferenceRead guibg=#222222
                hi LspReferenceText guibg=#222222
                hi LspReferenceWrite guibg=#222222
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
        vim.cmd.hi("TabLineFill guibg=NONE")
    end
}

return { rose, osaka, hack, hack_dark }
