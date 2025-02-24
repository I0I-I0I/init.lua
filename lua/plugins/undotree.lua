local M = { "jiaoshijie/undotree" }

M.lazy = true

M.dependencies = {
    "nvim-lua/plenary.nvim"
}

M.config = {
    layout = "left_left_bottom",
    position = "right",
}

M.keys = function()
    local undotree = require('undotree')
    return {
        { "<localleader>u", undotree.toggle },
    }
end

return M
