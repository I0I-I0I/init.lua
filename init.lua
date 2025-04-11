vim.loader.enable()

vim.cmd.source(vim.fn.stdpath("config") .. "/lua/config.vim")

local type = os.getenv("CONF")

if type == "code" then
    require("code")
else
    require("text")
end
