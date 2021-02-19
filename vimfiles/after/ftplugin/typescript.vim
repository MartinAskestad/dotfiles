setlocal omnifunc=lsp#complete
setlocal signcolumn=yes
setlocal number relativenumber
if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
nmap <buffer> gd <plug>(lsp-definition)
nmap <buffer> gs <plug>(lsp-document-symbol-search)
nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
nmap <buffer> gr <plug>(lsp-references)
nmap <buffer> gi <plug>(lsp-implementations)
nmap <buffer> gt <plug>(lsp-type-definition)
nmap <buffer> <leader>rn <plug>(lsp-rename)
nmap <buffer> Gg <plug>(lsp-previous-diagnostic)
nmap <buffer> GG <plug>(lsp-next-diagnostic)
nmap <buffer> K <plug>(lsp-hover)
nmap <buffer> <leader>a <plug>(lsp-code-action)

let g:lsp_format_sync_timeout = 1000

augroup numbertoggle
	autocmd!
	autocmd! BufWritePre *.ts call execute('LspDocumentFormatSync')
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter *.ts if &nu && mode() != "i" | set rnu    | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   *.ts if &nu                  | set nornu  | endif
augroup END
