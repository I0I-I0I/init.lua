return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py" },
	init_opts = {
		settings = {
			lint = { preview = true },
			format = { preview = true },
		},
	},
}
