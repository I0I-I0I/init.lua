local M = { "mfussenegger/nvim-dap" }

M.dependencies = {
    "igorlfs/nvim-dap-view" ,
    "julianolf/nvim-dap-lldb",
    "mfussenegger/nvim-dap-python",
}

M.config = function()
    require("dap-view").setup()
    require("dap-lldb").setup({ codelldb_path = "/usr/bin/lldb-dap" })
    require("dap-python").setup("python3")
end

M.keys = function ()
    local dap = require("dap")
    local ui = require("dap-view")
    return {
        { "<leader>?", function() dap.eval(nil, { enter = true }) end, desc = "[DAP] Eval" },
        { "<leader>R", dap.restart, desc = "[DAP] Restart" },
        { "<leader>c", function ()
            dap.continue()
            require("dap-view").open()
        end, desc = "[DAP] Continue" },
        { "<leader>d", function ()
            ui.close()
            dap.disconnect()
        end, desc = "[DAP] Continue" },
        { "<leader>C", dap.run_to_cursor, desc = "[DAP] Run to Cursor" },
        { "<leader>b", dap.toggle_breakpoint, desc = "[DAP] Toggle Breakpoint" },
        { "<leader>B", dap.clear_breakpoints, desc = "[DAP] Clear All Breakpoints" },
        { "<leader>n", dap.step_over, desc = "[DAP] Step Over" },
        { "<leader>s", dap.step_into, desc = "[DAP] Step Into" },
        { "<leader>o", dap.step_out, desc = "[DAP] Step Out" },
    }
end

return M
