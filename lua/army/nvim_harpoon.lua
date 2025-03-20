local ok, harpoon = pcall(require, "harpoon")
if not ok then
    print("Not found 'harpoon'")
    return
end

local harpoon_extensions = require("harpoon.extensions")

harpoon:setup({
    ["1"] = {},
    ["2"] = {},
})
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

local currentList = nil

local function add_to_list(mode)
    if mode == "add" then
        harpoon:list(currentList):add()
    elseif mode == "prepend" then
        harpoon:list(currentList):prepend()
    end
end

local function select_from_list(idx)
    harpoon:list(currentList):select(idx)
end

vim.keymap.set("n", "<leader>a", function() add_to_list("add") end, { desc = "Add file (Harpoon)" })
vim.keymap.set("n", "<leader>p", function() add_to_list("prepend") end, { desc = "Add file to top (Harpoon)" })
vim.keymap.set("n", "<C-s>", function() currentList = nil end, { desc = "Open (main) list of files (Harpoon)" })
vim.keymap.set("n", "<C-a>", function() currentList = "1" end, { desc = "Open (additional) list of files (Harpoon)" })
vim.keymap.set("n", "<C-x>", function() currentList = "2" end, { desc = "Open (additional) list of files (Harpoon)" })
vim.keymap.set("n", "", function() harpoon.ui:toggle_quick_menu(harpoon:list(currentList)) end, { desc = "Open list of files (Harpoon)" })
vim.keymap.set("n", "<leader>h", function() select_from_list(1) end, { desc = "Select 1 (Harpoon)" })
vim.keymap.set("n", "<leader>j", function() select_from_list(2) end, { desc = "Select 2 (Harpoon)" })
vim.keymap.set("n", "<leader>k", function() select_from_list(3) end, { desc = "Select 3 (Harpoon)" })
vim.keymap.set("n", "<leader>l", function() select_from_list(4) end, { desc = "Select 4 (Harpoon)" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.keymap.set("n", "<C-l>", function() select_from_list(4) end, { desc = "Select 4 (Harpoon)", buffer = true })
    end
})
