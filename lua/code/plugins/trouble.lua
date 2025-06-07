local M = { "folke/trouble.nvim", cond = false }

M.opts = {}

M.cmd = "Trouble"

M.keys = function()
    local trouble = require("trouble")
    return {
        { "<C-n>", function() trouble.next({ skip_groups = true, jump = true }) end },
        { "<C-p>", function() trouble.prev({ skip_groups = true, jump = true }) end },
        {
            "grd",
            "mZ<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "grs",
            "<cmd>Trouble symbols toggle win={position=right, size=0.3}<cr>",
            desc = "LSP Symbols (Trouble)",
        },
        {
            "grr",
            "mB<cmd>Trouble lsp_references toggle win={position=right, size=0.5} auto_refresh=false<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>q",
            "mB<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    }
end

return M
