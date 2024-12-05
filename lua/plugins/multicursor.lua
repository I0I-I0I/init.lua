local M = { "jake-stewart/multicursor.nvim" }

M.branch = "1.0"

M.config = function()
	local mc = require("multicursor-nvim")

	mc.setup()

	local set = vim.keymap.set

	-- Add or skip cursor above/below the main cursor.
	set({"n", "v"}, "<A-j>", function() mc.lineAddCursor(1) end)
	set({"n", "v"}, "<A-k>", function() mc.lineAddCursor(-1) end)
	set({"n", "v"}, "<A-S-j>", function() mc.lineSkipCursor(1) end)
	set({"n", "v"}, "<A-S-k>", function() mc.lineSkipCursor(-1) end)

	-- Add or skip adding a new cursor by matching word/selection
	set({"n", "v"} , "<A-n>", function() mc.matchAddCursor(1) end)
	set({"n", "v"} , "<A-p>", function() mc.matchAddCursor(-1) end)
	set({"n", "v"} , "<A-S-n>", function() mc.matchSkipCursor(1) end)
	set({"n", "v"} , "<A-S-p>", function() mc.matchSkipCursor(-1) end)

	-- Add all matches in the document
	set({"n", "v"}, "<A-a>", mc.matchAllAddCursors)

	-- Rotate the main cursor.
	set({"n", "v"}, "<A-l>", mc.nextCursor)
	set({"n", "v"}, "<A-h>", mc.prevCursor)

	-- Delete the main cursor.
	set({"n", "v"}, "<A-x>", mc.deleteCursor)

	-- Add and remove cursors with control + left click.
	set("n", "<A-leftmouse>", mc.handleMouse)

	-- Easy way to add and remove cursors using the main cursor.
	set({"n", "v"}, "<A-q>", mc.toggleCursor)

	-- Clone every cursor and disable the originals.
	set({"n", "v"}, "<A-S-q>", mc.duplicateCursors)

	set("n", "<esc>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		elseif mc.hasCursors() then
			mc.clearCursors()
		else
			-- Default <esc> handler.
		end
	end)

	-- bring back cursors if you accidentally clear them
	set("n", "<A-g><A-v>", mc.restoreCursors)

	-- Align cursor columns.
	set("n", "<A-S-a>", mc.alignCursors)

	-- Split visual selections by regex.
	set("v", "S", mc.splitCursors)

	-- Append/insert for each line of visual selections.
	set("v", "I", mc.insertVisual)
	set("v", "A", mc.appendVisual)

	-- match new cursors within visual selections by regex.
	set("v", "M", mc.matchCursors)

	-- Jumplist support
	set({"v", "n"}, "<c-i>", mc.jumpForward)
	set({"v", "n"}, "<c-o>", mc.jumpBackward)
end

return M
