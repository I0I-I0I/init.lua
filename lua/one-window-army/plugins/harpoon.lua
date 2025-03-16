local M = { "ThePrimeagen/harpoon" }

M.branch = "harpoon2"
M.dependencies = { "nvim-lua/plenary.nvim" }

M.config = function()
    local harpoon = require("harpoon")
    local harpoon_extensions = require("harpoon.extensions")

    harpoon:setup({
        ["1"] = {},
        ["2"] = {},
    })
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
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

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "netrw",
        callback = function()
            vim.keymap.set("n", "<C-l>", function() select_from_list(4) end, { desc = "Select 4 (Harpoon)", buffer = true })
        end
    })
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
            "<C-s>",
            function() currentList = nil end,
            desc = "Open (main) list of files (Harpoon)",
        },
        {
            "<C-a>",
            function() currentList = "1" end,
            desc = "Open (additional) list of files (Harpoon)",
        },
        {
            "<C-x>",
            function() currentList = "2" end,
            desc = "Open (additional) list of files (Harpoon)",
        },
        {
            "",
            function() harpoon.ui:toggle_quick_menu(harpoon:list(currentList)) end,
            desc = "Open list of files (Harpoon)",
        },
        {
            "<leader>h",
            function() select_from_list(harpoon, 1) end,
            desc = "Select 1 (Harpoon)",
        },
        {
            "<leader>j",
            function() select_from_list(harpoon, 2) end,
            desc = "Select 2 (Harpoon)",
        },
        {
            "<leader>k",
            function() select_from_list(harpoon, 3) end,
            desc = "Select 3 (Harpoon)",
        },
        {
            "<leader>l",
            function() select_from_list(harpoon, 4) end,
            desc = "Select 4 (Harpoon)",
        }
    }
end

return M
