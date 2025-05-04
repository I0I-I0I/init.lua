local M = { "stevearc/oil.nvim" }

M.lazy = false

M.config = function()
    require("oil").setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        prompt_save_on_select_new_entry = false,

        use_default_keymaps = false,
        keymaps = {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["q"] = { "actions.close", mode = "n" },
            ["<Esc>"] = { "actions.close", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = { "actions.close", mode = "n" },
            ["R"] = "actions.refresh",
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["gs"] = { "actions.change_sort", mode = "n" },
            ["gx"] = "actions.open_external",
            ["g."] = { "actions.toggle_hidden", mode = "n" },
            ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
        float = { max_width = 0.3 },
    })
end

M.keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open file tree" }
}

return M
