local M = { "skywind3000/asyncrun.vim" }

M.init = function()
    vim.keymap.set("n", "Rm", "<cmd>AsyncRun make<cr>:copen | wincmd p<cr>")
    vim.keymap.set("n", "RM", ":AsyncRun make")
    vim.keymap.set("n", "Rd", "<cmd>AsyncRun make debug<cr>:copen | wincmd p<cr>")
    vim.keymap.set("n", "Rs", "<cmd>AsyncStop<cr>:cclose<cr>")
    vim.keymap.set("n", "Rr", "<cmd>AsyncReset<cr>:copen | wincmd p<cr>")
end

return M
