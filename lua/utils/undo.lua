local function dir_exists(path)
	local ok, err, code = os.rename(path, path)
	if not ok then
		if code == 13 then
			return true
		end
	end
	return ok, err
end

local function create_dir_if_not_exists(path)
	if not dir_exists(path) then
		os.execute("mkdir -p " .. path)
	end
end

local undodir
if os.getenv('WSL_DISTRO_NAME') ~= nil then
	undodir = "/mnt/d/undo"
else
	undodir = os.getenv("HOME") .. "/undo"
end

create_dir_if_not_exists(undodir)
vim.opt.undodir = undodir
