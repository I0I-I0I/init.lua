-- local M = { "augmentcode/augment.vim" }
--
-- M.lazy = false
--
-- M.keys = {
--     { "<localleader><C-a>c", "<cmd>Augment chat<cr>", mode = { "n", "v" } },
--     { "<localleader><C-a>t", "<cmd>Augment chat-toggle<cr>" },
--     { "<localleader><C-a>n", "<cmd>Augment chat-new<cr>" },
--     { "<localleader><C-a>s", "<cmd>Augment status<cr>" }
-- }
--
-- return M

local M = { "monkoose/neocodeium" }

M.opts = {
    enabled = true,
    manual = false,
    filetypes = {
        TelescopePrompt = false,
        ["dap-repl"] = false,
    },
}

M.keys = function()
    local neocodeium = require("neocodeium")
    return {
        { "<A-a>", mode = { "n", "i" }, "<cmd>NeoCodeium enable<cr>" },
        { "<A-y>", mode = "i", neocodeium.accept },
        { "<A-w>", mode = "i", neocodeium.accept_word },
        { "<A-l>", mode = "i", neocodeium.accept_line },
        { "<A-n>", mode = "i", neocodeium.cycle_or_complete },
        { "<A-p>", mode = "i", function() neocodeium.cycle_or_complete(-1) end },
        { "<A-e>", mode = "i", neocodeium.clear }
    }
end

return M
