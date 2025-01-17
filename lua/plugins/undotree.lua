local M = { "jiaoshijie/undotree" }

M.dependencies = {
    "nvim-lua/plenary.nvim"
}

M.config = {
    layout = "left_bottom",
    position = "right",
}

M.keys = function()
    local undotree = require('undotree')
    return {
        { "<leader>u", undotree.toggle },
    }
end

return M
