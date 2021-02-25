setlocal omnifunc=lsp#complete
setlocal signcolumn=yes
setlocal number relativenumber
setlocal cursorlineopt+=number
setlocal suffixesadd=.ts,.json,.js

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

function s:try_change_to_project_path(current_file_path)
  let l:filenames = ['tsconfig.json', 'package.json']
  for l:fn in l:filenames
    let l:found_file = findfile(l:fn, a:current_file_path . ';')
    if len(l:found_file)
      exe 'cd' fnameescape(fnamemodify(l:found_file, ':p:h'))
      return
    endif
  endfor
  let node_modules_path = finddir('node_modules', a:current_file_path . ';')
  if len(node_modules_path)
    exe 'cd' fnameescape(fnamemodify(l:node_modules_path, ':p:h'))
  endif
endfunction

augroup format
  autocmd!
  autocmd! BufReadPost,BufEnter *.ts call s:try_change_to_project_path(expand('%:p:h'))
	autocmd! BufWritePre *.ts call execute('LspDocumentFormatSync')
augroup END
