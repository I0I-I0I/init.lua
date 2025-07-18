local ok, zenmode = pcall(require, "zenmode.nvim")
if not ok then
    error("zenmode.nvim is not installed!")
    return
end

zenmode.setup({
    default_width = 20,
    toggle_opts = {
        nu = false,
        rnu = false
    }
})

local builtin = zenmode.builtin()

vim.keymap.set("n", "<leader>z", function()
    builtin.toggle()
end, { silent = true })
