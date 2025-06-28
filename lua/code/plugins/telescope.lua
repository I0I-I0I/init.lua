local M = { "nvim-telescope/telescope.nvim" }

M.priority = 100

M.dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
}

M.branch = "0.1.x"

M.config = function()
    require("telescope").setup({
        defaults = {
            sorting_strategy = "descending",
            file_ignore_patterns = {
                "node_modules", "build", "dist", "yarn.lock"
            },
        },
        extensions = {
            file_browser = {
                path = "%:p:h",
                cwd_to_path = true,
                hide_parent_dir = true,
                select_buffer = true,
                hidden = false,
                follow_symlinks = true,
                prompt_path = true,
                quiet = true,
                display_stat = false,
                hijack_netrw = false,
                use_fd = true,
                mappings = {
                    ["i"] = { ["<Tab>"] = "select_default" },
                    ["n"] = { ["<Tab>"] = "select_default" },
                },
            },
        },
    })

    require("telescope").load_extension("neoclip")
    require("telescope").load_extension("file_browser")
end

M.keys = function()
    local builtin = require("telescope.builtin")
    local themes = require("telescope.themes")
    local extensions = require("telescope").extensions
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
        { "<localleader><C-f>", function()
            local l_conf = themes.get_ivy({
                previewer = false,
                sorting_strategy = "descending",
                layout_config = {
                    height = 0.5,
                    prompt_position = "bottom"
                },
            })
            extensions.file_browser.file_browser(l_conf)
        end, },
        { "",          function() builtin.live_grep(conf) end,   desc = "Find words" },
        { "grd",        function() builtin.diagnostics(conf) end, desc = "Find diagnostics" },
        { "<leader>fh", function() builtin.help_tags(conf) end,   desc = "Find help" },
        { "<leader>fk", function() builtin.keymaps(conf) end,     desc = "Find keymaps" },
        { "<leader>fr", function() builtin.registers(conf) end,   desc = "Find registers" },
        { "<leader>fm", function() builtin.man_pages(conf) end,   desc = "Find man pages" },
    }
end

return M
