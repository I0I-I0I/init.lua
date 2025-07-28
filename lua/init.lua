--- Config
vim.g.mapleader = " "
vim.g.maplocalleader = ""
vim.o.lazyredraw = true
vim.o.updatetime = 300
vim.o.swapfile = false
vim.o.mouse = "a"
vim.o.hidden = true
vim.o.wildmode = "list,full"
vim.o.wildmenu = true
vim.o.laststatus = 3
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.cmdheight = 0
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.winborder = "rounded"
vim.o.completeopt = "menu,menuone,noinsert,popup,preview"
vim.o.colorcolumn = "120"
vim.o.scrolloff = 8
vim.o.undofile = true
vim.o.undolevels = 10000000
vim.o.undoreload = 10000000

vim.keymap.set("n", "gh", "diffget \\1")
vim.keymap.set("n", "gl", "diffget \\2")
vim.keymap.set("n", "-", "<cmd>Ex<CR>")
vim.keymap.set("n", "<C-y>", "3<C-y>")
vim.keymap.set("n", "<C-e>", "3<C-e>")
vim.keymap.set("n", "<localleader><C-f>", ":e <C-r>=expand('%:p:h')<CR>/<C-d>")
vim.keymap.set("n", "<localleader><C-s>", ":sp <C-r>=expand('%:p:h')<CR>/<C-d>")
vim.keymap.set("n", "<localleader><C-v>", ":vs <C-r>=expand('%:p:h')<CR>/<C-d>")
vim.keymap.set("n", "<localleader><C-n>", ":tabnew <C-r>=expand('%:p:h')<CR>/<C-d>")
vim.keymap.set("n", "<M-c>", ":let @+=expand('%')<cr>", { silent = true })
vim.keymap.set("n", "<M-S-c>", ":let @+=expand('%') . ':' . line('.')<cr>", { silent = true })
vim.keymap.set("c", "<C-w>", "<backspace><C-w>")
vim.keymap.set("i", "<C-space>", "<C-x><C-o>")

vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
    autocmd TextYankPost * silent! lua vim.hl.on_yank({higroup="IncSearch", timeout=100})
    autocmd FocusGained,BufEnter * checktime
]])

if vim.g.vscode then return end

vim.pack.add({
    { src = "https://github.com/vim-scripts/zenesque.vim" },
    { src = "https://github.com/ntk148v/komau.vim" },
    { src = "https://github.com/vague2k/vague.nvim" },

    { src = "https://github.com/Exafunction/windsurf.vim" },
    { src = "https://github.com/i0i-i0i/zenmode.nvim" },
    { src = "https://github.com/i0i-i0i/sessions.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/mfussenegger/nvim-lint" },
    { src = "https://github.com/artemave/workspace-diagnostics.nvim" },
    { src = "https://github.com/jake-stewart/multicursor.nvim" },
    { src = "https://github.com/folke/trouble.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },

    { src = "https://github.com/A7Lavinraj/fyler.nvim" },
    { src = "https://github.com/echasnovski/mini.icons" },

    { src = "https://github.com/pmizio/typescript-tools.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.cmd([[
    highlight Cursor guibg=#696969 ctermbg=67
    set guicursor=n-v-c:block-Cursor/lCursor
    \,i-ci-ve:ver100-Cursor
    \,r-cr:block-Cursor
    \,o:hor50-Cursor/lCursor
    \,sm:block-Cursor
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor
]])

local function transparency()
    vim.cmd.hi("Normal guibg=NONE")
    vim.cmd.hi("CursorLineNr guibg=NONE")
    vim.cmd.hi("NormalNC guibg=NONE")
    vim.cmd.hi("EndOfBuffer guibg=NONE")
    vim.cmd.hi("SignColumn guibg=NONE")
    vim.cmd.hi("Folded guibg=NONE")
    vim.cmd.hi("LineNr guibg=NONE")
    vim.cmd.hi("TabLineFill guibg=NONE")
    vim.cmd.hi("StatusLine guibg=NONE")
end

vim.cmd.colo("vague")
transparency()

local timer = vim.loop.new_timer()
if timer then
    timer:start(0, 10 * (60 * 1000), vim.schedule_wrap(function()
        local hour = tonumber(os.date("%H"))
        -- if hour >= 22 or hour < 6 then
        --     vim.cmd("colo komau")
        --     transparency()
        -- else
        --     vim.cmd("colo zenesque")
        -- end
    end))
end

require("vim._extui").enable({
    enable = true,
    msg = { target = "cmd", timeout = 4000 },
})

--- Codeium
local codeium_ok, codeium = pcall(require, "codeium")
if codeium_ok then
    codeium.setup({
        enable_cmp_source = false,
        virtual_text = {
            enabled = true
        },
    })
end

--- Zenmode
local zenmode_ok, zenmode = pcall(require, "zenmode.nvim")
if zenmode_ok then
    zenmode.setup({
        default_width = 20,
        toggle_opts = {
            nu = false,
            rnu = false
        }
    })
    vim.keymap.set("n", "<leader>z", "<cmd>ZenmodeToggle<cr>", { silent = true })
end

--- Sessions
local sessions_ok, sessions = pcall(require, "sessions")
if sessions_ok then
    local prev = { name = "", path = "" }
    local builtins = sessions.setup()
    local goto_prev = function(new_session)
        prev = builtins.get_current()
        if new_session.path ~= "" and prev.path ~= new_session.path then
            builtins.attach({ path = new_session.path })
        end
    end
    vim.keymap.set("n", "<leader><C-^>", function()
        if zenmode_ok then
            vim.cmd("ZenmodeClose")
        end
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
            if zenmode_ok then
                vim.cmd("ZenmodeClose")
            end
            builtins.save()
        end
    })
    vim.keymap.set("n", "<leader>s", "<cmd>CustomSessionAttach<cr>", { desc = "Attach session" })
