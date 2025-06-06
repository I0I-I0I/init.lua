local M = { "monkoose/neocodeium" }

M.opts = {
    enabled = true,
    manual = false,
    show_label = false,
    silent = false,
    filetypes = {
        TelescopePrompt = false,
        ["dap-repl"] = false,
    },
    filter = function(bufnr)
        if vim.endswith(vim.api.nvim_buf_get_name(bufnr), ".env") then
            return false
        end
        return true
    end
}

M.keys = function()
    local neocodeium = require("neocodeium")
    return {
        { "<A-a>", mode = { "n", "i" }, "<cmd>NeoCodeium enable<cr>" },
        { "<A-y>", mode = "i",          neocodeium.accept },
        { "<A-w>", mode = "i",          neocodeium.accept_word },
        { "<A-l>", mode = "i",          neocodeium.accept_line },
        { "<A-n>", mode = "i",          neocodeium.cycle_or_complete },
        { "<A-p>", mode = "i",          function() neocodeium.cycle_or_complete(-1) end },
        { "<A-e>", mode = "i",          neocodeium.clear }
    }
end

return M
