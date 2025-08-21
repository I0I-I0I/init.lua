return {
    cmd = { "lua-language-server" },
    root_dir = vim.fs.root(0, { "lua" }),
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            -- workspace = {
            --     library = vim.api.nvim_get_runtime_file("", true),
            -- },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
            },
            complition = { callSnippet = "Replace" },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
            hint = {
                enable = true,
                arrayIndex = "Auto",
                await = true,
                paramName = "All",
                paramType = true,
                semicolon = "SameLine",
                setType = true,
            },
        },
    },
    on_attach = function(client, bufnr)
        vim.lsp.semantic_tokens.enable(false, { bufnr = bufnr })
        local workspace_diagnostics_ok, workspace_diagnostics = pcall(require, "workspace-diagnostics")
        if not workspace_diagnostics_ok then return end
        workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
    end
}
