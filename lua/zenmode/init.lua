local zenmode = require("zenmode.zenmode")

vim.api.nvim_create_user_command("ZenmodeToggle", function(c)
	zenmode.zenmode_toggle(c.fargs[1])
end, { nargs = "?" })

vim.api.nvim_create_user_command("ZenmodeOpen", function(c)
	zenmode.zenmode_close()
	zenmode.zenmode_open(c.fargs[1])
end, { nargs = "?" })

vim.api.nvim_create_user_command("ZenmodeClose", function()
	zenmode.zenmode_close()
end, { nargs = "?" })

vim.api.nvim_create_user_command("ZenmodeCloseAll", function()
	zenmode.zenmode_close_all()
end, { nargs = "?" })

vim.api.nvim_create_user_command("ZenmodeOpenAll", function(c)
	zenmode.zenmode_close_all()
	zenmode.zenmode_open_all(c.fargs[1])
end, { nargs = "?" })

local o = vim.opt
local defaults = {
	rnu = o.rnu,
	nu = o.nu,
	laststatus = o.laststatus,
	cmdheight = o.cmdheight,
	fillchars = o.fillchars
}

local on_open = {
	fillchars = "eob:\\u00A0,vert:\\u00A0",
	rnu = false,
	nu = false,
	laststatus = 0,
	cmdheight = 0
}

local function onOpen(size)
	vim.cmd("ZenmodeOpenAll " .. size)
	for key, value in pairs(on_open) do
		o[key] = value
	end
end

vim.keymap.set("n", "ZO", function ()
	onOpen(20)
end, { silent = true })
vim.keymap.set("n", "Zo", function ()
	onOpen(40)
end, { silent = true })

vim.keymap.set("n", "zO", function ()
	vim.cmd("ZenmodeOpenAll 20")
end, { silent = true })
vim.keymap.set("n", "zo", function ()
	vim.cmd("ZenmodeOpenAll 40")
end, { silent = true })

vim.keymap.set("n", "zc",function ()
	vim.cmd("ZenmodeCloseAll")
	for key, value in pairs(defaults) do
		o[key] = value
	end
end, { silent = true })
