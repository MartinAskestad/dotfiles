setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal number relativenumber
setlocal omnifunc=lsp#complete

if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
nnoremap <leader>gd :tab LspDefinition<CR>
nnoremap <leader>k  :LspHover<CR>

" go to the next opening tag below current line
nnoremap <leader>ot 0/$/;/<[a-zA-Z][a-zA-Z0-9]*\%(\_[^>]*>\)\@=<CR>

" go  to the next end of closing tag or empty elenent below current line
nnoremap <leader>ct 0/$/;/\%([^>]*$\)\@=<CR>

" go to the previous closing tab above the current line
nnoremap <leader>pct $?^?;?>\%([^>]*$\)\@=<CR>

" go to the previous opening tab above the current line
nnoremap <leader>pot $?^?;?^[^z]*\zs<\%([a-zA-Z][a-zA-Z0-9]*\_[^>]*>\)\@=<CR>

" go to the next tag element closing
nnoremap <leader>cc /><CR>

" go to the previous tag element opening
nnoremap <leader>oo ?<<CR>

" Semantics
setlocal iskeyword=@,48-57,_,-,\"

" Navigation
setlocal suffixesadd+=.html,.css,.txt,.js,.ts,.json
