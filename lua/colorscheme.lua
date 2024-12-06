function SetBg(bg)
	if bg == "default" then return end

	vim.cmd.hi("Normal guibg=" .. bg)
	vim.cmd([[
		hi NormalNC guibg=Normal
		hi EndOfBuffer guibg=Normal
		hi LineNr guibg=Normal
		hi SignColumn guibg=Normal
		hi DiagnosticSignError guibg=Normal
		hi DiagnosticSignWarn guibg=Normal
		hi DiagnosticSignOk guibg=Normal
		hi DiagnosticSignHint guibg=Normal
		hi DiagnosticSignInfo guibg=Normal
		hi StatusLine guibg=Normal
	]])
end

function LoadColor(packet)
	local path = vim.fn.stdpath("cache") .. "/fzf-lua/pack/fzf-lua/opt/"
	vim.opt.rtp:prepend(path .. packet)
end

function SetColor(color, bg, packet)
	if packet ~= nil then
		LoadColor(packet)
	end

	if color ~= "" then
		vim.cmd.colorscheme(color)
	end

	SetBg(bg)
end

function SetColorAndSave(theme, bg, packet)
	if packet == nil then
		packet = ""
	end

	local cmd
	if theme.lua ~= nil then
		theme = theme.lua:gsub("'", "\"")
		cmd = "LoadColor(\"" .. packet .. "\")" .. ";"
			.. theme .. ";"
			.. "SetBg(\"" .. bg .. "\")"
		vim.cmd.lua(theme)
		theme = ""
	elseif theme.name ~= nil then
		theme = theme.name
		cmd = "SetColor(" ..
			"\"" .. theme .. "\", " ..
			"\"" .. bg .. "\", " ..
			"\"" .. packet .. "\"" ..
		")"
	else
		vim.notify("SetColor: Something strange", 4)
	end

	local init = vim.fn.expand(vim.fn.stdpath("config") .. "/lua/theme.lua")
	local job_cmd = "echo '" .. cmd .. "' > " .. init
	vim.fn.jobstart(job_cmd)
	SetColor(theme, bg, packet)
end
