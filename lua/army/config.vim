" =============================================================================
" GENERAL SETTINGS
" =============================================================================

" Colorscheme and background tweaks
colorscheme OceanicNext

" Set a uniform background for UI elements
let s:color_bg = '#000001'
for group in ['Normal', 'LineNr', 'SignColumn', 'EndOfBuffer', 'Folded']
    execute 'highlight ' . group . ' guibg=' . s:color_bg
endfor

" =============================================================================
" WORKSPACE FOLDERS FOR AI
" =============================================================================

let g:augment_workspace_folders = [
            \ "~/code/personal/real-time-chat/",
            \ "~/code/personal/track-mouse/"
            \]

" =============================================================================
" PLUGIN MAPPINGS
" =============================================================================

let g:ez_terminal_key = '<Nop>'
let g:resize_start_key = '<C-w><C-r>'

nnoremap <silent> <localleader>g :Git<CR>
nnoremap <silent> <localleader><C-g>l :tabnew<cr>:GlLog<CR>
nnoremap <silent> <localleader><C-g>p :Gpush<CR>
nnoremap <silent> <localleader><C-g>P :Gpush --force<CR>
nnoremap <silent> <localleader><C-g>f :Gfetch<CR>
nnoremap <silent> <localleader><C-g>d :Git diff<CR>
nnoremap <silent> <localleader><C-g>D :Git difftool<CR>
nnoremap <silent> <localleader><C-g>M :Git mergetool<CR>
nnoremap <silent> <localleader>d :tabnew<CR>:DBUIToggle<CR>
nnoremap <silent> <localleader>u :UndotreeToggle<CR>:UndotreeFocus<CR>

vnoremap <localleader><C-a>c :Augment chat<CR>
nnoremap <localleader><C-a>c :Augment chat<CR>
nnoremap <silent> <localleader><C-a>t :Augment chat-toggle<CR>
nnoremap <silent> <localleader><C-a>n :Augment chat-new<CR>
nnoremap <silent> <localleader><C-a>s :Augment status<CR>

" =============================================================================
" CUSTOM FUNCTIONS
" =============================================================================

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

nnoremap <C-f> <Nop>
nnoremap <C-f>f :call FindFiles()<CR>
nnoremap <C-f><C-t> :tabnew<cr>:find<space><C-d>
nnoremap <C-f><C-v> :vs<cr>:find<space><C-d>
nnoremap <C-f><C-f> :find<space><C-d>
nnoremap  :call FindWord()<CR>

" Jump to tag under cursor in a vertical split
function! JumpToTag(is_split)
    let l:word = expand('<cword>')
    if a:is_split
        vsplit
    endif
    if !empty(l:word)
        execute 'ltag ' . l:word
        execute 'lopen | wincmd p'
    endif
endfunction

nnoremap <C-w><C-]> :call JumpToTag(1)<CR>
nnoremap <silent> <C-]> :call JumpToTag(0)<CR>
