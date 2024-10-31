local M = { "nvim-telescope/telescope.nvim" }

M.event = "VeryLazy"

M.dependencies = { "nvim-lua/plenary.nvim" }
M.tag = "0.1.8"

M.opts = {}

M.keys = function()
	local builtin = require("telescope.builtin")

	return {
		{ "<C-Space>", builtin.find_files, {} },
		{ "tb", builtin.buffers, {} },
		{ "", builtin.live_grep, {} },
		{
			"tiw",
			function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end,
			{},
		},
		{
			"tiW",
			function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end,
			{},
		},
		{ "z=", builtin.spell_suggest, {} },
		{
			"ts",
			function()
				local text = vim.fn.input("Grep -> ")
				if text == "" then
					return
				end
				builtin.grep_string({ search = text })
			end,
		},
		{
			"td",
			require("telescope.builtin").diagnostics,
			desc = "Lsp diagnostics",
		},
		{ "tr", builtin.registers, {} },
		{ "th", builtin.help_tags, {} },
		{ "tk", builtin.keymaps, {} },
	}
end

return M
