local M = {
	buf = {},
}

local function create_window(width, direction, current_tab)
	vim.api.nvim_command("vsp")
	vim.api.nvim_command("wincmd " .. direction)
	pcall(vim.cmd, "buffer " .. M.buf[current_tab])
	vim.api.nvim_win_set_width(0, width)
	vim.wo.winfixwidth = true
	vim.wo.cursorline = false
	vim.wo.winfixbuf = true
	vim.o.numberwidth = 1
	vim.wo.rnu = false
	vim.wo.nu = false
end

function M.zenmode_open(c, current_tab)
	if not current_tab then
		current_tab = vim.fn.tabpagenr()
	end

	if M.buf[current_tab] then
		return
	end

	M.buf[current_tab] = vim.api.nvim_create_buf(false, false)

    local width = 30
    if c then
        width = tonumber(c)
    end

	local cur_win = vim.fn.win_getid()

	create_window(width, "H", current_tab)
	create_window(width, "L", current_tab)

	vim.api.nvim_set_current_win(cur_win)
end

function M.zenmode_open_all(c)
	local start_tab = vim.api.nvim_get_current_tabpage()
	local tabs = vim.api.nvim_list_tabpages()
	for _, value in pairs(tabs) do
		vim.api.nvim_set_current_tabpage(value)
		M.zenmode_open(c, value)
	end
	vim.api.nvim_set_current_tabpage(start_tab)
end

function M.zenmode_close(current_tab)
	if not current_tab then
		current_tab = vim.fn.tabpagenr()
	end

	if not M.buf[current_tab] then
		return
	end

	vim.api.nvim_buf_delete(M.buf[current_tab], { force = true })
	M.buf[current_tab] = nil
end

function M.zenmode_close_all()
	for key, _ in pairs(M.buf) do
		M.zenmode_close(key)
	end
end

function M.zenmode_toggle(c)
	local current_tab = vim.fn.tabpagenr()
	if not M.buf[current_tab] then
		M.zenmode_open(c)
	else
		M.zenmode_close()
	end
end

return M
