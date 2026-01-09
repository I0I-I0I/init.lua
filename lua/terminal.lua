-- :h terminal
-- PROMPT_COMMAND='printf "\033]133;A\007"'  # enable OSC 133
vim.cmd([[tnoremap <expr> <C-\><C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi']])
vim.keymap.set("n", "<C-w>t", function()
    if vim.bo.filetype == "shell" then
        vim.cmd("sp | term")
    else
        vim.cmd("tab term")
    end
end, { silent = true, noremap = true })

local function normalize_term_cmd(cmd)
    cmd = vim.fn.expand(cmd)
    cmd = cmd:gsub("%s+$", ""):gsub("~/", vim.fn.expand("~") .. "/")
    return vim.fn.escape(cmd, [[\"]])
end

local function safe_lcd(dir)
    if type(dir) ~= "string" then
        return
    end
    if dir == "" then
        return
    end
    if vim.fn.isdirectory(dir) == 0 then
        return
    end
    pcall(vim.cmd.lcd, dir)
end

local get_path = {
    current = function() return vim.fn.expand("%:p:h") end,
    cwd = function() return vim.fn.getcwd() end,
    home = function() return vim.fn.exapnd("~") end
}

local function open_terminal(path)
    vim.ui.input({ prompt = path .. " $ ", completion = "shellcmdline" }, function(input)
        if input == nil or input == "" then
            return
        end

        input = normalize_term_cmd(input)
        vim.cmd("sp term://" .. path .. "//" .. input)
        local current_term_buf = vim.api.nvim_get_current_buf()

        local function reopen_terminal(p)
            vim.api.nvim_buf_delete(current_term_buf, { force = true })
            vim.schedule(function()
                open_terminal(p)
            end)
        end

        vim.keymap.set("t", "<M-;>", function()
            reopen_terminal(path)
        end, { buffer = current_term_buf, noremap = true })
        vim.keymap.set("t", "<M-:>", function()
            reopen_terminal(path)
        end, { buffer = current_term_buf, noremap = true })
        vim.keymap.set("t", "<C-w>", "<C-\\><C-o><C-w>", { buffer = current_term_buf, silent = true, noremap = true })
        vim.schedule(function()
            vim.cmd.startinsert()
        end)
    end)
end

local function _run(path)
    vim.g.sess_unload_is_enabled = false
    vim.cmd.cd(path)
    open_terminal(path)
    vim.cmd.cd("-")
    vim.g.sess_unload_is_enabled = true
end

vim.keymap.set("n", "<M-;>", function()
    _run(get_path.current())
end, { noremap = true })

vim.keymap.set("n", "<M-:>", function()
    _run(get_path.cwd())
end, { noremap = true })

vim.api.nvim_create_autocmd({ "TermRequest" }, {
    desc = "Handles OSC 7 dir change requests",
    callback = function(ev)
        local val, n = string.gsub(ev.data.sequence, "\027]7;file://[^/]*", "")
        if n > 0 then
            local dir = val
            if vim.fn.isdirectory(dir) == 0 then
                vim.notify("invalid dir: " .. dir)
                return
            end
            vim.b[ev.buf].osc7_dir = dir
            if vim.api.nvim_get_current_buf() == ev.buf then
                safe_lcd(dir)
            end
        end
    end,
})
