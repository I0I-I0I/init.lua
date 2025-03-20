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
