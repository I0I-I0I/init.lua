local M = { "ibhagwan/fzf-lua" }

M.dependencies = {
	"rktjmp/lush.nvim"
}

M.config = function()
	local fzf = require("fzf-lua")
	fzf.register_ui_select()
	fzf.setup()
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
		{ "tt", fzf.awesome_colorschemes, {} },

		{ "gra", fzf.lsp_code_actions, {} },
		{ "grr", fzf.lsp_references, { noremap = true } },
		{ "td", fzf.lsp_workspace_diagnostics, {} },
	}
end

return M
