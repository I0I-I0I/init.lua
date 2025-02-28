local ok, sessions = pcall(require, "sessions")
if not ok then
    print("sessions.nvim not found")
    return
end

local builtins = require("sessions").setup()

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.schedule(function()
            builtins.attach_session()
        end)
    end
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        builtins.save_session()
    end
})

vim.keymap.set("n", "<leader>sl", "<cmd>SessionsList<cr>")
vim.keymap.set("n", "<leader>sc", "<cmd>SessionCreate<cr>")
vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>")
vim.keymap.set("n", "<leader>sa", "<cmd>SessionAttach<cr>")
