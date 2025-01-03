local M = {}

M.mini = { "echasnovski/mini.ai" }
M.mini.version = false
M.mini.opts = {
	mappings = {
		around = '',
		inside = '',
	}
}

M.swap = { "Wansmer/sibling-swap.nvim" }
M.swap.config = function()
	require("sibling-swap").setup {
		allowed_separators = {
			',',
			';',
			'and',
			'or',
			'&&',
			'&',
			'||',
			'|',
			'==',
			'===',
			'!=',
			'!==',
			'-',
			'+',
			['<'] = '>',
			['<='] = '>=',
			['>'] = '<',
			['>='] = '<=',
		},
		use_default_keymaps = false,
		keymaps = {},
		highlight_node_at_cursor = false,
		ignore_injected_langs = false,
		allow_interline_swaps = true,
		interline_swaps_without_separator = false,
		fallback = {},
	}
end

M.swap.keys = function ()
	local ss = require('sibling-swap')
	return {
		{ "]a", ss.swap_with_right, desc = "Swap with Right" },
		{ "[a", ss.swap_with_left, desc = "Swap with Left" },
		{ "]A", ss.swap_with_right_with_opp, desc = "Swap with Right with Opposite" },
		{ "[A", ss.swap_with_left_with_opp, desc = "Swap with Left with Opposite" },
	}
end
return {
	M.mini,
	M.swap
}
