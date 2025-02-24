colorscheme OceanicNext

set wildignore=*/node_modules/*,*/build/*,*/dist/*,*/env/*,/usr/local/include/*,/usr/include/*
set path+=**

let g:netrw_banner=0
let g:netrw_list_hide="node_modules/,^\\.\\=/\\=$,^\\.\\.\\=/\\=$"
let g:netrw_altfile = 1
let g:netrw_fastbrowse = 0

set lazyredraw ttyfast
set synmaxcol=200
set undofile
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden
set grepformat=%f:%l:%c:%m
set undolevels=10000000
set undoreload=10000000
set termguicolors
set noswapfile
set smartindent expandtab shiftwidth=4 tabstop=4
set completeopt=menu,menuone,fuzzy,noinsert,popup
set linebreak
set smartcase incsearch ignorecase hlsearch
set mouse=a
set rnu nu
set updatetime=300
set signcolumn=yes
set laststatus=3
set hidden

syntax on
filetype plugin indent on

let g:augment_workspace_folders = [
            \ "~/code/personal/real-time-chat/",
            \ "~/code/personal/track-mouse/"
            \]

let color = '#000001'
execute 'highlight Normal guibg=' . color
execute 'highlight LineNr guibg=' . color
execute 'highlight SignColumn guibg=' . color
execute 'highlight EndOfBuffer guibg=' . color

augroup vimrc_autocmds
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
    autocmd FileType fugitive nmap q <cmd>clo<cr>
    autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
    autocmd BufWritePre * %s/\s\+$//e
    autocmd FocusGained,BufEnter * checktime
    autocmd FileType netrw setl bufhidden=wipe
augroup END

" Mappings

let g:mapleader=" "

cmap W! w !sudo tee > /dev/null %

nnoremap Q <nop>
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap <C-y> 3<C-y>
nnoremap <C-e> 3<C-e>
nnoremap <silent> <leader><leader> :nohlsearch<CR>
nnoremap <silent> - <cmd>:Ex<cr>
vnoremap <silent> K :m '<-2<cr>gv=gv
vnoremap <silent> J :m '>+1<cr>gv=gv
nnoremap <silent> <C-w>C <cmd>tabc<cr>
nnoremap <silent> o <cmd>tabn<cr>
nnoremap <silent> i <cmd>tabp<cr>
nnoremap <silent> O <cmd>tabmove +<cr>
nnoremap <silent> I <cmd>tabmove -<cr>
nnoremap <silent> <C-z> <cmd>bd<cr>
nnoremap <silent> <leader><C-z> <cmd>bd!<cr>
nnoremap <silent> <leader>q :copen \| wincmd p<cr>
nnoremap <silent> <C-n> <cmd>cnext<cr>zz
nnoremap <silent> <C-p> <cmd>cprevious<cr>zz

cnoremap <C-b> <Left>
cnoremap b <C-Left>
cnoremap <C-f> <Right>
cnoremap f <C-Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap d <C-Del>

nnoremap <silent> <C-Space> <cmd>execute '!tmux neww tmux-yazi ' . expand("%:p:h")<cr>
nnoremap <silent> <C-t> <cmd>!tmux neww tmux-sessionizer<cr>

function! FindWord()
    let input = input('Enter word: ')
    if input == ''
        return
    endif
    execute "copen | wincmd p"
    execute "AsyncRun rg --vimgrep --no-heading --smart-case --glob '!libs' '" . input . "'"
endfunction

nnoremap  :call FindWord()<cr>

" Plugins

let g:ez_terminal_key = '<Nop>'
let g:resize_start_key = '<C-w><C-r>'

nnoremap <silent> <C-g>g :Git<cr>
nnoremap <silent> <C-g><C-g>l :GlLog<cr>
nnoremap <silent> <C-g>d :tabnew<cr>:DBUIToggle<cr>
nnoremap <silent> <C-g>u :UndotreeToggle<cr><cmd>UndotreeFocus<cr>
vnoremap <C-g><C-a>c :Augment chat<cr>
nnoremap <C-g><C-a>c <cmd>Augment chat<cr>
nnoremap <silent> <C-g><C-a>t <cmd>Augment chat-toggle<cr>
nnoremap <silent> <C-g><C-a>n <cmd>Augment chat-new<cr>
nnoremap <silent> <C-g><C-a>s <cmd>Augment status<cr>

nnoremap <silent> Rm :copen \| wincmd p<cr><cmd>AsyncRun make<cr>
nnoremap RM :copen \| wincmd p<cr>:AsyncRun make
nnoremap <silent> Rd :copen \| wincmd p<cr><cmd>AsyncRun make debug<cr>
nnoremap <silent> Rs :cclose<cr><cmd>AsyncStop<cr>
nnoremap <silent> Rr :copen \| wincmd p<cr><cmd>AsyncReset<cr>
