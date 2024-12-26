local M = { "saghen/blink.cmp" }

M.version = "*"
M.dependencies = "rafamadriz/friendly-snippets"

M.opts = {
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono"
	},

	sources = {
		default = function(_)
			local success, node = pcall(vim.treesitter.get_node)
			if vim.bo.filetype == "lua" then
				return { "lsp", "path" }
			elseif success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
				return { "buffer" }
			elseif vim.bo.filetype == "sql" then
				return { "dadbod" }
			else
				return { "lsp", "path", "snippets" }
			end
		end,
		providers = {
			snippets = {
				should_show_items = function(ctx)
					return ctx.trigger.initial_kind ~= "." or "\"" or "->"
				end
			},
			dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
		},
	},

	completion = {
		menu = {
			border = "none",
			auto_show = true
		},
		documentation = {
			window = { border = "rounded" },
		},
		trigger = {
			show_on_keyword = true,
			show_on_trigger_character = true,
			show_on_insert_on_trigger_character = true
		}
	},

	signature = {
		enabled = true,
		window = { border = "rounded" }
	},

	keymap = {
		preset = "default",
		["<C-s>"] = { "show_documentation", "hide_documentation" },
	}
}

return M
