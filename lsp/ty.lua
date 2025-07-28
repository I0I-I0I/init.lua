return {
    cmd = { "ty", "server" },
    root_dir = vim.fs.root(0, { "pyproject.toml", ".venv", "requirements.txt", "setup.py" }),
    filetypes = { "python" },
    init_options = {
        settings = {
            -- ty language server settings go here
        }
    },
    on_attach = function(client, bufnr)
        local workspace_diagnostics_ok, workspace_diagnostics = pcall(require, "workspace-diagnostics")
        if not workspace_diagnostics_ok then return end
        workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
    end
}
