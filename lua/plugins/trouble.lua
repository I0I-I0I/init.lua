local M = { "folke/trouble.nvim" }

M.opts = {}

M.cmd = "Trouble"

M.keys = function()
    local trouble = require("trouble")
    return {
        { "<C-n>", function() trouble.next({skip_groups = true, jump = true}) end },
        { "<C-p>", function() trouble.prev({skip_groups = true, jump = true}) end },
        {
            "grd",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "grs",
            "<cmd>Trouble symbols toggle<cr>",
            desc = "LSP Symbols (Trouble)",
        },
        {
            "grr",
            "<cmd>Trouble lsp_references toggle win={position=right, size=0.5} auto_refresh=false<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>q",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    }
end

return M
