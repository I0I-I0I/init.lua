local M = { "Exafunction/windsurf.nvim" }

M.enabled = false
M.lazy = true
M.event = "InsertEnter"
M.dependencies = { "nvim-lua/plenary.nvim" }

M.config = function()
    local codeium = require("codeium")

    codeium.setup({
        enable_cmp_source = false,
        virtual_text = {
            enabled = true
        },
    })

    function Custom_status()
        local status = require("codeium.virtual_text").status()

        if status.state == "idle" then
            return " "
        end

        if status.state == "waiting" then
            return "    Waiting..."
        end

        if status.state == "completions" and status.total > 0 then
            return "    " .. string.format("%d/%d", status.current, status.total)
        end

        return "    0 "
    end

    vim.opt.statusline = "%<%f %h%w%m%r"
        .. "%3{v:lua.Custom_status()}"
        .. "%=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}"
        .. "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}"
        .. "%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}"
end

return M
