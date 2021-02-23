setlocal omnifunc=lsp#complete
setlocal signcolumn=yes
setlocal number relativenumber
setlocal cursorlineopt+=number

if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
nnoremap <buffer> <leader>ld :tab LspDefinition<CR>
nnoremap <buffer> <leader>ls :LspDocumentSymbolSearch<CR>
nnoremap <buffer> <leader>lS :LspWorkspaceSymbolSearch<CR>
nnoremap <buffer> <leader>lr :LspReferences<CR>
nnoremap <buffer> <leader>lrn :LspRename<CR>
nnoremap <buffer> <F2>       :LspRename<CR>
nnoremap <buffer> <leader>lg :LspPreviousDiagnostic<CR>
nnoremap <buffer> <leader>lG :LspNextDiagnostic<CR>
nnoremap <buffer> <leader>lh  :LspHover<CR>
nnoremap <buffer> <leader>l.  :LspCodeAction<CR>

let g:lsp_format_sync_timeout = 1000

augroup format
  autocmd!
	autocmd! BufWritePre *.ts call execute('LspDocumentFormatSync')
augroup END
