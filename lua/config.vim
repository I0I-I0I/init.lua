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
set signcolumn=yes        " Always show the sign column
set shortmess=aoOtTI
set laststatus=3          " Global statusline (Neovim 0.7+ supports)
" Indentation & whitespace
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set linebreak
set smartcase incsearch hlsearch " Search settings

set cul
autocmd InsertEnter * set nocul
autocmd InsertLeave * set cul

set completeopt=menu,menuone,noinsert,popup,preview " Completion options

"set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --glob\ '!libs'\ --glob\ '!tags' " Use ripgrep for :grep commands
set grepformat=%f:%l:%c:%m

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
let mapleader = " "
let maplocalleader = ""

" -- Normal Mode Mappings --

nnoremap Q <nop>
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
nnoremap <silent> <C-w>C :tabc<CR>
nnoremap <silent> <C-w>t :tabnew<CR>
nnoremap <silent> <C-z> :bd<CR>
nnoremap <silent> <leader><C-z> :bd!<CR>
nnoremap <silent> <C-n> :cnext<CR>zz
nnoremap <silent> <C-p> :cprevious<CR>zz
nnoremap <silent> <A-]> :lnext<cr>zz
nnoremap <silent> <A-[> :lprevious<cr>zz
cnoremap <C-w> <backspace><C-w>
nnoremap <silent> <M-c> :let @+=expand("%")<cr>
nnoremap <silent> <M-S-c> :let @+=expand("%") . ':' . line(".")<cr>

" -- TMUX & External Tools --
nnoremap <silent> <leader><C-Space> :execute '!tmux neww tmux-yazi ' . expand("%:p:h")<CR>
nnoremap <silent> <leader><C-t> :!tmux neww tmux-sessionizer<CR>

" Custom functions

function! ToggleList(list_open, list_close)
    for winnr in range(1, winnr('$'))
        if getwinvar(winnr, '&syntax') == 'qf'
            execute a:list_close
            return
        endif
    endfor
    execute a:list_open . ' | wincmd p'
endfunction

nnoremap <silent> <leader>q :call ToggleList('copen', 'cclose')<CR>
nnoremap <silent> <leader>l :call ToggleList('lopen', 'lclose')<CR>

nnoremap <localleader><C-e> :e <C-r>=expand("%:p:h")<CR>/<C-d>
nnoremap <localleader><C-v> :vs <C-r>=expand("%:p:h")<CR>/<C-d>
nnoremap <localleader><C-t> :tabnew <C-r>=expand("%:p:h")<CR>/<C-d>

nnoremap <C-f> :fin<space>
nnoremap  :gr<space>
nnoremap tt :tabnew<cr>:fin<space>
nnoremap tv :vs<cr>:fin<space>

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

" Colors

function! SetBG(color, second_color = '')
    if empty(a:second_color)
        let l:second_color = '#1e1e1e'
    else
        let l:second_color = a:second_color
    endif
    set cursorline
    hi CursorLine gui=underline term=underline guibg=Normal
    hi CursorLineNr guibg=Normal
    hi Normal guibg=a:color
    hi NormalNC guibg=Normal
    hi EndOfBuffer guibg=Normal
    hi LineNr guibg=Normal
    hi SignColumn guibg=Normal
    hi Folded guibg=Normal
    hi StatusLine guibg=l:second_color
    hi TabLineFill guibg=l:second_color
    hi BlinkCmpSignatureHelpActiveParameter guibg=#D4D4D4 guifg=#000001
endfunction
command! -nargs=* Setbg call SetBG(<f-args>)
