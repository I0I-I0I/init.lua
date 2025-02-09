local local_plugins = vim.fn.stdpath("config") .. "/plugins/"

local M = { dir = local_plugins .. "zenmode" }

M.cmd = {
    "ZenmodeToggle",
    "ZenmodeCloseAll",
    "ZenmodeClose",
    "ZenmodeOpenAll",
    "ZenmodeOpen"
}

M.keys = function()
    local o = vim.opt
    local defaults = {
        rnu = o.rnu,
        nu = o.nu,
        laststatus = o.laststatus,
        fillchars = o.fillchars,
    }

    local on_open = {
        fillchars = "eob:\\u00A0,vert:\\u00A0",
        rnu = false,
        nu = false,
        laststatus = 0,
    }

    local function setOpts(arr)
        for key, value in pairs(arr) do
            o[key] = value
        end
    end

    return {
        { "zf",  function()
            vim.cmd("ZenmodeOpenAll 15")
            setOpts(on_open)
        end, { silent = true } },

        { "zo",  function()
            setOpts(defaults)
            o.fillchars = "eob:\\u00A0,vert:\\u00A0"
            vim.cmd("ZenmodeOpenAll 10")
        end, { silent = true } },

        { "zc", function()
            vim.cmd("ZenmodeCloseAll")
            setOpts(defaults)
        end, { silent = true } }
    }
end

return M
