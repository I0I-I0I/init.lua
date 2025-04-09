vim.loader.enable()

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/config.vim")

local solo = os.getenv("CONF")

if solo == "t" then
    require("one-window-army")
else
    require("army")
end
