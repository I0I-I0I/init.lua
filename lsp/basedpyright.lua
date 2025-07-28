return {
    cmd = { "basedpyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py" }),
    settings = {
        basedpyright = {
            typeCheckingMode = "standard",
            diagnosticMode = "workspace",
        },
        python = {
            pythonPath = ".venv/bin/python"
        }
    },
    on_attach = function(client, bufnr)
        local workspace_diagnostics_ok, workspace_diagnostics = pcall(require, "workspace-diagnostics")
        if not workspace_diagnostics_ok then return end
        workspace_diagnostics.populate_workspace_diagnostics(client, bufnr)
    end
}
