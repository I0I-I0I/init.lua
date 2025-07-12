local M = { "nvim-telescope/telescope.nvim" }

M.priority = 100
M.dependencies = { "nvim-lua/plenary.nvim" }
M.branch = "0.1.x"
M.lazy = true

M.opts = {
    defaults = {
        sorting_strategy = "descending",
        file_ignore_patterns = {
            "node_modules", "build", "dist", "yarn.lock"
        },
    },
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
                vim.o.winborder = "none"
                local l_conf = themes.get_ivy({
                    previewer = false,
                    sorting_strategy = "descending",
                    layout_config = {
                        height = 0.3,
                        prompt_position = "bottom"
                    },
                })
                builtin.find_files(l_conf)
                vim.o.winborder = "rounded"
            end,
            desc = "Find files",
            { noremap = true }
        },
        {
            "",
            function()
                vim.o.winborder = "none"
                builtin.live_grep(conf)
                vim.o.winborder = "rounded"
            end,
            desc = "Find words"
        },
        {
            "grd",
            function()
                vim.o.winborder = "none"
                builtin.diagnostics(conf)
                vim.o.winborder = "rounded"
            end,
            desc = "Find diagnostics"
        },
        {
            "<leader>fh",
            function()
                vim.o.winborder = "none"
                builtin.help_tags(conf)
                vim.o.winborder = "rounded"
            end,
            desc = "Find help"
        },
        {
            "<leader>fk",
            function()
                vim.o.winborder = "none"
                builtin.keymaps(conf)
                vim.o.winborder = "rounded"
            end,
            desc = "Find keymaps"
        },
        {
            "<leader>fr",
            function()
                vim.o.winborder = "none"
                builtin.registers(conf)
                vim.o.winborder = "rounded"
            end,
            desc = "Find registers"
        },
        {
            "<leader>fm",
            function()
                vim.o.winborder = "none"
                builtin.man_pages(conf)
                vim.o.winborder = "rounded"
            end,
            desc = "Find man pages"
        },
    }
end

return M
