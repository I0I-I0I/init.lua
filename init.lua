vim.loader.enable()

local solo = false

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/config.vim")

if solo then
    require("one-man-army")
else
    require("army")
end
