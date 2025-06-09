local ok, dap = pcall(require, "dap")
if not ok then
    print("DAP not found")
    return
end

local ok, ui = pcall(require, "dapui")
if not ok then
    print("DAP-UI not found")
    return
end

local ok, python = pcall(require, "dap-python")
if not ok then
    print("DAP-Python not found")
    return
end

ui.setup()
python.setup("uv")

dap.listeners.before.attach.dapui_config = function()
    ui.open()
end
dap.listeners.before.launch.dapui_config = function()
    ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
end

print("HI")
vim.keymap.set("n", "<leader>?", function() dap.eval(nil, { enter = true }) end, { desc = "[DAP] Eval" })
vim.keymap.set("n", "<leader>d", dap.disconnect, { desc = "[DAP] Disconnect" })
vim.keymap.set("n", "<leader>r", dap.restart, { desc = "[DAP] Restart" })
vim.keymap.set("n", "<leader>c", dap.continue, { desc = "[DAP] Continue" })
vim.keymap.set("n", "<leader>C", dap.run_to_cursor, { desc = "[DAP] Run to Cursor" })
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "[DAP] Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", dap.clear_breakpoints, { desc = "[DAP] Clear All Breakpoints" })
vim.keymap.set("n", "<leader>n", dap.step_over, { desc = "[DAP] Step Over" })
vim.keymap.set("n", "<leader>i", dap.step_into, { desc = "[DAP] Step Into" })
vim.keymap.set("n", "<leader>o", dap.step_out, { desc = "[DAP] Step Out" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "py" },
    callback = function()
        vim.keymap.set("n", "<leader>dn", python.test_method(), { desc = "[DAP] Python: test method", buffer = true })
        vim.keymap.set("n", "<leader>df", python.test_class(), { desc = "[DAP] Python: test class", buffer = true })
    end
})
