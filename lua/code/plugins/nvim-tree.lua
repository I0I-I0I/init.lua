local function set_centered(width)
    local col_count = vim.api.nvim_get_option_value('columns', {scope = 'local'})
    return math.floor((col_count - 5 - width) / 2)
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function ()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        vim.opt.termguicolors = true
    end,
    opts = {
        sort = {
            sorter = "case_sensitive",
        },
        view = {
            float = {
                enable = true,
                open_win_config = {
                    relative = "editor",
                    width = 90,
                    height = 40,
                    row = 1,
                    col = set_centered(90),
                },
            }
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
