local M = { "i0i-i0i/sessions.nvim" }

M.dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim"
}

M.lazy = false

vim.api.nvim_create_user_command("RemoveHiddenBuffers", function()
    local bufinfos = vim.fn.getbufinfo({ buflisted = 1 })
    local count = 0
    vim.tbl_map(function(bufinfo)
        if bufinfo.changed == 0 and (not bufinfo.windows or #bufinfo.windows == 0) then
            vim.api.nvim_buf_delete(bufinfo.bufnr, { force = false, unload = false })
        end
        count = count + 1
    end, bufinfos)
    print("Removed " .. count .. " hidden buffers")
end, { desc = "Wipeout all hidden buffers" })

M.config = function()
    ---@type Session
    local prev = { name = "", path = "" }

    local builtins = require("sessions").setup({
        path = "C:\\Users\\NnoFLy\\sessions\\"
    })

    ---@param new_session Session
    local goto_prev = function(new_session)
        prev = builtins.get_current()
        if new_session.path ~= "" and prev.path ~= new_session.path then
            builtins.attach({ path = new_session.path })
        end
    end

    vim.keymap.set("n", "<leader><C-^>", function()
        builtins.save()
        vim.cmd("wa")
        vim.cmd("silent! bufdo bd")
        goto_prev(prev)
    end)

    vim.api.nvim_create_user_command("CustomSessionAttach", function(input)
        prev = builtins.get_current()
        vim.cmd("SessionAttach " .. input.args)
    end, { nargs = "?" })

    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            builtins.save()
        end
    })
end

M.keys = {
    { "<localleader><C-s>s", "<cmd>SessionSave<cr>",         desc = "Save session" },
    { "<localleader><C-s>c", "<cmd>SessionCreate<cr>",       desc = "Create session" },
    { "<localleader><C-s>l", "<cmd>SessionsList<cr>",        desc = "List sessions" },
    { "<leader>s",           "<cmd>CustomSessionAttach<cr>", desc = "Attach session" },
}

return M
