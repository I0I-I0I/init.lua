vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = "" -- <C-x>
vim.o.lazyredraw = true
vim.o.updatetime = 300
vim.o.swapfile = false
vim.o.mouse = "a"
vim.o.hidden = true
vim.o.list = true
vim.o.wildmode = "list:longest,full"
vim.o.wildmenu = true
vim.o.laststatus = 3
vim.o.smartcase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.winborder = "single"
vim.o.completeopt = "menuone,noinsert,preview,fuzzy"
vim.o.undofile = true
vim.o.undolevels = 10000000
vim.o.undoreload = 10000000
vim.o.foldnestmax = 1
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчняжб;abcdefghijklmnopqrstuvwxyz\\;\\,"

vim.keymap.set("n", "<C-y>", "4<C-y>")
vim.keymap.set("n", "<C-e>", "4<C-e>")
vim.keymap.set("n", "-", "<cmd>Fyler<cr>", { noremap = true })
vim.keymap.set("n", "gw", "<cmd>bp|bd #<cr>", { silent = true })
vim.keymap.set("n", "gW", "<cmd>bp|bd! #<cr>", { silent = true })
vim.keymap.set("n", "<A-o>", "<cmd>tabnext<cr>", { silent = true })
vim.keymap.set("n", "<A-i>", "<cmd>tabprev<cr>", { silent = true })
vim.keymap.set("n", "<A-C-o>", "<cmd>tabmove +<cr>", { silent = true })
vim.keymap.set("n", "<A-C-i>", "<cmd>tabmove -<cr>", { silent = true })
vim.keymap.set("n", "<localleader><C-f>", ":e <C-r>=expand('%:p:h')<CR>/")
vim.keymap.set("n", "<localleader><C-s>", ":sp <C-r>=expand('%:p:h')<CR>/")
vim.keymap.set("n", "<localleader><C-v>", ":vs <C-r>=expand('%:p:h')<CR>/")
vim.keymap.set("n", "<localleader><C-n>", ":tabnew <C-r>=expand('%:p:h')<CR>/")
vim.keymap.set("n", "<M-c>", ":let @+=expand('%')<cr>", { silent = true })
vim.keymap.set("n", "<M-S-c>", ":let @+=expand('%') . ':' . line('.')<cr>", { silent = true })
vim.keymap.set("n", "<C-s>", "<cmd>!tmux neww tmux-sessionizer<cr>", { silent = true })
vim.keymap.set("c", "<C-w>", "<backspace><C-w>")
vim.keymap.set("n", "<leader>N", ":tabnew ~/Sync/notes/.md<Left><Left><Left>")
vim.keymap.set("n", "<leader>w", "<cmd>mksession!<cr><cmd>w<cr>", { silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>mksession!<cr><cmd>wa<cr><cmd>qa<cr>", { silent = true })
vim.keymap.set("n", "<leader>r", "<cmd>w<cr><cmd>e<cr>zozz", { silent = true })

vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
    autocmd TextYankPost * silent! lua vim.hl.on_yank({higroup="IncSearch", timeout=150})
    autocmd FocusGained,BufEnter * checktime
    autocmd FileType markdown setlocal foldnestmax=10 | setlocal foldlevelstart=2
    autocmd FileType fyler setlocal nospell ]])

vim.pack.add({
    "https://github.com/ntk148v/komau.vim",
    "https://github.com/craftzdog/solarized-osaka.nvim",
    "https://github.com/wakatime/vim-wakatime" })

