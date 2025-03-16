" =============================================================================
" GENERAL SETTINGS
" =============================================================================

" Set a uniform background for UI elements
let s:color_bg = 'NONE'
for group in ['Normal', 'NormalNC', 'LineNr', 'SignColumn','Folded', 'CursorLine']
    execute 'highlight ' . group . ' guibg=' . s:color_bg
endfor
execute 'highlight StatusLine guibg=#1e1e1e'
execute 'highlight Folded guifg=#d3c6aa'

set cul
autocmd InsertEnter * set nocul
autocmd InsertLeave * set cul
execute 'highlight CursorLine gui=underline term=underline'

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

nnoremap <C-f> :find<space><C-d>
nnoremap  :call FindWord()<CR>
nnoremap tf :call FindFiles()<CR>
nnoremap tt :tabnew<cr>:find<space><C-d>
nnoremap tv :vs<cr>:find<space><C-d>

" Jump to tag under cursor in a vertical split
function! JumpToTag(is_split)
    let l:word = expand('<cword>')
    if a:is_split
        vsplit
    endif
    if !empty(l:word)
        execute 'ltag ' . l:word
    endif
endfunction

nnoremap <C-w><C-]> :call JumpToTag(1)<CR>
nnoremap <silent> <C-]> :call JumpToTag(0)<CR>
