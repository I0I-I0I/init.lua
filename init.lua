vim.loader.enable()

-- Theme
vim.o.bg = "dark"
vim.pack.add({ "https://github.com/mhartington/oceanic-next",
               "https://github.com/ntk148v/komau.vim" })

local is_transparent = false
vim.cmd.cabbrev("colo Colo")
vim.api.nvim_create_user_command("Colo", function(args)
    local colorscheme = args.fargs[1]
    local bg = args.fargs[2]
    local colors = { "Normal", "EndOfBuffer", "LineNr", "SignColumn", "TabLineFill" }

    vim.cmd.colo(colorscheme)

    if vim.list_contains({ "komau" }, colorscheme) then
        vim.api.nvim_set_hl(0, "WinSeparator", { bg = "#222222" })
    end

    if bg == nil then
        is_transparent = false
        return
    end

    if bg == "NONE" then
        is_transparent = true
    end

    for _, color in ipairs(colors) do
        vim.api.nvim_set_hl(0, color, { bg = bg })
    end

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2a2a2a" })
    vim.api.nvim_set_hl(0, "Float", { bg = "#2a2a2a" })
    vim.api.nvim_set_hl(0, "TabLine", { fg = "#666666" })
    vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#dadada" })
    vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#000000" })
end, { nargs = "+", complete = "color" })

local default_colorscheme = "komau"
local function set_colors()
    local current_colorscheme = vim.g.colors_name or default_colorscheme
    if is_transparent then
        vim.cmd("Colo " .. current_colorscheme .. " NONE")
    else
        vim.cmd.Colo(current_colorscheme)
    end
end
set_colors()

-- Neovide
if vim.g.neovide then
    vim.g.neovide_opacity = .73
    vim.g.neovide_normal_opacity = .73
    vim.g.neovide_scale_factor = 1.43
    vim.o.guifont = "Maple Mono"
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_no_idle = false
    vim.g.neovide_fullscreen = not is_transparent
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_position_animation_length = .15
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_cursor_vfx_mode = ""

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function() vim.cmd.edit("~/TODO.md") end
    })

    vim.keymap.set("n", "<C-enter>", function()
        is_transparent = not is_transparent
        vim.g.neovide_fullscreen = not is_transparent
        set_colors()
    end)
    vim.keymap.set("n", "<C-=>", function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.05
        vim.notify("Scale: " .. vim.g.neovide_scale_factor)
    end, { noremap = true })
    vim.keymap.set("n", "<C-->", function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.05
        vim.notify("Scale: " .. vim.g.neovide_scale_factor)
    end, { noremap = true })
end

-- Settings
vim.g.mapleader = " "
vim.o.lazyredraw = true
vim.o.swapfile = false
vim.o.wildmode = "longest:list,full"
vim.o.wildmenu = true
vim.o.laststatus = 3
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "80"
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.completeopt = "menu,menuone,noinsert,popup,fuzzy"
vim.o.undofile = true
vim.o.undolevels = 10000000
vim.o.undoreload = 10000000
vim.o.grepprg = "rg --vimgrep --no-heading"
vim.o.path = "**"
vim.o.wildignore =
    "**/node_modules/**,**/.git/**,**/__pycache__/**,**/.mypy_cache/**,**/.venv/**,**/.pytest_cache/**,**/.ruff_cache/**"
vim.o.spell = true
vim.o.spelllang = "en,ru"

-- Abbreviations
vim.cmd.cabbrev("W w")
vim.cmd.cabbrev("Wa wa")
vim.cmd.cabbrev("n norm")

