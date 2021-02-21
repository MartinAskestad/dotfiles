setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal number relativenumber
setlocal omnifunc=lsp#complete

nnoremap <leader>k  :LspHover<CR>
nnoremap <leader>.  :LspCodeAction<CR>
nnoremap <leader>rn :LspRename<CR>
nnoremap <F2>       :LspRename<CR>
