vim.loader.enable()

local solo = false

if solo then
    require("solo_warior")
else
    require("army")
end