-- Keymaps
vim.keymap.set({ "t", "n" }, "<C-\\><C-d>", "<C-\\><C-n>:Cd <C-r>=getcwd()<cr>/<C-d>", { noremap = true })
vim.keymap.set("n", "<C-f>", ":sp <C-r>=expand('%:p:h')<cr>/<C-d>", { noremap = true })
vim.keymap.set({ "t", "n" }, "<C-\\><C-f>", "<C-\\><C-n>:sp <C-r>=getcwd()<cr>/<C-d>", { noremap = true })
vim.keymap.set({ "t", "n" }, "<C-\\><C-h>", "<C-\\><C-n>:sp ~/<C-d>", { noremap = true })
vim.keymap.set({ "i", "n" }, "<C-p>", "<esc>:sf ", { noremap = true })

vim.keymap.set("n", "<C-\\><C-\\><C-d>", "<cmd>cd %:p:h<cr><cmd>echo expand('%:p:h')<cr>", { noremap = true })
vim.keymap.set("n", "<C-\\><C-t>", "<cmd>e ~/TODO.md<cr>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>gw", "<cmd>%bd|e#|bd#<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gw", "<cmd>bp|bd #<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gW", "<cmd>bp|bd! #<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz", { silent = true, noremap = true })

vim.keymap.set("n", "<C-d>", "<cmd>keepjumps normal! <C-d><cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-u>", "<cmd>keepjumps normal! <C-u><cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-y>", "3<C-y>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-e>", "3<C-e>", { silent = true, noremap = true })
vim.keymap.set("n", "n", "nzzzv", { silent = true, noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true, noremap = true })

vim.keymap.set({ "t", "n", "i" }, "<M-i>", "<cmd>tabprevious<cr>", { silent = true, noremap = true })
vim.keymap.set({ "t", "n", "i" }, "<M-o>", "<cmd>tabnext<cr>", { silent = true, noremap = true })
vim.keymap.set({ "t", "n", "i" }, "<M-S-i>", "<cmd>tabmove -<cr>", { silent = true, noremap = true })
vim.keymap.set({ "t", "n", "i" }, "<M-S-o>", "<cmd>tabmove +<cr>", { silent = true, noremap = true })

vim.keymap.set({ "n", "i" }, "<M-h>", "<cmd>norm! <C-w>h<cr>", { silent = true, noremap = true })
vim.keymap.set({ "n", "i" }, "<M-j>", "<cmd>norm! <C-w>j<cr>", { silent = true, noremap = true })
vim.keymap.set({ "n", "i" }, "<M-k>", "<cmd>norm! <C-w>k<cr>", { silent = true, noremap = true })
vim.keymap.set({ "n", "i" }, "<M-l>", "<cmd>norm! <C-w>l<cr>", { silent = true, noremap = true })

vim.keymap.set("t", "<M-h>", "<C-\\><C-n><cmd>norm! <C-w>h<cr><cmd>startinsert<cr>", { silent = true, noremap = true })
vim.keymap.set("t", "<M-j>", "<C-\\><C-n><cmd>norm! <C-w>j<cr><cmd>startinsert<cr>", { silent = true, noremap = true })
vim.keymap.set("t", "<M-k>", "<C-\\><C-n><cmd>norm! <C-w>k<cr><cmd>startinsert<cr>", { silent = true, noremap = true })
vim.keymap.set("t", "<M-l>", "<C-\\><C-n><cmd>norm! <C-w>l<cr><cmd>startinsert<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<C-q>", "<cmd>cope<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<M-c>", ":let @+=expand('%:p')<cr>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>m", function()
    vim.ui.input({ prompt = "Make> " }, function(input)
        if input == nil then return end
        vim.cmd.copen()
        vim.cmd.wincmd("p")
        vim.cmd("silent! make " .. input)
    end)
end , { noremap = true })

vim.keymap.set("n", "<leader>g", function()
    vim.ui.input({ prompt = "Grep> " }, function(input)
        if input == nil or input == "" then
            return
        end
        vim.cmd.copen()
        vim.cmd.wincmd("p")
        vim.cmd("silent! grep '" .. input .. "'")
    end)
end, { noremap = true })

-- Emacs-like keymaps
vim.o.cedit = "<C-s>"

