local M = { "nvim-treesitter/nvim-treesitter" }

M.build = ":TSUpdate"
M.event = { "BufRead", "BufNewFile" }

M.config = function()
	local treesitter = require("nvim-treesitter.configs")
	treesitter.setup({
		ensure_installed = {
			"lua",
			"json",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"gitignore",
			"vim",
			"vimdoc",
		},
		sync_install = false,
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = { "BufWrite", "CursorHold" },
		},
	})
end

return M