-- Lazy
vim.schedule(function()
    vim.o.spell = true
    vim.o.spelllang = "en,ru"

    vim.api.nvim_create_user_command("LoadDapConfig", function() require("dap-config") end, {})
    require("make")
    require("vim._extui").enable({ enable = true, msg = { target = "cmd", timeout = 4000 } })

    vim.pack.add({
        "https://github.com/nvim-treesitter/nvim-treesitter",
        "https://github.com/mason-org/mason.nvim",
        "https://github.com/ibhagwan/fzf-lua",
        "https://github.com/A7Lavinraj/fyler.nvim",
        "https://github.com/jake-stewart/multicursor.nvim",
        "https://github.com/MeanderingProgrammer/render-markdown.nvim",
        "https://github.com/supermaven-inc/supermaven-nvim" })

    require("fyler").setup({
        confirm_simple = true,
        icon_provider = "none",
        git_status = { enabled = false },
        icon = { directory_collapsed = "", directory_empty = "󰿟", directory_expanded = "" } })
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true }})
    require("supermaven-nvim").setup({ ignore_filetypes = { "", "fyler" } })
    require("render-markdown").setup({})
    require("mason").setup()

    require("fzf-lua").setup({"ivy"})
    vim.keymap.set("n", "<C-p>", ":FzfLua files<cr>", { silent = true })
    vim.keymap.set("n", "", ":FzfLua grep<cr>", { silent = true })
    vim.keymap.set("n", "th", ":FzfLua helptags<cr>", { silent = true })
    vim.keymap.set("n", "tm", ":FzfLua manpages<cr>", { silent = true })

    local mc = require("multicursor-nvim")
    mc.setup()
    vim.keymap.set({"n", "x"}, "<A-k>", function() mc.lineAddCursor(-1) end)
    vim.keymap.set({"n", "x"}, "<A-j>", function() mc.lineAddCursor(1) end)
    vim.keymap.set({"n", "x"}, "<A-S-k>", function() mc.lineSkipCursor(-1) end)
    vim.keymap.set({"n", "x"}, "<A-S-j>", function() mc.lineSkipCursor(1) end)
    vim.keymap.set({"n", "x"}, "<A-n>", function() mc.matchAddCursor(1) end)
    vim.keymap.set({"n", "x"}, "<A-S-n>", function() mc.matchSkipCursor(1) end)
    vim.keymap.set({"n", "x"}, "<A-p>", function() mc.matchAddCursor(-1) end)
    vim.keymap.set({"n", "x"}, "<A-S-p>", function() mc.matchSkipCursor(-1) end)
    vim.keymap.set({"n", "x"}, "<A-a>", mc.matchAllAddCursors)
    vim.keymap.set({"n", "x"}, "<A-q>", mc.toggleCursor)
    vim.keymap.set("x", "I", mc.insertVisual)
    vim.keymap.set("x", "A", mc.appendVisual)
    vim.keymap.set("n", "<leader>gv", mc.restoreCursors)
    mc.addKeymapLayer(function(layerSet)
        layerSet({"n", "x"}, "<A-h>", mc.prevCursor)
        layerSet({"n", "x"}, "<A-l>", mc.nextCursor)
        layerSet({"n", "x"}, "<A-x>", mc.deleteCursor)
        layerSet("n", "<leader>a", mc.alignCursors)
        layerSet("n", "", function()
            if not mc.cursorsEnabled() then mc.enableCursors() else mc.clearCursors() end end)
    end)

    -- LSP
    vim.keymap.set("n", "grd", vim.diagnostic.setqflist, { silent = true })
    vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)

    vim.diagnostic.config({ jump = { float = true }, float = { source = true } })
    vim.lsp.enable({ "basedpyright", "ruff", "djlsp" , "clangd", "bashls", "lua_ls", "cssls",
                     "css_variables", "html", "emmet_language_server", "ts_ls" })
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            vim.keymap.set("n", "<C-w>d", function()
                vim.diagnostic.open_float()
                vim.diagnostic.open_float()
            end, { buffer = args.buf })
            vim.lsp.semantic_tokens.enable(false, { bufnr = args.buf })
            -- if client:supports_method("textDocument/completion") then
            --     local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            --     client.server_capabilities.completionProvider.triggerCharacters = chars
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            -- end
        end })
end)

-- Color
vim.cmd("colo quiet")
local bgs = {"DiagnosticWarn", "DiagnosticError", "DiagnosticHint", "DiagnosticInfo"}
local date = tonumber(os.date("%H"))
if date >= 22 or date < 6 then
    vim.o.bg = "dark"
    vim.pack.add({"https://github.com/xiyaowong/transparent.nvim"})
    require("transparent").setup({
        extra_groups = { "TabLine", "TabLineFill", "TabLineSel", "Folded", "NormalFloat" },
        exclude_groups = { "CursorLine" } })
    for _, bg in pairs(bgs) do vim.api.nvim_set_hl(0, bg, { fg = "#ffffff" }) end
    vim.api.nvim_set_hl(0, "TabLine", { fg = "#6c6c6c" })
    vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#e0e2ea", bg = "#ffffff" })
    vim.api.nvim_set_hl(0, "StatusLine", { fg = "#e0e2ea" })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#dadada" })
    vim.api.nvim_set_hl(0, "Whitespace", { bg = "#ae0000" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#121212" })
else
    vim.o.bg = "light"
    for _, bg in pairs(bgs) do vim.api.nvim_set_hl(0, bg, { fg = "#000000" }) end
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = "NONE" })
    vim.api.nvim_set_hl(0, "Whitespace", { bg = "#ae0000" })
end