-- duplicate current line
vim.keymap.set({ "n", "i", "v" }, "<C-l>", "<cmd>t.<cr>", { silent = true, noremap = true })
vim.keymap.set("i", "<C-/>", "<C-o>u", { noremap = true })
vim.keymap.set("i", "<M-a>", "<C-o>(", { noremap = true })
vim.keymap.set("i", "<M-e>", "<C-o>)", { noremap = true })
vim.keymap.set({ "i", "c" }, "<M-p>", "<Up>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<M-n>", "<Down>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-b>", "<Left>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-f>", "<Right>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-a>", "<Home>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<C-e>", "<End>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<M-b>", "<C-Left>", { noremap = true })
vim.keymap.set({ "i", "c" }, "<M-f>", "<S-Right>", { noremap = true })
vim.keymap.set("i", "<C-d>", "<Del>", { noremap = true })
vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true })
vim.keymap.set("i", "<C-k>", function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    if #line <= col then
        return "<Del><C-o>d$"
    end
    return "<C-o>d$"
end, { noremap = true, expr = true })
vim.keymap.set("c", "<C-k>", "<C-s><esc>ld$<C-c><End><space>", { noremap = true })
vim.keymap.set("c", "<M-d>", "<C-s><esc>ce<C-c><space>", { noremap = true })
vim.keymap.set("i", "<M-d>", "<C-o>ce", { noremap = true })
vim.keymap.set("i", "<C-k>", function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    if #line <= col then
        return "<Del>"
    end
    return "<C-o>d$"
end, { noremap = true, expr = true })

local function run_and_out(user_command)
    local cmd = user_command:gsub("^%s*:", ""):gsub("%s+$", "")

    local ok, res = pcall(vim.api.nvim_exec2, cmd, { output = true })
    local out
    if not ok then
        out = "Error: " .. tostring(res)
    else
        out = (res and res.output) and res.output or ""
    end

    out = out:gsub("^\n+", ""):gsub("\n+$", "")

    vim.cmd(":new | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile")

    local buf = vim.api.nvim_get_current_buf()

    vim.keymap.set("n", "q", function()
        vim.api.nvim_buf_delete(buf, { force = true })
        vim.cmd("stopinsert")
    end, { buffer = buf, noremap = true })

    local lines = vim.split(out, "\n", { plain = true })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

vim.keymap.set("c", "<C-g>", function()
    local user_command = vim.fn.getcmdline()
    if user_command == "" then
        user_command = vim.fn.histget(":", -1)
    end

    user_command = user_command:gsub("^%s*:", ""):gsub("%s+$", "")

    local cancel = vim.api.nvim_replace_termcodes("<C-c>", true, false, true)
    vim.schedule(function()
        run_and_out(user_command)
    end)
    return cancel
end, { expr = true, silent = true, noremap = true })

-- User commands
vim.api.nvim_create_user_command("Cd", function(args)
    local utils = require("sessionizer.utils")
    vim.cmd.Sess("unload")
    vim.cmd("cd " .. args.args)
    utils.purge_hidden_buffers()
    vim.cmd.edit(".")
end, { nargs = "+", complete = "dir" })

