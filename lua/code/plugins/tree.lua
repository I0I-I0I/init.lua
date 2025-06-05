return {
    "nvim-tree/nvim-tree.lua",
    cond = false,
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
        sort = {
            sorter = "case_sensitive",
        },
        view = {
            width = 35,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = false,
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
            enable = true,
            update_root = true
        },
    },
    keys = {
        { "<C-b>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle nvim-tree" },
    }
}
