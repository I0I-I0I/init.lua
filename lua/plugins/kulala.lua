local M = { "mistweaverco/kulala.nvim" }

M.opts = {}

M.keys = function()
    local kulala = require("kulala")
    return {
        { "<localleader>r", kulala.run, desc = "Run http request" },
        { "<localleader><C-r>s", kulala.search, desc = "Search by http requests" },
        { "<localleader><C-r>i", kulala.inspect, desc = "Inspect http request" },
    }
end

return M