-- Auto commands
vim.cmd([[
    autocmd BufWritePre * %s/\s\+$//e
    autocmd TextYankPost * silent! lua vim.hl.on_yank({higroup="IncSearch", timeout=150})
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd CmdwinEnter [:/\?] startinsert
    autocmd TermOpen * set nospell | set ft=shell
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   silent! normal! g`"zz |
        \ endif
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p") ]])

-- Plugins
vim.opt.runtimepath:append("/home/nnofly/code/personal/sessionizer.nvim")
vim.pack.add({
    "https://github.com/chentoast/marks.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/supermaven-inc/supermaven-nvim",
})

require("terminal")

-- require("vim._extui").enable({ enable = true, msg = { target = "msg", timeout = 4000 } })
require("marks").setup({ builtin_marks = { ".", "<", ">", "^" } })
require("mason").setup()
require("supermaven-nvim").setup({})
vim.schedule(function()
    require("supermaven-nvim.api").stop()
end)
vim.keymap.set({ "n", "i" }, "<M-g>", function()
    require("supermaven-nvim.api").toggle()
    if require("supermaven-nvim.api").is_running() then
        vim.notify("Supermaven is enabled")
    else
        vim.notify("Supermaven is disabled")
    end
end)

local statusline = vim.o.statusline
require("sessionizer").setup({
    exclude_filetypes = { "gitcommit" },
    paths = {
        "~/code/personal/*",
        "~/code/work/*",
        "~/.dotfiles/*",
        "~/.config/nvim",
    },
    smart_auto_load = false,
    auto_save = false,
    log_level = "error",
    before_load = {
        auto_save_files = true,
        auto_remove_buffers = true,
    },
    after_load = {
        custom = function()
            local session = vim.g.sessionizer_current_session or ""
            if session ~= "" then
                session = "[" .. session .. "] "
            end
            vim.o.statusline = session .. statusline
        end,
    },
    on_unload = {
        custom = function()
            vim.o.statusline = statusline
        end,
    },
})

vim.keymap.set({ "n", "i", "t" }, "<C-M-l>", "<cmd>Sess last<cr>", { noremap = true })
vim.keymap.set({ "n", "i", "t" }, "<C-\\><C-s>", "<esc><C-\\><C-n>:Sess load <C-d>", { noremap = true })
vim.keymap.set("n", "<leader>sp", "<cmd>Sess pin<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ss", "<cmd>Sess save<cr>", { noremap = true })
vim.keymap.set(
    "n",
    "<C-\\><C-\\><C-o>",
    "<cmd>Sess unload<cr><cmd>silent! bufdo bd<cr><cmd>term<cr><cmd>startinsert<cr>",
    { noremap = true }
)

local sessionizer_utils = require("sessionizer.utils")

vim.api.nvim_create_user_command("DT", function()
    sessionizer_utils.purge_term_buffers()
    vim.notify("Purged terminal buffers")
end, { nargs = 0 })

local sessionizer_commands = require("sessionizer.commands")
local sessionizer_opts = require("sessionizer").get_opts()
local sessionizer_state = require("sessionizer.state")

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        if vim.list_contains(sessionizer_opts.exclude_filetypes, vim.bo.filetype) then
            return
        end
        if not sessionizer_state.get_current_session() then
            return
        end
        sessionizer_utils.purge_term_buffers()
        sessionizer_commands.save()
    end
})

vim.g.sess_unload_is_enabled = true

vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
        if vim.bo.filetype == "shell" then
            vim.g.sess_unload_is_enabled = false
        else
            vim.g.sess_unload_is_enabled = true
        end
    end,
})

vim.api.nvim_create_autocmd("DirChangedPre", {
    callback = function()
        if not vim.g.sess_unload_is_enabled or vim.bo.filetype == "shell" then
            return
        end
        vim.cmd.Sess("unload")
    end,
})

-- LSP
vim.keymap.set("n", "grd", "<cmd>lua vim.diagnostic.setqflist()<cr><cmd>wincmd p<cr>", { silent = true })
vim.keymap.set("n", "grf", vim.lsp.buf.format, { silent = true })

vim.diagnostic.config({ jump = { float = true } })

local lsp = require("lsp")

lsp.setup_linters({ "pyrefly", "shellcheck", "biome" })
lsp.setup_formatters({ "ruff", "prettier", "biome", "stylua" })
lsp.setup_lsps({
    "lua-language-server",
    "pyrefly",
    "ruff",
    "typescript-language-server",
    "biome",
    "css-lsp",
    "css-variables-language-server",
    "emmet-language-server",
    "html-lsp",
    "clangd",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspOnAttach", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
        vim.lsp.semantic_tokens.enable(false, { bufnr = args.buf })
    end,
})

vim.api.nvim_create_user_command("LspServersInstall", lsp.lsps_server_install, { nargs = 0 })
