local M = { "monkoose/neocodeium" }

M.event = "VeryLazy"

M.config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup({ manual = false })
    vim.keymap.set("i", "<A-y>", neocodeium.accept)
    vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
    vim.keymap.set("i", "<A-l>", neocodeium.accept_line)
    vim.keymap.set("i", "<A-n>", neocodeium.cycle_or_complete)
    vim.keymap.set("i", "<A-p>", function() neocodeium.cycle_or_complete(-1) end)
    vim.keymap.set("i", "<A-e>", neocodeium.clear)
end

return M
