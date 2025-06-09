local M = { "nvim-telescope/telescope.nvim" }

M.priority = 100

M.dependencies = {
    "nvim-lua/plenary.nvim"
}

M.branch = "0.1.x"

M.opts = {
    defaults = { sorting_strategy = "descending" }
}

M.keys = function()
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")

    local conf = themes.get_ivy({
        sorting_strategy = "descending",
        layout_config = {
            height = 0.4,
            prompt_position = "bottom"
        },
    })

    return {
        {
            "<C-f>",
            function()
                local l_conf = themes.get_ivy({
                    previewer = false,
                    sorting_strategy = "descending",
                    layout_config = {
                        height = 0.3,
                        prompt_position = "bottom"
                    },
                })
                builtin.find_files(l_conf)
            end,
            desc = "Find files",
            { noremap = true }
        },
        { "",          function() builtin.live_grep(conf) end,   desc = "Find words" },
        { "grd",        function() builtin.diagnostics(conf) end, desc = "Find diagnostics" },
        { "<leader>fh", function() builtin.help_tags(conf) end,   desc = "Find help" },
        { "<leader>fk", function() builtin.keymaps(conf) end,     desc = "Find keymaps" },
        { "<leader>fr", function() builtin.registers(conf) end,   desc = "Find registers" },
        { "<leader>fm", function() builtin.man_pages(conf) end,   desc = "Find man pages" },
    }
end

return M
