setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldmethod=manual foldlevel=6 foldcolumn=1
setlocal number relativenumber

setlocal iskeyword=@,48-57,_,-,\"

let b:nerd_icon = ''

" go to the next opening tag below the current line
nnoremap <buffer> <Leader>hj 0/$/;/<[a-zA-Z][a-zA-Z0-9]*\%(\_[^>]*>\)\@=<CR>
" go to next end of closing tag or empty element below current line
nnoremap <buffer> <Leader>hl 0/$/;/\%([^>]*$\)\@=<CR>
" go to the previous opening tag above the current line
nnoremap <buffer> <Leader>hk $?^?;?^[^<]*\zs<\%([a-za-z][a-za-z0-9]*\_[^>]*>\)\@=<CR>
" go to the previous closing tag above the current line
nnoremap <buffer> <Leader>hh $?^?;?>\%([^>]*$\)\@=<CR>
" Go to the next tag element closing
nnoremap <buffer> <Leader>hL /><CR>
" Go to the previous tag element opening
nnoremap <buffer> <Leader>hH ?<<CR>

" operator-pending variants of the above normal mode mappings
onoremap <buffer> ]] /<\%([a-z][a-zA-Z0-9]*\_[^>]*>\)\@=<CR>
onoremap <buffer> ][ />\%([^>]*$\)\@=<CR>
onoremap <buffer> [[ ?^[^<]*\zs<\%([a-za-z][a-za-z0-9]*\_[^>]*>\)\@=<CR>
onoremap <buffer> [] \%([^>]*$\)\@=<CR>
onoremap <buffer> ]} /><CR>
onoremap <buffer> [{ ?<<CR>
