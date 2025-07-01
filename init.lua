vim.loader.enable()

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/config.vim")

local type = os.getenv("CONF")

if type == "text" then
    require("text")
else
    require("code")
    vim.cmd([[
        hi TabLineFill guibg=NONE

        hi Pmenu guibg=NONE
        hi NormalFloat guibg=NONE
        hi Float guibg=NONE
        hi FloatBorder guibg=NONE
        hi BlinkCmpMenu guibg=NONE
        hi BlinkCmpMenuBorder guibg=NONE
        hi BlinkCmpMenuSelection guibg=NONE guifg=#ffffff
        hi BlinkCmpDoc guibg=NONE
        hi BlinkCmpDocBorder guibg=NONE
        hi BlinkCmpDocSeparator guibg=NONE
        hi TelescopeBorder guibg=NONE
    ]])
end

if type == "tty" then
    vim.cmd.colo("default")
    vim.cmd.hi("LineNrAbove ctermfg=WHITE")
    vim.cmd.hi("LineNrBelow ctermfg=WHITE")
    vim.cmd.hi("CursorLine ctermfg=BLUE ctermbg=WHITE guifg=LIGHTBLUE")
end

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.cmd([[
            hi BlinkCmpLabelDescription guibg=NONE
        ]])
    end
})

vim.cmd([[
    hi DiffAdded guibg=NONE guifg=#00ff00
    hi DiffAdd guibg=NONE guifg=#00ff00
    hi DiffDelete guibg=NONE guifg=#ff0000
    hi DiffRemoved guibg=NONE guifg=#ff0000
    hi DiffChange guibg=NONE guifg=#A1D650
    hi DiffChanged guibg=NONE guifg=#A1D650

    hi DiagnosticSignError guifg=#ffffff guibg=NONE
    hi DiagnosticSignWarn guifg=#ffffff guibg=NONE
    hi DiagnosticSignOk guifg=#ffffff guibg=NONE
    hi DiagnosticSignInfo guifg=#ffffff guibg=NONE
    hi DiagnosticSignHint guifg=#ffffff guibg=NONE
    hi DiagnosticFloatingError guifg=#ffffff guibg=NONE
    hi DiagnosticFloatingWarn guifg=#ffffff guibg=NONE
    hi DiagnosticFloatingOk guifg=#ffffff guibg=NONE
    hi DiagnosticFloatingInfo guifg=#ffffff guibg=NONE
    hi DiagnosticFloatingHint guifg=#ffffff guibg=NONE
]])
