setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal number relativenumber
setlocal omnifunc=lsp#complete

if !exists('g:autochdir_project')
  let g:autochdir_project = 0
endif

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
  autocmd! BufReadPost,BufEnter *.scss call s:try_change_to_project_path()
	autocmd! BufWritePre *.scss Prettier
augroup END
