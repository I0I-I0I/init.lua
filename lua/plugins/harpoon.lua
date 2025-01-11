local M = { "ThePrimeagen/harpoon" }

M.branch = "harpoon2"
M.dependencies = { "nvim-lua/plenary.nvim" }

M.config = function()
    local harpoon = require("harpoon")
    harpoon:setup({
        ["1"] = {},
        ["2"] = {},
    })
end

local currentList = nil

local function add_to_list(harpoon, mode)
    if mode == "add" then
        harpoon:list(currentList):add()
    elseif mode == "prepend" then
        harpoon:list(currentList):prepend()
    end
end

local function select_from_list(harpoon, idx)
    harpoon:list(currentList):select(idx)
end

M.keys = function()
    local harpoon = require("harpoon")
    return {
        {
            "<leader>a",
            function() add_to_list(harpoon, "add") end,
            desc = "Add file (Harpoon)",
        },
        {
            "<leader>p",
            function() add_to_list(harpoon, "prepend") end,
            desc = "Add file to top (Harpoon)",
        },
        {
            "<leader>1",
            function() currentList = nil end,
            desc = "Open (main) list of files (Harpoon)",
        },
        {
            "<leader>2",
            function() currentList = "1" end,
            desc = "Open (additional) list of files (Harpoon)",
        },
        {
            "<leader>3",
            function() currentList = "2" end,
            desc = "Open (additional) list of files (Harpoon)",
        },
        {
            "",
            function() harpoon.ui:toggle_quick_menu(harpoon:list(currentList)) end,
            desc = "Open list of files (Harpoon)",
        },
        {
            "<C-s>",
            function() select_from_list(harpoon, 1) end,
            desc = "Select 1 (Harpoon)",
        },
        {
            "<C-j>",
            function() select_from_list(harpoon, 2) end,
            desc = "Select 2 (Harpoon)",
        },
        {
            "<C-k>",
            function() select_from_list(harpoon, 3) end,
            desc = "Select 3 (Harpoon)",
        },
        {
            "<C-l>",
            function() select_from_list(harpoon, 4) end,
            desc = "Select 4 (Harpoon)",
        }
    }
end

return M
