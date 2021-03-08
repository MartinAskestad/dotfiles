setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal number relativenumber
setlocal omnifunc=lsp#complete

if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

" go to the next opening tag below current line
nnoremap <buffer> <leader>hj 0/$/;/<[a-zA-Z][a-zA-Z0-9]*\%(\_[^>]*>\)\@=<CR>

" go  to the next end of closing tag or empty elenent below current line
nnoremap <buffer> <leader>hjj 0/$/;/\%([^>]*$\)\@=<CR>

" go to the previous closing tab above the current line
nnoremap <buffer> <leader>hk $?^?;?>\%([^>]*$\)\@=<CR>

" go to the previous opening tab above the current line
nnoremap <buffer> <leader>hkk $?^?;?^[^z]*\zs<\%([a-zA-Z][a-zA-Z0-9]*\_[^>]*>\)\@=<CR>

" go to the next tag element closing
nnoremap <buffer> <leader>hl /><CR>

" go to the previous tag element opening
nnoremap <buffer> <leader>hh ?<<CR>

" Semantics
setlocal iskeyword=@,48-57,_,-,\"

" Navigation
setlocal suffixesadd+=.html,.css,.txt,.js,.ts,.json

" Add emmet plugin
packadd emmet-vim

if !exists('g:autochdir_project')
  let g:autochdir_project = 0
endif

function s:try_change_to_project_path(current_file_path)
  if g:autochdir_project
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
  endif
endfunction

augroup html_groups
  autocmd!
  autocmd! BufReadPost,BufEnter *.html,*.htm call s:try_change_to_project_path(expand('%:p:h'))
augroup END
