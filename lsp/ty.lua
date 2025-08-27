return {
	cmd = { "ty", "server" },
	root_dir = vim.fs.root(0, { "pyproject.toml", ".venv", "requirements.txt", "setup.py" }),
	filetypes = { "python" },
	init_options = {
		settings = {
			-- ty language server settings go here
		},
	},
}
