local M = { "rcarriga/nvim-dap-ui" }

M.dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "julianolf/nvim-dap-lldb"
}

M.config = function()
    local dap = require "dap"
    local ui = require "dapui"

    require("dapui").setup()

    require("nvim-dap-virtual-text").setup {
        display_callback = function(variable)
            local name = string.lower(variable.name)
            local value = string.lower(variable.value)
            if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
                return "*****"
            end

            if #variable.value > 15 then
                return " " .. string.sub(variable.value, 1, 15) .. "... "
            end

            return " " .. variable.value
        end,
    }

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

    require("dap-lldb").setup({
        codelldb_path = "/usr/bin/lldb-dap",
        configurations = {
            c = {
                {
                    name = "Launch debugger",
                    type = "lldb",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    program = function()
                        -- local out = vim.fn.system({"make", "debug"})
                        -- if vim.v.shell_error ~= 0 then
                        --     vim.notify(out, vim.log.levels.ERROR)
                        --     return nil
                        -- end
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
            },
        },
    })
end

M.keys = function ()
    local dap = require("dap")
    return {
        { "<leader>?", function() require("dapui").eval(nil, { enter = true }) end, desc = "Eval" },
        { "<F3>", dap.disconnect, desc = "[DAP] Stop" },
        { "<F4>", dap.restart, desc = "[DAP] Restart" },
        { "<F5>", dap.continue, desc = "[DAP] Continue" },
        { "<F8>", dap.run_to_cursor, desc = "[DAP] Run to Cursor" },
        { "<F9>", dap.toggle_breakpoint, desc = "[DAP] Toggle Breakpoint" },
        { "<F10>", dap.step_over, desc = "[DAP] Step Over" },
        { "<F11>", dap.step_into, desc = "[DAP] Step Into" },
        { "<F12>", dap.step_out, desc = "[DAP] Step Out" },
    }
end

return M
