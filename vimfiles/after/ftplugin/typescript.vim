setlocal omnifunc=lsp#complete
setlocal signcolumn=yes
setlocal number relativenumber
setlocal cursorlineopt+=number
if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
nnoremap <leader>gd :tab LspDefinition<CR>
nnoremap <leader>gs :LspDocumentSymbolSearch<CR>
nnoremap <leader>gS :LspWorkspaceSymbolSearch<CR>
nnoremap <leader>gr :LspReferences<CR>
nnoremap <leader>rn :LspRename<CR>
nnoremap <F2>       :LspRename<CR>
nnoremap <leader>Gg :LspPreviousDiagnostic<CR>
nnoremap <leader>GG :LspNextDiagnostic<CR>
nnoremap <leader>k  :LspHover<CR>
nnoremap <leader>.  :LspCodeAction<CR>

let g:lsp_format_sync_timeout = 1000

augroup format
  autocmd!
	autocmd! BufWritePre *.ts call execute('LspDocumentFormatSync')
augroup END
