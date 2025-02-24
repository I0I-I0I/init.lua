local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

local conf = themes.get_ivy({
    layout_config = {
        height = 0.4,
    },
})

vim.keymap.set("n", "<C-f><C-f>", function()
    local l_conf = themes.get_ivy({
        previewer = false,
        layout_config = { height = 0.3, },
    })
    builtin.find_files(l_conf)
end, { desc = "Find files" })
vim.keymap.set("n", "<C-f>", function() builtin.live_grep(conf) end, { desc = "Find words" })
vim.keymap.set("n", "<C-f><C-h>", function() builtin.help_tags(conf) end, { desc = "Find help" })
vim.keymap.set("n", "<C-f><C-k>", function() builtin.keymaps(conf) end, { desc = "Find keymaps" })
vim.keymap.set("n", "<C-f><C-r>", function() builtin.registers(conf) end, { desc = "Find registers" })
vim.keymap.set("n", "<C-f>m", function() builtin.man_pages(conf) end, { desc = "Find man pages" })
vim.keymap.set("n", "grr", function() builtin.lsp_references(conf) end, { desc = "Find lsp references" })
vim.keymap.set("n", "grd", function() builtin.diagnostics(conf) end, { desc = "Find diagnostics" })
