local M = { "monkoose/neocodeium" }

M.event = "VeryLazy"

M.config = function()
	local neocodeium = require("neocodeium")
	local flag = false

	neocodeium.setup({
		enabled = flag,
		silent = true
	})

	local commands = require("neocodeium.commands")

	vim.keymap.set({ "n", "i" }, "<A-t>", function ()
		if flag then
			commands.disable()
			if neocodeium.visible() then
				neocodeium.clear()
			end
			print("NeoCodeium disabled")
		else
			commands.enable()
			print("NeoCodeium enabled")
		end
		flag = not flag
	end)
	vim.keymap.set("i", "<A-w>", neocodeium.accept_word)
	vim.keymap.set("i", "<A-l>", neocodeium.accept_line)
	vim.keymap.set("i", "<A-y>", neocodeium.accept)
	vim.keymap.set("i", "<A-n>", neocodeium.cycle_or_complete)
	vim.keymap.set("i", "<A-p>", function()
		neocodeium.cycle_or_complete(-1)
	end)
end

return M
