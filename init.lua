vim.loader.enable()

local solo = os.getenv("CONF")

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/config.vim")

if solo == "t" then
    require("one-windows-army")
else
    require("army")
end
