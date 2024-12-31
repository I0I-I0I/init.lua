local M = { "Exafunction/codeium.vim" }

M.init = function ()
	vim.g.codeium_enabled = true
end

M.config = function ()
	local opts = { expr = true, silent = true }
	vim.keymap.set("i", "<A-w>", function() return vim.fn["codeium#AcceptNextWord"]() end, opts)
	vim.keymap.set("i", "<A-l>", function() return vim.fn["codeium#AcceptNextLine"]() end, opts)
	vim.keymap.set("i", "<A-y>", function() return vim.fn["codeium#Accept"]() end, opts)
	vim.keymap.set("i", "<A-n>", function() return vim.fn["codeium#CycleOrComplete"]() end, opts)
	vim.keymap.set("i", "<A-p>", function() return vim.fn["codeium#CycleCompletions"](-1) end, opts)

	local function toggle()
		if vim.g.codeium_enabled then
			vim.cmd("CodeiumDisable")
			vim.fn["codeium#Clear"]()
			vim.notify("Codeium is now disabled", 3)
			vim.g.codeium_enabled = false
		else
			vim.cmd("CodeiumEnable")
			vim.notify("Codeium is now active", 3)
			vim.g.codeium_enabled = true
		end
	end

	vim.keymap.set("n" , "<leader>t", toggle, opts)
	vim.keymap.set("i" , "<A-t>", toggle, opts)
end

return M