end

--- LSP
vim.keymap.set("n", "grd", function()
    vim.diagnostic.setqflist({})
    vim.cmd("copen")
end)

vim.diagnostic.config({
    virtual_text = false,
    jump = { float = true },
    float = { source = true }
})

local lint_ok, lint = pcall(require, "lint")
if lint_ok then
    lint.linters_by_ft = {
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        cpp = { "cpplint" },
        c = { "cpplint" },
        markdown = { "cspell" },
        text = { "cspell" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = { "*.c", "*.cpp", "*.js", "*.jsx", "*.ts", "*.tsx", "*.py", "*.md", "*.txt" },
        callback = function()
            require("lint").try_lint()
        end
    })
end

local format_ok, format = pcall(require, "conform")
if format_ok then
    format.setup({
        formatters_by_ft = {
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            html = { "prettierd" },
            htmldjango = { "prettierd" },
            css = { "prettierd" },
            python = { "ruff_format" }
        }
    })
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.keymap.set("n", "grf", format.format, { noremap = true, silent = true })
end

local typescript_ok, typescript = pcall(require, "typescript-tools")
if typescript_ok then
    typescript.setup({
        settings = {
            jsx_close_tag = {
                enable = false,
                filetypes = { "javascriptreact", "typescriptreact" },
            }
        },
        tsserver_file_preferences = {
            includeCompletionsForModuleExports = true,
            quotePreference = "double",
        },
        tsserver_format_options = {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
        }
    })
end

local workspace_diagnostics_ok, _ = pcall(require, "workspace-diagnostics")
if workspace_diagnostics_ok then
    vim.lsp.config("*", {
        root_markers = { ".git", ".hg", "src" },
        capabilities = {
            textDocument = {
                semanticTokens = { multilineTokenSupport = true }
            }
        },
    })
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then return end
            if client:supports_method('textDocument/completion') then
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            end
        end
    })
    vim.lsp.enable({ "ruff", "lua_ls", "djlsp", "basedpyright", "clangd" })
end

--- FzfLua
local fzf_lua_ok, fzf_lua = pcall(require, "fzf-lua")
if fzf_lua_ok then
    fzf_lua.setup()
    vim.keymap.set("n", "<C-p>", fzf_lua.files, { silent = true })
    vim.keymap.set("n", "<C-/>", fzf_lua.live_grep, { silent = true })
    vim.keymap.set("n", "<C-b>", fzf_lua.buffers, { silent = true })
    vim.keymap.set("n", "<C-h>", fzf_lua.help_tags, { silent = true })
