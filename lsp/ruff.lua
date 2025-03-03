return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py" },
    init_opts = {
        settings = {
            lint = { preview = true },
            format = { preview = true }
        },
    },
    on_attach = function(client, bufnr)
        vim.lsp.semantic_tokens.enable(false, { bufnr = bufnr })
        local workspace_diagnostics_ok, workspace_diagnostics = pcall(require, "workspace-diagnostics")
        if not workspace_diagnostics_ok then return end
        workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
    end
}
