return {
    -- django-template-lsp
    cmd = { "djlsp" },
    root_dir = vim.fs.root(0, { "pyproject.toml", ".venv", "requirements.txt", "setup.py" }),
    filetypes = { "htmldjango", "html", "python" },
}
