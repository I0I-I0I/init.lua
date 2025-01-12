local rose = { "rose-pine/neovim" }

rose.name = "rose-pine"

function SetBg(color)
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
    ]])
end

rose.init = function()
    vim.cmd.colorscheme("rose-pine-main")
    SetBg("#0e0a00")
    vim.cmd.hi("CursorLine guibg=#1e1e1e")
    vim.cmd.hi("StatusLine guibg=#1e1e1e")
end

return rose
