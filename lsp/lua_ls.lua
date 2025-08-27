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
}
