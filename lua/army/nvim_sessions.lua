local ok, sessions = pcall(require, "sessions")
if not ok then
    print("sessions.nvim not found")
    return
end

local builtins = sessions.setup()

---@class Session
---@field name string
---@field path string

---@type Session
local prev = { name = "", path = "" }

---@param new_session Session
local goto_prev = function(new_session)
    prev = builtins.get_current()
    if new_session.path ~= "" and prev.path ~= new_session.path then
        builtins.attach({ path = new_session.path })
    end
end

vim.api.nvim_create_user_command("CustomSessionAttach", function(input)
    prev = builtins.get_current()
    vim.cmd("SessionAttach " .. input.args)
end, { nargs  = "?"})

vim.keymap.set("n", "<leader><C-^>", function()
    builtins.save()
    goto_prev(prev)
end)

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.schedule(function()
            vim.cmd("CustomSessionAttach")
        end)
    end
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        builtins.save()
    end
})

vim.keymap.set("n", "<leader>sl", "<cmd>SessionsList<cr>")
vim.keymap.set("n", "<leader>sc", "<cmd>SessionCreate<cr>")
vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>")
vim.keymap.set("n", "<leader>sa", "<cmd>SessionAttach<cr>")

