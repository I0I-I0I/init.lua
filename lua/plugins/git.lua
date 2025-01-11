local M = { "lewis6991/gitsigns.nvim" }

M.lazy = true
M.event = { "BufRead", "BufNewFile" }

M.opts = {}

M.keys = function()
    local gitsigns = require("gitsigns")
    return {
        { "<leader>gs", gitsigns.stage_hunk, desc = "Git Stage Hunk" },
        { "<leader>gp", gitsigns.preview_hunk, desc = "Git Preview Hunk" },
        { "<leader>gS", gitsigns.show, desc = "Git Show Previus Version" },
        { "<leader>gd", gitsigns.diffthis, desc = "Git Show Diff" },
        { "<leader>gb", gitsigns.blame_line, desc = "Git Blame Line" },
        { "]h", gitsigns.next_hunk, desc = "Goto next hunk" },
        { "[h", gitsigns.prev_hunk, desc = "Goto previous hunk" },
    }
end

return M
