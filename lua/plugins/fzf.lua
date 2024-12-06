local M = { "ibhagwan/fzf-lua" }

M.dependencies = {
	"rktjmp/lush.nvim"
}

local transparent = false
local external = {
	["solarized-osaka.nvim"] = "#05181f",
	["neosolarized.nvim"] = "#05181f",
	["oceanic-next"] = "#1c1c1c"
}

M.config = function()
	local fzf = require("fzf-lua")

	fzf.register_ui_select()
	fzf.setup({
		"max-perf",
		awesome_colorschemes = {
			actions = {
				["enter"] = function(selected, opts)
					local dbkey, idx = selected[1]:match("^(.-):(%d+):")
					local theme = opts._adm.db[dbkey].colorschemes[tonumber(idx)]
					local bg = "default"
					if transparent then
						vim.api.nvim_del_augroup_by_name("TransparentGroup")
						bg = "NONE"
					elseif external[dbkey] ~= nil then
						bg = external[dbkey]
					end
					SetColorAndSave(theme , bg, dbkey)
				end
			}
		}
	})
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
		{ "tt", function ()
			transparent = false
			fzf.awesome_colorschemes()
		end, {} },
		{ "tat", function ()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("TransparentGroup", {}),
				callback = function()
					SetBg("NONE")
				end
			})
			transparent = true
			fzf.awesome_colorschemes()
		end, {} },

		{ "gra", fzf.lsp_code_actions, {} },
		{ "grr", fzf.lsp_references, { noremap = true } },
		{ "td", fzf.lsp_workspace_diagnostics, {} },
	}
end

return M
