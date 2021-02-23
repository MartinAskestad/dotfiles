setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal number relativenumber
setlocal omnifunc=lsp#complete

nnoremap <buffer> <leader>lh  :LspHover<CR>
nnoremap <buffer> <leader>l.  :LspCodeAction<CR>
nnoremap <buffer> <leader>lrn :LspRename<CR>
nnoremap <buffer> <F2>       :LspRename<CR>
