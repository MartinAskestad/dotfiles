setlocal omnifunc=lsp#complete
setlocal signcolumn=yes
setlocal number relativenumber
setlocal cursorlineopt+=number
setlocal suffixesadd=.ts,.json,.js

if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

let g:lsp_format_sync_timeout = 1000

function s:try_change_to_project_path()
  let l:current_file_path = expand('%:p:h')
  if l:current_file_path[0:2] ==# 'fug'
    return
  endif
  let l:filenames = ['tsconfig.json', 'package.json']
  for l:fn in l:filenames
    let l:found_file = findfile(l:fn, l:current_file_path . ';')
    if len(l:found_file)
      exe 'cd' fnameescape(fnamemodify(l:found_file, ':p:h'))
      return
    endif
  endfor
  let node_modules_path = finddir('node_modules', l:current_file_path . ';')
  if len(node_modules_path)
    exe 'cd' fnameescape(fnamemodify(l:node_modules_path, ':p:h'))
  endif
endfunction

augroup format
  autocmd!
"  autocmd! BufReadPost,BufEnter *.ts call s:try_change_to_project_path(expand('%:p:h'))
  autocmd! BufReadPost,BufEnter *.ts call s:try_change_to_project_path()
	autocmd! BufWritePre *.ts call execute('LspDocumentFormatSync')
augroup END
