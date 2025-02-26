local ok, sessions = pcall(require, "sessions.nvim")
if not ok then
    print("sessions.nvim not found")
    return
end

vim.keymap.set("n", "<localleader><C-s>l", "<cmd>SessionsList<cr>")
vim.keymap.set("n", "<localleader><C-s>c", "<cmd>SessionCreate<cr>")
vim.keymap.set("n", "<localleader><C-s>s", "<cmd>SessionSave<cr>")
vim.keymap.set("n", "<localleader>s", "<cmd>SessionAttach<cr>")
