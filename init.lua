vim.loader.enable()

local solo = os.getenv("CONF")

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/config.vim")

if solo == "t" then
    require("one-man-army")
else
    require("army")
end
