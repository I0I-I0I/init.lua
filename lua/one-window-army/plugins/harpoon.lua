local M = { "ThePrimeagen/harpoon" }

M.branch = "harpoon2"
M.dependencies = { "nvim-lua/plenary.nvim" }

---@return string | nil
local function get_current_tab()
    local current_tab = vim.api.nvim_get_current_tabpage()
    local all_tabs = vim.api.nvim_list_tabpages()
    for index, tab in pairs(all_tabs) do
        if tab == current_tab then
            return tostring(index)
        end
    end
end

M.config = function()
    local harpoon = require("harpoon")

    harpoon:setup({
        ["2"] = {},
        ["3"] = {},
        ["4"] = {},
        ["5"] = {},
        ["6"] = {},
        ["7"] = {},
        ["8"] = {},
        ["9"] = {},
    })

    local function add_to_list(mode)
        local current_tab = get_current_tab()
        if current_tab == "1" then
            current_tab = nil
        end
        if mode == "add" then
            harpoon:list(current_tab):add()
        elseif mode == "prepend" then
            harpoon:list(current_tab):prepend()
        end
    end

    local function select_from_list(idx)
        local current_tab = get_current_tab()
        if current_tab == "1" then
            current_tab = nil
        end
        harpoon:list(current_tab):select(idx)
    end

    vim.keymap.set("n", "<leader>a",
        function() add_to_list("add") end,
        { desc = "Add file (Harpoon)" }
    )
    vim.keymap.set("n", "<leader>p",
        function() add_to_list("prepend") end,
        { desc = "Add file to top (Harpoon)" }
    )
    vim.keymap.set("n", "",
        function()
            local current_tab = get_current_tab()
            if current_tab == "1" then
                current_tab = nil
            end
            harpoon.ui:toggle_quick_menu(harpoon:list(current_tab))
        end,
        { desc = "Open list of files (Harpoon)" }
    )
    vim.keymap.set("n", "<leader>h",
        function() select_from_list(1) end,
        { desc = "Select 1 (Harpoon)" }
    )
    vim.keymap.set("n", "<leader>j",
        function() select_from_list(2) end,
        { desc = "Select 2 (Harpoon)" }
    )
    vim.keymap.set("n", "<leader>k",
        function() select_from_list(3) end,
        { desc = "Select 3 (Harpoon)" }
    )
    vim.keymap.set("n", "<leader>l",
        function() select_from_list(4) end,
        { desc = "Select 4 (Harpoon)" }
    )
end

return M
