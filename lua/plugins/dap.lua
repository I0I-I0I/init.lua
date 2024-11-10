return {
  {
    "mfussenegger/nvim-dap",
	cond = false,
    dependencies = {
      "leoluz/nvim-dap-go",
	  "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()

	  -- GO
      require("dap-go").setup()

	  -- Python
	  require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
	  vim.cmd([[
		  nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
		  nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
		  vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
	  ]])

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

      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<leader>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "]b", dap.continue)
      vim.keymap.set("n", "<leader>si", dap.step_into)
      vim.keymap.set("n", "<leader>so", dap.step_over)
      vim.keymap.set("n", "<leader>su", dap.step_out)
      vim.keymap.set("n", "<leader>sb", dap.step_back)
      vim.keymap.set("n", "<leader>dr", dap.restart)

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
    end,
  },
}
