local M = { "saghen/blink.cmp", enabled = false }

M.version = "*"
M.dependencies = "rafamadriz/friendly-snippets"

M.opts = {
    signature = { enabled = true, window = { border = "rounded" } },
    completion = {
        menu = { auto_show = true, },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            window = { border = "rounded" }
        },
    },
    sources = { default = { "lsp", "snippets" }, },
    keymap = {
        cmdline = { preset = "super-tab" },
        preset = "default",
    },
    snippets = { preset = "default" }
}

return M
