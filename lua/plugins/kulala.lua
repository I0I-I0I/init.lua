local M = { "mistweaverco/kulala.nvim" }

M.opts = {}

M.keys = function ()
    local kulala = require("kulala")
    return {
        { "<leader>rr", kulala.run, desc = "Run http request" },
        { "<leader>rs", kulala.search, desc = "Search by http requests" },
        { "<leader>ri", kulala.inspect, desc = "Inspect http request" },
    }
end

return M
