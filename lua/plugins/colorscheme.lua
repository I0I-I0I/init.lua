local function set_color(color)
    if (color == "rose" and color == vim.g.colorscheme) then
        vim.cmd.colorscheme("rose-pine-main")
        SetBg("NONE")
    elseif (color == "osaka" and color == vim.g.colorscheme) then
        vim.cmd.colorscheme("solarized-osaka")
    end
end

local osaka = {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = false },
    init = function() set_color("osaka") end
}

local rose = {
    "rose-pine/neovim",
    name = "rose-pine",
    init = function() set_color("rose") end
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
        hi EndOfBuffer guibg=Normal
        hi LineNr guibg=Normal
        hi SignColumn guibg=Normal
        hi DiagnosticSignError guibg=Normal
        hi DiagnosticSignWarn guibg=Normal
        hi DiagnosticSignOk guibg=Normal
        hi DiagnosticSignHint guibg=Normal
        hi DiagnosticSignInfo guibg=Normal
        hi StatusLine guibg=Normal
        hi Folded guibg=Normal
        hi TroubleNormal guibg=Normal

    ]])
    vim.cmd.hi("TroubleNormalNC guibg=" .. color)
    vim.cmd.hi("StatusLine guibg=" .. second_color)
    vim.cmd.hi("CursorLine guibg=" .. second_color)
end

return { rose, osaka }
