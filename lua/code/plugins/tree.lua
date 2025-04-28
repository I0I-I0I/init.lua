return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    init = function()
        vim.g.loaded_netrwPlugin = 1
    end,
    opts = { open_for_directories = true },
    keys = {
        {
            "-",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            "<leader>-",
            "<cmd>Yazi cwd<cr>",
            desc = "Open the file manager in nvim's working directory",
        }
    }
}
