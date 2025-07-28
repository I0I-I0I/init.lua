return {
    cmd = { "clangd", "--compile-commands-dir=." },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    init_options = {
        usePlaceholders = false,
        completeUnimported = true,
        clangdFileStatus = true,
        compilationDatabasePath = ".",
    },
    on_attach = function(client, bufnr)
        require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

        vim.api.nvim_create_autocmd("FileType", {
            buffer = bufnr,
            callback = function()
                vim.keymap.set("n", "<A-s>", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = bufnr })
            end
        })
    end,
}
