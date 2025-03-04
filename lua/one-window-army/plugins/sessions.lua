local M = { dir = "/home/i0i/code/personal/sessions.nvim" }

M.lazy = false

M.dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim"
}

M.config = function()
    ---@class Session
    ---@field name string
    ---@field path string

    ---@type Session
    local prev = { name = "", path = "" }

    local builtins = require("sessions").setup()

    ---@param new_session Session
    local goto_prev = function(new_session)
        prev = builtins.get_current()
        if new_session.path ~= "" and prev.path ~= new_session.path then
            builtins.attach({ path = new_session.path })
        end
    end

    vim.keymap.set("n", "<leader><C-^>", function()
        builtins.save()
        goto_prev(prev)
    end)

    vim.api.nvim_create_user_command("CustomSessionAttach", function(input)
        prev = builtins.get_current()
        vim.cmd("SessionAttach " .. input.args)
    end, { nargs  = "?"})

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            vim.schedule(function()
                vim.cmd("CustomSessionAttach")
            end)
        end
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            builtins.save()
        end
    })
end

M.keys = {
    { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save session" },
    { "<leader>sc", "<cmd>SessionCreate<cr>", desc = "Create session" },
    { "<leader>sa", "<cmd>CustomSessionAttach<cr>", desc = "Attach session" },
    { "<leader>sl", "<cmd>SessionsList<cr>", desc = "List sessions" },
}

return M
