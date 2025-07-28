return {
    cmd = { "/home/nnofly/.local/bin/djlsp" },
    root_dir = vim.fs.root(0, { "pyproject.toml", ".venv", "requirements.txt", "setup.py" }),
    filetypes = { "htmldjango", "html", "python" },
}
