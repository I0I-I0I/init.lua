local M = { "stevearc/oil.nvim" }

M.event = "VimEnter"

---@module 'oil'
---@type oil.SetupOpts
M.opts = {
	default_file_explorer = true,
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	watch_for_changes = true,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["R"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	},
	use_default_keymaps = false
}

M.keys = {
	{ "-", "<cmd>Oil<cr>", { desc = "Open Oil", noremap = true } }
}

return M