end

--- Trouble
local trouble_ok, trouble = pcall(require, "trouble")
if trouble_ok then
    trouble.setup()
    vim.keymap.set("n", "<leader>l", "<cmd>Trouble loclist<cr>", { silent = true })
    vim.keymap.set("n", "<leader>q", "<cmd>Trouble quickfix<cr>", { silent = true })
    vim.keymap.set("n", "grr", "<cmd>Trouble lsp_references<cr>", { silent = true })
    vim.keymap.set("n", "grd", "<cmd>Trouble diagnostics<cr>", { silent = true })
    vim.keymap.set("n", "<C-j>", function() trouble.next({ jump = true, skip_groups = true }) end)
    vim.keymap.set("n", "<C-k>", function() trouble.prev({ jump = true, skip_groups = true }) end)

    if fzf_lua_ok then
        local config = require("fzf-lua.config")
        local actions = require("trouble.sources.fzf").actions
        config.defaults.actions.files["ctrl-q"] = actions.open
    end
end

--- Multicursor
local mc_ok, mc = pcall(require, "multicursor-nvim")
if mc_ok then
    mc.setup()
    vim.keymap.set({ "n", "v" }, "<A-j>", function() mc.lineAddCursor(1) end)
    vim.keymap.set({ "n", "v" }, "<A-k>", function() mc.lineAddCursor(-1) end)
    vim.keymap.set({ "n", "v" }, "<A-S-j>", function() mc.lineSkipCursor(1) end)
    vim.keymap.set({ "n", "v" }, "<A-S-k>", function() mc.lineSkipCursor(-1) end)
    vim.keymap.set({ "n", "v" }, "<A-n>", function() mc.matchAddCursor(1) end)
    vim.keymap.set({ "n", "v" }, "<A-p>", function() mc.matchAddCursor(-1) end)
    vim.keymap.set({ "n", "v" }, "<A-S-n>", function() mc.matchSkipCursor(1) end)
    vim.keymap.set({ "n", "v" }, "<A-S-p>", function() mc.matchSkipCursor(-1) end)
    vim.keymap.set({ "n", "v" }, "<A-a>", mc.matchAllAddCursors)
    vim.keymap.set({ "n", "v" }, "<A-l>", mc.nextCursor)
    vim.keymap.set({ "n", "v" }, "<A-h>", mc.prevCursor)
    vim.keymap.set({ "n", "v" }, "<A-x>", mc.deleteCursor)
    vim.keymap.set("n", "<A-leftmouse>", mc.handleMouse)
    vim.keymap.set({ "n", "v" }, "<A-q>", mc.toggleCursor)
    vim.keymap.set({ "n", "v" }, "<A-S-q>", mc.duplicateCursors)
    vim.keymap.set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        elseif mc.hasCursors() then
            mc.clearCursors()
        end
    end)
    vim.keymap.set("n", "<C-[>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        elseif mc.hasCursors() then
            mc.clearCursors()
        end
    end)
    vim.keymap.set("n", "<A-g><A-v>", mc.restoreCursors)
    vim.keymap.set("n", "<A-S-a>", mc.alignCursors)
    vim.keymap.set("v", "S", mc.splitCursors)
    vim.keymap.set("v", "I", mc.insertVisual)
    vim.keymap.set("v", "A", mc.appendVisual)
    vim.keymap.set("v", "M", mc.matchCursors)
    vim.keymap.set({ "v", "n" }, "<c-i>", mc.jumpForward)
    vim.keymap.set({ "v", "n" }, "<c-o>", mc.jumpBackward)
end

-- Explorer
local fyler_ok, fyler = pcall(require, "fyler")
if fyler_ok then
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fyler" },
        callback = function()
            vim.cmd([[
                set <buffer> nonu
                set <buffer> norelativenumber
            ]])
        end
    })
    vim.keymap.set("n", "-", fyler.open, { noremap = true })
    fyler.setup({
        views = {
            explorer = {
                close_on_select = false,
                confirm_simple = true,
                win = {
                    kind = "split_left",
                    kind_presets = {
                        split_left = {
                            width = 0.2,
                        },
                    },
                },
            }
        }
    })
end
