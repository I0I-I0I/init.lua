return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py" }),
	settings = {
		basedpyright = {
			typeCheckingMode = "strict",
			diagnosticMode = "workspace",
			analysis = {
				autoSearchPaths = true, -- pick up installed packages & stubs
				useLibraryCodeForTypes = true, -- fall back to library .pyi for typing
				typeCheckingMode = "strict", -- or "strict" if you’re brave
				extraPaths = { "src" }, -- mirror your pyrightconfig.json
				disableLanguageServices = false,
				diagnosticMode = "workspace",
			},
		},
		python = {
			pythonPath = ".venv/bin/python",
		},
	},
}
