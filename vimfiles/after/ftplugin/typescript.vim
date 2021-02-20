setlocal omnifunc=lsp#complete
setlocal signcolumn=yes
setlocal number relativenumber
setlocal cursorlineopt+=number
if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
nnoremap <buffer> gd :tab LspDefinition<CR>
nmap <buffer> gs <plug>(lsp-document-symbol-search)
nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
nmap <buffer> gr <plug>(lsp-references)
nmap <buffer> gi <plug>(lsp-implementations)
nmap <buffer> gt <plug>(lsp-type-definition)
nmap <buffer> <leader>rn <plug>(lsp-rename)
nmap <buffer> <F2> <plug>(lsp-rename)
nmap <buffer> Gg <plug>(lsp-previous-diagnostic)
nmap <buffer> GG <plug>(lsp-next-diagnostic)
nmap <buffer> K <plug>(lsp-hover)
nmap <buffer> <leader>a <plug>(lsp-code-action)

let g:lsp_format_sync_timeout = 1000

augroup format
  autocmd!
	autocmd! BufWritePre *.ts call execute('LspDocumentFormatSync')
augroup END
