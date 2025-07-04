local M = { dir = "~/code/work/zenmode.nvim" }

M.cmd = {
    "ZenmodeToggle",
    "ZenmodeClose",
    "ZenmodeOpen"
}

M.opts = {
    default_width = 20,
    toggle_opts = {
        nu = false,
        rnu = false,
        laststatus = 0
    },
    on_open = function()
        vim.cmd("GitGutterDisable")
        vim.cmd("set signcolumn=no")
    end,
    on_close = function()
        vim.cmd("GitGutterEnable")
        vim.cmd("set signcolumn=yes:2")
    end
}

M.keys = function()
    ---@class Buitlin
    ---@field toggle fun(input_width: integer | nil)
    ---@field open fun(input_width: integer | nil)
    ---@field close fun()
    local builtin = require("zenmode.nvim").builtin()
    return {
        { "<leader>zo", function() builtin.open() end,   { silent = true } },
        { "<leader>zt", function() builtin.toggle() end, { silent = true } },
        { "<leader>zc", function() builtin.close() end,  { silent = true } }
    }
end

return M

