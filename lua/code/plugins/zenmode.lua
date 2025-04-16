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
    local opt = vim.opt
    local defaults = {
        rnu = opt.rnu,
        nu = opt.nu,
        laststatus = opt.laststatus,
        fillchars = opt.fillchars,
    }

    local on_open = {
        fillchars = "eob:\\u00A0,vert:\\u00A0",
        rnu = false,
        nu = false,
        laststatus = 0,
    }

    local function setOpts(arr)
        for key, value in pairs(arr) do
            opt[key] = value
        end
    end

    return {
        { "<leader>zf",  function()
            vim.cmd("ZenmodeOpenAll 15")
            setOpts(on_open)
        end, { silent = true } },

        { "<leader>zo",  function()
            setOpts(defaults)
            opt.fillchars = "eob:\\u00A0,vert:\\u00A0"
            vim.cmd("ZenmodeOpenAll 10")
        end, { silent = true } },

        { "<leader>zc", function()
            vim.cmd("ZenmodeCloseAll")
            setOpts(defaults)
        end, { silent = true } }
    }
end

return M
