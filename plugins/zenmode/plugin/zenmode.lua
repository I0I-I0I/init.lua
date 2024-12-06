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
