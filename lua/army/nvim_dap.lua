local ok, dap = pcall(require, "dap")
if not ok then
    print("DAP not found")
    return
end

local ok, ui = pcall(require, "dap-view")
if not ok then
    print("DAP-UI not found")
    return
end

local ok, lldb = pcall(require, "dap-lldb")
if not ok then
    print("DAP-LLDB not found")
    return
end

ui.setup()
lldb.setup({ codelldb_path = "/usr/bin/lldb-dap" })

vim.keymap.set("n", "<leader>?", function() dap.eval(nil, { enter = true }) end, { desc = "[DAP] Eval" })
vim.keymap.set("n", "<leader>r", dap.restart, { desc = "[DAP] Restart" })
vim.keymap.set("n", "<leader>c", function ()
    dap.continue()
    require("dap-view").open()
end, { desc = "[DAP] Continue" })
vim.keymap.set("n", "<leader>d", function()
    ui.close()
    dap.disconnect()
end, { desc = "[DAP] Continue" })
vim.keymap.set("n", "<leader>C", dap.run_to_cursor, { desc = "[DAP] Run to Cursor" })
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "[DAP] Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", dap.clear_breakpoints, { desc = "[DAP] Clear All Breakpoints" })
vim.keymap.set("n", "<leader>n", dap.step_over, { desc = "[DAP] Step Over" })
vim.keymap.set("n", "<leader>s", dap.step_into, { desc = "[DAP] Step Into" })
vim.keymap.set("n", "<leader>o", dap.step_out, { desc = "[DAP] Step Out" })
