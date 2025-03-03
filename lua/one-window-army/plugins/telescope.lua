local M = { "nvim-telescope/telescope.nvim" }

M.lazy = false

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
        { "<C-f>", function()
            local l_conf = themes.get_ivy({
                previewer = false,
                layout_config = { height = 0.3, },
            })
            builtin.find_files(l_conf)
        end, desc = "Find files" },
        { "", function() builtin.live_grep(conf) end, desc = "Find words" },
        { "th", function() builtin.help_tags(conf) end, desc = "Find help" },
        { "tk", function() builtin.keymaps(conf) end, desc = "Find keymaps" },
        { "tr", function() builtin.registers(conf) end, desc = "Find registers" },
        { "tm", function() builtin.man_pages(conf) end, desc = "Find man pages" },
        { "grr", function() builtin.lsp_references(conf) end, desc = "Find lsp references" },
        { "grd", function() builtin.diagnostics(conf) end, desc = "Find diagnostics" },
    }
end

return M
