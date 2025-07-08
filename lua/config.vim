if has("termguicolors")
    set termguicolors
endif

set wildignore=*/node_modules/*,*/build/*,*/dist/*,*/env/*,/usr/local/include/*,/usr/include/*
set path+=**

let g:netrw_banner     = 0
let g:netrw_list_hide  = "node_modules/,^\\.\\=/\\=$,^\\.\\.\\=/\\=$"
let g:netrw_altfile    = 1
let g:netrw_fastbrowse = 0

set lazyredraw            " Redraw only when needed for speed
set updatetime=300        " Faster completion and CursorHold events
set noswapfile            " Disable swap files
set undofile              " Enable persistent undo
set undolevels=10000000
set undoreload=10000000
set synmaxcol=200         " Avoid slow syntax in very long lines
set mouse=a               " Enable mouse in all modes
set hidden                " Allow hidden buffers
set rnu nu                " Relative line numbers and line numbers
set wildmode=list,full
set wildmenu
set splitright            " Split windows to the right by default
set signcolumn=yes:2      " Always show the sign column
set laststatus=3          " Global statusline (Neovim 0.7+ supports)
" Indentation & whitespace
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set linebreak
set smartcase incsearch hlsearch " Search settings
set winborder=solid

set cul
autocmd InsertEnter * set nocul
autocmd InsertLeave * set cul

set completeopt=menu,menuone,noinsert,popup,preview " Completion options

augroup vimrc_autocmds
    autocmd!
    " Jump to last edit position when reopening files
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif

    " Close fugitive window with q
    autocmd FileType qf,git,help nmap <buffer> q <cmd>bd<cr>

    " Highlight yanked text
    autocmd TextYankPost * silent! lua vim.hl.on_yank({higroup="IncSearch", timeout=100})

    " Create missing directories on save
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")

    " Remove trailing whitespace on save
    autocmd BufWritePre * %s/\s\+$//e

    " Check if files have changed outside Vim
    autocmd FocusGained,BufEnter * checktime

    " Remove netrw buffer after closing
    autocmd FileType netrw setlocal bufhidden=wipe

    " C/C++: Toggle between header and source file
    autocmd FileType c,cpp nnoremap <silent> <A-s> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<cr>
    "autocmd FileType cpp nnoremap <silent> <A-s> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>
augroup END

" Key mappings

" Leader keys
let mapleader=" "
let maplocalleader="" " <C-x>

" -- Normal Mode Mappings --

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
noremap <C-y> 3<C-y>
noremap <C-e> 3<C-e>
nnoremap <silent> <leader><leader> :nohlsearch<CR>
nnoremap <silent> - :Ex<CR>
vnoremap <silent> K :m '<-2<CR>gv=gv
vnoremap <silent> J :m '>+1<CR>gv=gv
nnoremap <silent> <C-n> :cnext<CR>zz
nnoremap <silent> <C-p> :cprevious<CR>zz
nnoremap <silent> <C-M-n> :lnext<cr>zz
nnoremap <silent> <C-M-p> :lprevious<cr>zz
cnoremap <C-w> <backspace><C-w>
nnoremap <silent> <M-c> :let @+=expand("%")<cr>
nnoremap <silent> <M-S-c> :let @+=expand("%") . ':' . line(".")<cr>

nnoremap <localleader><C-f> :e <C-r>=expand("%:p:h")<CR>/<C-d>
nnoremap <localleader><C-v> :vs <C-r>=expand("%:p:h")<CR>/<C-d>
nnoremap <localleader><C-n> :tabnew <C-r>=expand("%:p:h")<CR>/<C-d>

" -- TMUX & External Tools --
nnoremap <silent> <C-Space> :execute '!tmux-yazi ' . expand("%:p:h")<CR>
nnoremap <silent> <C-s> :!tmux neww tmux-sessionizer<CR>
nnoremap <silent> <C-g> :!tmux-git<CR>

" Remove hidden buffers
function! RemoveHiddenBuffers()
    let bufinfos = getbufinfo({'buflisted': 1})
    let count = 0
    for bufinfo in bufinfos
        if bufinfo.changed == 0
            if exists('bufinfo.windows') && type(bufinfo.windows) == type([]) && len(bufinfo.windows) == 0
                execute 'bdelete' bufinfo.bufnr
                let count += 1
            elseif !exists('bufinfo.windows')
                execute 'bdelete' bufinfo.bufnr
                let count += 1
            endif
        endif
    endfor
    echo 'Removed ' .. count .. ' hidden buffers'
endfunction
command! -nargs=0 RemoveHiddenBuffers call RemoveHiddenBuffers()
nnoremap <silent> <leader>R <cmd>RemoveHiddenBuffers<cr>

lua << EOF
function SetBG(color, second_color)
    second_color = second_color or "#1e1e1e"

    vim.api.nvim_set_hl(0, "CursorLine", { underline = true, bg = color })
    vim.cmd.hi("Normal guibg=" .. color)
    vim.cmd.hi("CursorLineNr guibg=" .. color)
    vim.cmd.hi("NormalNC guibg=" .. color)
    vim.cmd.hi("EndOfBuffer guibg=" .. color)
    vim.cmd.hi("SignColumn guibg=" .. color)
    vim.cmd.hi("Folded guibg=" .. color)
    vim.cmd.hi("LineNr guibg=" .. color)
    vim.cmd.hi("TabLineFill guibg=" .. color)
    vim.cmd.hi("StatusLine guibg=" .. second_color)

    if color == "NONE" then
        vim.cmd([[
            hi TabLineFill guibg=NONE
            hi TelescopeBorder guibg=NONE
        ]])
    end

    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", {
        bg = "#D4D4D4",
        fg = "#000001"
    })

    vim.opt.cursorline = true
end

vim.api.nvim_create_user_command('Setbg', function(opts)
    local args = vim.split(opts.args or '', '%s+')
    local color = args[1]
    local second_color = args[2] or ''

    if color then
        SetBG(color, second_color ~= '' and second_color or nil)
    else
        vim.notify('Setbg requires at least a color argument', vim.log.levels.ERROR)
    end
end, { nargs = '*' })

vim.api.nvim_create_user_command("Colors", function()
    local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    local normal_float_hl = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
    local colors = {
        {
            hl = { bg = "NONE", fg = normal_hl.fg },
            list = {
                "DiagnosticSignError",
                "DiagnosticSignWarn",
                "DiagnosticSignOk",
                "DiagnosticSignInfo",
                "DiagnosticSignHint",
                "GitGutterAdd",
                "GitGutterRemove",
                "GitGutterChange",
                "GitGutterDelete"
            },
        },
        {
            hl = { bg = normal_float_hl.bg, fg = normal_hl.fg },
            list = {
                "DiagnosticFloatingError",
                "DiagnosticFloatingWarn",
                "DiagnosticFloatingOk",
                "DiagnosticFloatingInfo",
                "DiagnosticFloatingHint"
            },
        }
    }

    for _, item in pairs(colors) do
        for _, color in pairs(item.list) do
            vim.api.nvim_set_hl(0, color, {
                fg = item.hl.fg,
                bg = item.hl.bg
            })
        end
    end

    vim.cmd([[
        hi DiffAdded guibg=NONE guifg=#199F4B
        hi DiffAdd guibg=NONE guifg=#199F4B
        hi DiffDelete guibg=NONE guifg=#D48787
        hi DiffRemoved guibg=NONE guifg=#D48787
        hi DiffChange guibg=NONE guifg=#F9ED77
        hi DiffChanged guibg=NONE guifg=#F9ED77
        hi SignColumn guibg=NONE
    ]])
end, { nargs = 0 })
EOF
