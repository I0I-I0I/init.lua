local M = { "jake-stewart/multicursor.nvim" }

M.event = { "BufRead", "BufNewFile" }
M.branch = "1.0"

M.config = function()
	local mc = require("multicursor-nvim")

	mc.setup()

	local set = vim.keymap.set

	set({"n", "v"}, "<A-j>", function() mc.lineAddCursor(1) end)
	set({"n", "v"}, "<A-k>", function() mc.lineAddCursor(-1) end)
	set({"n", "v"}, "<A-S-j>", function() mc.lineSkipCursor(1) end)
	set({"n", "v"}, "<A-S-k>", function() mc.lineSkipCursor(-1) end)

	set({"n", "v"} , "<A-n>", function() mc.matchAddCursor(1) end)
	set({"n", "v"} , "<A-p>", function() mc.matchAddCursor(-1) end)
	set({"n", "v"} , "<A-S-n>", function() mc.matchSkipCursor(1) end)
	set({"n", "v"} , "<A-S-p>", function() mc.matchSkipCursor(-1) end)

	set({"n", "v"}, "<A-a>", mc.matchAllAddCursors)

	set({"n", "v"}, "<A-l>", mc.nextCursor)
	set({"n", "v"}, "<A-h>", mc.prevCursor)

	set({"n", "v"}, "<A-x>", mc.deleteCursor)

	set("n", "<A-leftmouse>", mc.handleMouse)

	set({"n", "v"}, "<A-q>", mc.toggleCursor)

	set({"n", "v"}, "<A-S-q>", mc.duplicateCursors)

	set("n", "<esc>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		elseif mc.hasCursors() then
			mc.clearCursors()
		else
			--
		end
	end)
	set("n", "<C-[>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		elseif mc.hasCursors() then
			mc.clearCursors()
		else
			--
		end
	end)

	set("n", "<A-g><A-v>", mc.restoreCursors)

	set("n", "<A-S-a>", mc.alignCursors)

	set("v", "S", mc.splitCursors)

	set("v", "I", mc.insertVisual)
	set("v", "A", mc.appendVisual)

	set("v", "M", mc.matchCursors)

	set({"v", "n"}, "<c-i>", mc.jumpForward)
	set({"v", "n"}, "<c-o>", mc.jumpBackward)
end

return M
