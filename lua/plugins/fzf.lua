local M = { "ibhagwan/fzf-lua", cond = false }

M.lazy = true

M.config = function()
	local fzf = require("fzf-lua")

	fzf.register_ui_select()
	fzf.setup({ "max-perf" })
end

M.keys = function()
	local fzf = require("fzf-lua")
	return {
		{ "<C-f>", fzf.files, {} },
		{ "<C-b>", fzf.buffers, {} },

		{ "", fzf.live_grep, {} },
		{ "tiw", fzf.grep_cword, {} },
		{ "tiW", fzf.grep_cWORD, {} },
		{ "", fzf.grep_visual, mode = "v", {} },

		{ "z=", fzf.spell_suggest, {} },
		{ "tr", fzf.registers, {} },
		{ "th", fzf.helptags, {} },
		{ "tk", fzf.keymaps, {} },
		{ "tm", fzf.manpages, {} },

		{ "grr", fzf.lsp_references, { noremap = true } },
		{ "grf", fzf.lsp_finder, { noremap = true } },
		{ "grd", fzf.lsp_workspace_diagnostics, {} },
	}
end

return M
