" =============================================================================
" GENERAL SETTINGS & APPEARANCE
" =============================================================================

" Enable true colors if supported
if has("termguicolors")
    set termguicolors
endif

" =============================================================================
" FILE SEARCH, WILDMENU, & PATHS
" =============================================================================

" Ignore build artifacts and common folders during file navigation
set wildignore=*/node_modules/*,*/build/*,*/dist/*,*/env/*,/usr/local/include/*,/usr/include/*
set path+=**

" =============================================================================
" NETRW CONFIGURATION
" =============================================================================

let g:netrw_banner     = 0
let g:netrw_list_hide  = "node_modules/,^\\.\\=/\\=$,^\\.\\.\\=/\\=$"
let g:netrw_altfile    = 1
let g:netrw_fastbrowse = 0

" =============================================================================
" PERFORMANCE & GENERAL EDITOR SETTINGS
" =============================================================================

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

" Global statusline (Neovim 0.7+ supports)
set laststatus=3

" =============================================================================
" EDITING & SEARCH OPTIONS
" =============================================================================

" Indentation & whitespace
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set linebreak

" Search settings
set smartcase incsearch hlsearch

" Completion options
set completeopt=menu,menuone,fuzzy,noinsert,popup

" =============================================================================
" FOLDING
" =============================================================================

"set foldmethod=syntax
set foldlevel=0
set foldnestmax=1

" =============================================================================
" GREP / EXTERNAL TOOLS
" =============================================================================

" Use ripgrep for :grep commands
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --glob\ '!libs'\ --glob\ '!tags'
set grepformat=%f:%l:%c:%m

" =============================================================================
" AUTO COMMANDS
" =============================================================================

augroup vimrc_autocmds
    autocmd!
    " Jump to last edit position when reopening files
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
                \ endif

    " Close fugitive window with q
    autocmd FileType fugitive,qf,git nmap <buffer> q <cmd>bd<cr>

    " Disable auto folding in fugitive
    autocmd FileType fugitive,git setlocal foldlevel=99

    " Highlight yanked text
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=100})

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

" =============================================================================
" WORKSPACE FOLDERS FOR AI
" =============================================================================

let g:augment_workspace_folders = [
            \ "~/code/personal/real-time-chat/",
            \ "~/code/personal/sessions.nvim/",
            \ "~/code/personal/track-mouse/",
            \ "~/.config/nvim/"
            \]

" =============================================================================
" KEY MAPPINGS
" =============================================================================

" Leader keys
let mapleader = " "
let maplocalleader = "" " <C-g>

" -- Normal Mode Mappings --

" Duplicate line and keep cursor in the same column
nnoremap <A-v> yympp`pj
vnoremap <A-v> mpy`]p`pj
inoremap <A-v> <esc>yympp`pja

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
nnoremap <silent> <A-o> :tabn<CR>
nnoremap <silent> <A-i> :tabp<CR>
nnoremap <silent> <A-O> :tabmove +<CR>
nnoremap <silent> <A-I> :tabmove -<CR>
nnoremap <silent> <C-z> :bd<CR>
nnoremap <silent> <leader><C-z> :bd!<CR>
nnoremap <silent> <C-n> :cnext<CR>zz
nnoremap <silent> <C-p> :cprevious<CR>zz
nnoremap <silent> <A-]> :lnext<cr>zz
nnoremap <silent> <A-[> :lprevious<cr>zz

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <M-C-L> 5<C-w>>
nnoremap <M-C-K> 5<C-w>-
nnoremap <M-NL> 5<C-w>+
nnoremap <M-C-H> 5<C-w><

function! GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - 1]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function ManPageVisual()
    execute 'Man ' . GetVisualSelection()
endfunction

nnoremap <silent> <leader>K :execute 'Man ' . expand('<cword>')<cr>
vnoremap <silent> <leader>K :call ManPageVisual()<cr>

" -- Command-Line Mode Mappings --
cmap W! w !sudo tee > /dev/null %
cnoremap <C-w> <backspace><C-w>
cnoremap <C-j> <C-z><C-d>
cnoremap <C-b> <Left>
cnoremap <A-b> <C-Left>
cnoremap <C-f> <Right>
cnoremap <A-f> <C-Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <A-d> <C-Del>

inoremap <C-b> <Left>
inoremap <A-b> <C-Left>
inoremap <C-f> <Right>
inoremap <A-f> <C-Right>
inoremap <C-a> <Home>
inoremap <C-d> <Del>
inoremap <silent> <C-k> <cmd>norm Da<cr><right>
inoremap <silent> <A-d> <cmd>norm de<cr>

" -- TMUX & External Tools --
nnoremap <silent> <leader><C-Space> :execute '!tmux neww tmux-yazi ' . expand("%:p:h")<CR>
nnoremap <silent> <leader><C-t> :!tmux neww tmux-sessionizer<CR>

" =============================================================================
" Plugin Mappings
" =============================================================================

" Fugitive
nnoremap <silent> <localleader>g :Git<CR>
nnoremap <silent> <localleader><C-g>l :GcLog %<CR>
nnoremap <silent> <localleader><C-g>L <cmd>tabnew<cr>:GcLog<CR>
nnoremap <silent> <localleader><C-g>p <cmd>copen \| wincmd p<cr>:Gpush<cr>
nnoremap <silent> <localleader><C-g>P <cmd>copen \| wincmd p<cr>:Gpush --force<CR>
nnoremap <silent> <localleader><C-g>f <cmd>copen \| wincmd p<cr>:Gfetch<CR>
nnoremap <silent> <localleader><C-g>d :Git diff<CR>
nnoremap <silent> <localleader><C-g>D :Git difftool<CR>
nnoremap <silent> <localleader><C-g>M :Git mergetool<CR>

" Dadbod
nnoremap <silent> <localleader>d :tabnew<CR>:DBUIToggle<CR>

" -- AsyncRun Mappings --
nnoremap <M-;> :copen \| wincmd p<CR>:AsyncRun<space>
nnoremap mM :copen \| wincmd p<CR>:Make<space>
nnoremap <silent> mm :copen \| wincmd p<CR>:Make<CR>
nnoremap <silent> md :copen \| wincmd p<CR>:Make debug<CR>
nnoremap <silent> ms :cclose<CR>:AsyncStop<CR>
nnoremap <silent> mr :copen \| wincmd p<CR>:AsyncReset<CR>
nnoremap <silent> mcc :Ctags .<CR>
nnoremap <silent> mcf :Ctags --langmap=TypeScript:.ts.tsx --langmap=JavaScript:.js.jsx src/<CR>

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
command! -bang -nargs=* -complete=file Ctags AsyncRun ctags -R <args>
command! -bang -nargs=* -complete=file Gr AsyncRun rg
            \   --vimgrep --no-heading --smart-case --glob ''!libs'' --glob ''!tags'' ''<args>''
command! -bang -bar -nargs=* Gpush execute 'AsyncRun<bang> -cwd=' .
            \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'AsyncRun<bang> -cwd=' .
            \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>

" =============================================================================
" CUSTOM FUNCTIONS
" =============================================================================

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
nnoremap <silent> <leader>L :call ToggleList('lopen', 'lclose')<CR>

nnoremap <localleader><C-e> :e <C-r>=expand("%:p:h")<CR>/<C-d>
nnoremap <localleader><C-v> :vs <C-r>=expand("%:p:h")<CR>/<C-d>
nnoremap <localleader><C-t> :tabnew <C-r>=expand("%:p:h")<CR>/<C-d>
nnoremap <localleader><C-h> :tabnew ~/<C-d>

function MyFoldText()
    return ' ' . getline(v:foldstart) . '•••'
endfunction
set foldtext=MyFoldText()

set fillchars+=eob:\ ,fold:\  "


" Function to search for a word using ripgrep and populate the quickfix list
function! FindWord()
    let l:input = input('Grep -> ')
    if empty(l:input)
        return
    endif
    execute 'Gr ' . shellescape(l:input)
    sleep 100m
    if !empty(getqflist())
        mark B
        copen | wincmd p
        execute "cc 2"
    endif
endfunction

" Function to search for files using find and populate the quickfix list
function! FindFiles()
    let l:pattern = input('Find -> ')
    if empty(l:pattern)
        return
    endif
    let l:cmd = 'find . -type f -name ' . shellescape(l:pattern)
    let l:output = systemlist(l:cmd)
    if v:shell_error
        echoerr "Error running find command"
        return
    endif
    let l:qf_items = []
    for l:line in l:output
        if !empty(l:line)
            call add(l:qf_items, {'filename': l:line, 'lnum': 1, 'col': 1, 'text': l:line})
        endif
    endfor
    call setqflist(l:qf_items, 'r')
    if !empty(l:qf_items)
        mark B
        copen | wincmd p
        execute "cc 1"
    endif
endfunction

nnoremap <C-f> :find<space><C-d>
nnoremap  :call FindWord()<CR>
nnoremap tf :call FindFiles()<CR>
nnoremap tt :tabnew<cr>:find<space><C-d>
nnoremap tv :vs<cr>:find<space><C-d>
