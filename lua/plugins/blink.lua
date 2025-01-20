local M = { "Saghen/blink.cmp" }

M.version = '*'

M.opts = {
    keymap = { preset = "default" },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
}

return M
