local M = { "nvim-telescope/telescope.nvim" }

M.tag = "0.1.8"

M.dependencies = {
    "nvim-lua/plenary.nvim"
}

M.keys = function ()
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")

    local conf = themes.get_ivy({
        layout_config = {
            height = 0.4,
        },
    })

    return {
        { "<C-f><C-f>", function()
            local l_conf = themes.get_ivy({
                previewer = false,
                layout_config = { height = 0.3, },
            })
            builtin.find_files(l_conf)
        end, desc = "Find files" },
        { "<C-f>", function() builtin.live_grep(conf) end, desc = "Find words" },
        { "<C-f><C-h>", function() builtin.help_tags(conf) end, desc = "Find help" },
        { "<C-f><C-k>", function() builtin.keymaps(conf) end, desc = "Find keymaps" },
        { "<C-f><C-r>", function() builtin.registers(conf) end, desc = "Find registers" },
        { "<C-f>m", function() builtin.man_pages(conf) end, desc = "Find man pages" },
        { "grr", function() builtin.lsp_references(conf) end, desc = "Find lsp references" },
        { "grd", function() builtin.diagnostics(conf) end, desc = "Find diagnostics" },
    }
end

return M
