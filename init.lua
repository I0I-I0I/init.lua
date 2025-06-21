vim.loader.enable()

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/config.vim")

local type = os.getenv("CONF")

if type == "text" then
    require("text")
else
    require("code")
end

if type == "tty" then
    vim.cmd.colo("default")
    vim.cmd.hi("LineNrAbove ctermfg=WHITE")
    vim.cmd.hi("LineNrBelow ctermfg=WHITE")
    vim.cmd.hi("CursorLine ctermfg=BLUE ctermbg=WHITE guifg=LIGHTBLUE")
end
