local M = { "rcarriga/nvim-dap-ui" }

M.lazy = false

M.dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "julianolf/nvim-dap-lldb"
}

M.config = function()
    local dap = require "dap"
    local ui = require "dapui"
    local lldb = require "dap-lldb"

    ui.setup()
    lldb.setup({ codelldb_path = "/usr/bin/lldb-dap" })

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
end

M.keys = function ()
    local dap = require("dap")
    return {
        { "<leader>?", function() dap.eval(nil, { enter = true }) end, desc = "Eval" },
        { "<leader>d", dap.disconnect, desc = "[DAP] Disconnect" },
        { "<leader>r", dap.restart, desc = "[DAP] Restart" },
        { "<leader>c", dap.continue, desc = "[DAP] Continue" },
        { "<leader>C", dap.run_to_cursor, desc = "[DAP] Run to Cursor" },
        { "<leader>b", dap.toggle_breakpoint, desc = "[DAP] Toggle Breakpoint" },
        { "<leader>B", dap.clear_breakpoints, desc = "[DAP] Clear All Breakpoints" },
        { "<leader>N", dap.step_over, desc = "[DAP] Step Over" },
        { "<leader>n", dap.step_into, desc = "[DAP] Step Into" },
        { "<leader>o", dap.step_out, desc = "[DAP] Step Out" },
    }
end

return M
