local function set_color(color, callback)
    if (color == vim.g.colorscheme.theme) then
        callback()
        if (vim.g.colorscheme.bg ~= nil) then
            SetBg(vim.g.colorscheme.bg)
        end
    end
end

local kanagawa = {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    init = function()
        set_color("kanagawa", function()
            vim.cmd.colorscheme("kanagawa-dragon")
        end)
    end
}

local osaka = {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = false },
    init = function()
        set_color("osaka", function()
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
        set_color("rose", function()
            vim.cmd.colorscheme("rose-pine-main")
        end)
    end
}

local hack_dark = {
    "bettervim/yugen.nvim",
    lazy = false,
    priority = 1000,
    init = function ()
        set_color("hack_dark", function ()
            vim.cmd.colorscheme("yugen")
            vim.cmd.hi("DiffAdd guibg=#002e00")
            vim.cmd.hi("DiffChange guibg=#434200")
            vim.cmd.hi("DiffDelete guibg=#470000")
        end)
    end
}

local hack = {
    "aktersnurra/no-clown-fiesta.nvim",
    lazy = false,
    priority = 1000,
    init = function ()
        set_color("hack", function ()
            vim.cmd.colorscheme("no-clown-fiesta")
        end)
    end
}

function SetBg(color, second_color)
    if color == "NONE" then
        vim.opt.cursorline = false
    end
    if not second_color then
        second_color = "#1e1e1e"
    end

    vim.cmd.hi("Normal guibg=" .. color)
    vim.cmd([[
        hi NormalNC guibg=Normal
        hi NormalFloat guibg=Normal
        hi EndOfBuffer guibg=Normal
        hi LineNr guibg=Normal
        hi SignColumn guibg=Normal
        hi DiagnosticSignError guibg=Normal
        hi DiagnosticSignWarn guibg=Normal
        hi DiagnosticSignOk guibg=Normal
        hi DiagnosticSignHint guibg=Normal
        hi DiagnosticSignInfo guibg=Normal
        hi Folded guibg=Normal
    ]])
end

return { rose, osaka, hack, hack_dark, kanagawa }
