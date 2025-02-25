local ok, kulala = pcall(require, "kulala")
if not ok then
    print("kulala not found")
    return
end

vim.keymap.set("n", "<localleader>r", kulala.run, { desc = "Run http request" })
vim.keymap.set("n", "<localleader><C-r>s", kulala.search, { desc = "Search by http requests" })
vim.keymap.set("n", "<localleader><C-r>i", kulala.inspect, { desc = "Inspect http request" })
