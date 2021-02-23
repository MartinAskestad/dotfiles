setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal number relativenumber
setlocal omnifunc=lsp#complete

if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

nnoremap <buffer> <leader>ld :tab LspDefinition<CR>
nnoremap <buffer> <leader>lh  :LspHover<CR>

" go to the next opening tag below current line
nnoremap <buffer> <leader>hj 0/$/;/<[a-zA-Z][a-zA-Z0-9]*\%(\_[^>]*>\)\@=<CR>

" go  to the next end of closing tag or empty elenent below current line
nnoremap <buffer> <leader>hjj 0/$/;/\%([^>]*$\)\@=<CR>

" go to the previous closing tab above the current line
nnoremap <buffer> <leader>hk $?^?;?>\%([^>]*$\)\@=<CR>

" go to the previous opening tab above the current line
nnoremap <buffer> <leader>hkk $?^?;?^[^z]*\zs<\%([a-zA-Z][a-zA-Z0-9]*\_[^>]*>\)\@=<CR>

" go to the next tag element closing
nnoremap <buffer> <leader>hl /><CR>

" go to the previous tag element opening
nnoremap <buffer> <leader>hh ?<<CR>

" Semantics
setlocal iskeyword=@,48-57,_,-,\"

" Navigation
setlocal suffixesadd+=.html,.css,.txt,.js,.ts,.json
