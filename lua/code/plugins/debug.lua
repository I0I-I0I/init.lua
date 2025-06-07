local M = { "mfussenegger/nvim-dap" }

M.dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
}

M.config = function()
    local dap = require("dap")
    local ui = require("dapui")
    local python = require("dap-python")

    ui.setup()
    python.setup("/sbin/python3")

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

M.keys = {
    { "<leader>?", "<cmd>DapEval<cr>",              desc = "[DAP] Eval" },
    { "<leader>d", "<cmd>DapTerminate<cr>",         desc = "[DAP] Disconnect" },
    { "<leader>r", "<cmd>DapRestartFrame<cr>",      desc = "[DAP] Restart" },
    { "<leader>c", "<cmd>DapContinue<cr>",          desc = "[DAP] Continue" },
    { "<leader>n", "<cmd>DapStepOver<cr>",          desc = "[DAP] Step Over" },
    { "<leader>i", "<cmd>DapStepInto<cr>",          desc = "[DAP] Step Into" },
    { "<leader>o", "<cmd>DapStepOut<cr>",           desc = "[DAP] Step Out" },
    { "<leader>b", "<cmd>DapToggleBreakpoint<cr>", desc = "[DAP] Toggle Breakpoint" },
    { "<leader>B", "<cmd>DapClearBreakpoints<cr>", desc = "[DAP] Clear All Breakpoints" },
}

return M
