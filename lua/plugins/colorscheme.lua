local M = { "mhartington/oceanic-next" }

M.init = function()
    vim.cmd.colorscheme("OceanicNext")

    local bg = "#000001"
    vim.cmd.hi("Normal guibg=" .. bg)
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

    hi GitSignsAdd guibg=Normal guifg=green
    hi GitSignsChange guibg=Normal guifg=yellow
    hi GitSignsDelete guibg=Normal guifg=red
    hi GitSignsAddLn guibg=Normal guifg=green
    hi GitSignsChangeLn guibg=Normal guifg=yellow
    hi GitSignsDeleteLn guibg=Normal guifg=red
    ]])
end

return M
