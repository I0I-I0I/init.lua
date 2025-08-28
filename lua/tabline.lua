local tabline = {}

local function set_hl(hl)
	if type(hl) ~= "string" or vim.fn.hlexists(hl) == 0 then
		return ""
	end
	return "%#" .. hl .. "#"
end

local function get_project_root(buf)
	local clients = vim.lsp.get_clients({ bufnr = buf })
	if clients and #clients > 0 then
		local root_dir = clients[1].config.root_dir
		if root_dir and root_dir ~= "" then
			return root_dir
		end
	end
	return vim.fn.getcwd()
end

local function relative_path_from_root(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	if name == "" then
		return ""
	end
	local root = get_project_root(buf)
	return vim.fn.fnamemodify(name, ":." .. root)
end

local function is_hidden_buffer(buf)
	local name = vim.api.nvim_buf_get_name(buf)
	local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
	local ft = vim.api.nvim_buf_get_option(buf, "filetype")
	return (buftype ~= "" or name == "" or ft == "Scratch")
end

local function strip_formatting(str)
	str = str:gsub("%%#.-#", "")
	str = str:gsub("%%%d+T", "")
	str = str:gsub("%%X", "")
	str = str:gsub("%%=", "")
	return str
end

local function calculate_visible_width(str)
	local stripped = strip_formatting(str)
	return #stripped
end

local function get_file_path(buf)
	if is_hidden_buffer(buf) then
		return ""
	end
	local path = relative_path_from_root(buf)
	return " " .. path .. " "
end

function tabline.tabs(config)
	local _o = ""
	local tabs = vim.api.nvim_list_tabpages()
	local current = vim.api.nvim_get_current_tabpage()
	for i, tab in ipairs(tabs) do
		if tab == current then
			_o = table.concat({
				_o,
				set_hl(config.active_hl),
				" ",
				tostring(i),
				" ",
				set_hl("Normal"),
			})
		else
			_o = table.concat({
				_o,
				"%" .. i .. "T",
				set_hl(config.inactive_hl),
				" ",
				tostring(i),
				" ",
				set_hl("Normal"),
				"%X",
			})
		end
		if i ~= #tabs then
			_o = _o .. " "
		end
	end
	return _o
end

function tabline.render()
	local total_width = vim.api.nvim_get_option("columns")

	local config = { active_hl = "DiffAdd", inactive_hl = "Folded" }
	local left_str = tabline.tabs(config)
	local left_width = calculate_visible_width(left_str)

	local buf = vim.api.nvim_get_current_buf()
	local curr_line = 0
	local total_lines = 0
	local ok, cursor = pcall(vim.api.nvim_win_get_cursor, 0)
	if ok and cursor and type(cursor) == "table" then
		curr_line = cursor[1]
	else
		curr_line = 0
	end
	local ok2, count = pcall(vim.api.nvim_buf_line_count, buf)
	if ok2 and type(count) == "number" then
		total_lines = count
	else
		total_lines = 0
	end

	local right_str = ""
	right_str = right_str
		.. set_hl(config.active_hl)
		.. " "
		.. tostring(curr_line)
		.. ":"
		.. tostring(total_lines)
		.. " "
		.. set_hl("Normal")
	local right_width = calculate_visible_width(right_str)

	local path = get_file_path(buf)
	local path_length = #path

	local center_str = ""
	if path_length > 0 then
		local desired_start_pos = math.floor((total_width - path_length) / 2)
		local padding_before = desired_start_pos - left_width
		if padding_before < 0 then
			padding_before = 0
		end
		local available_width = total_width - left_width - right_width
		local padding_after = math.max(0, available_width - padding_before - path_length)
		center_str = string.rep(" ", padding_before)
			.. set_hl("Directory")
			.. path
			.. set_hl("Normal")
			.. string.rep(" ", padding_after)
	end

	return left_str .. "%=" .. center_str .. "%=" .. right_str
end

function tabline.setup()
	vim.o.tabline = "%!v:lua.require('tabline').render()"

	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			local diff = vim.api.nvim_get_hl_by_name("DiffAdd", true)
			local bg = diff.background and string.format("#%06x", diff.background)
			vim.cmd.hi("Directory guibg=" .. (bg or "NONE"))
		end,
	})

	local group = vim.api.nvim_create_augroup("TablineRefresh", { clear = true })
	vim.api.nvim_create_autocmd({
		"CursorMoved",
		"CursorMovedI",
		"BufEnter",
		"BufWinEnter",
		"WinEnter",
	}, {
		group = group,
		callback = function()
			local buf = vim.api.nvim_get_current_buf()
			if vim.api.nvim_buf_get_option(buf, "filetype") == "cmd" then
				return
			end
			local ok = pcall(vim.cmd.redrawtabline)
			if not ok then
				pcall(vim.cmd.redraw)
			end
		end,
	})
end

return tabline
