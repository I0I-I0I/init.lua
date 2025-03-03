" =============================================================================
" GENERAL SETTINGS
" =============================================================================

" Colorscheme and background tweaks
colorscheme rose-pine

" Set a uniform background for UI elements
let s:color_bg = '#0e0a00'
for group in ['Normal', 'NormalNC', 'LineNr', 'SignColumn', 'EndOfBuffer', 'Folded']
    execute 'highlight ' . group . ' guibg=' . s:color_bg
endfor
execute 'hi AugmentSuggestionHighlight guifg=#' . s:color_bg
execute 'highlight StatusLine guibg=#1e1e1e'

" =============================================================================
" PLUGIN MAPPINGS
" =============================================================================

nnoremap <silent> <localleader>g :Git<CR>
nnoremap <silent> <localleader><C-g>l :tabnew<cr>:GlLog<CR>
nnoremap <silent> <localleader><C-g>p <cmd>copen \| wincmd p<cr>:Gpush<cr>
nnoremap <silent> <localleader><C-g>P <cmd>copen \| wincmd p<cr>:Gpush --force<CR>
nnoremap <silent> <localleader><C-g>f <cmd>copen \| wincmd p<cr>:Gfetch<CR>
nnoremap <silent> <localleader><C-g>d :Git diff<CR>
nnoremap <silent> <localleader><C-g>D :Git difftool<CR>
nnoremap <silent> <localleader><C-g>M :Git mergetool<CR>

nnoremap <silent> <localleader>d :tabnew<CR>:DBUIToggle<CR>

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

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <M-C-L> 5<C-w>>
nnoremap <M-C-K> 5<C-w>-
nnoremap <M-NL> 5<C-w>+
nnoremap <M-C-H> 5<C-w><
