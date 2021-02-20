setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal number relativenumber

" go to the next opening tag below current line
nmap <buffer> <leader>o 0/$/;/<[a-zA-Z][a-zA-Z0-9]*\%(\_[^>]*>\)\@=<CR>

" go  to the next end of closing tag or empty elenent below current line
nmap <buffer> <leader>c 0/$/;/\%([^>]*$\)\@=<CR>

" go to the previous closing tab above the current line
nmap <buffer> <leader>C $?^?;?>\%([^>]*$\)\@=<CR>

" go to the previous opening tab above the current line
nmap <buffer> <leader>O $?^?;?^[^z]*\zs<\%([a-zA-Z][a-zA-Z0-9]*\_[^>]*>\)\@=<CR>

" go to the next tag element closing
nmap <buffer> <leader>cc /><CR>

" go to the previous tag element opening
nmap <buffer> <leader>oo ?<<CR>

" Semantics
setlocal iskeyword=@,48-57,_,-,\"

" Navigation
setlocal suffixesadd+=.html,.css,.txt,.js,.ts,.json
