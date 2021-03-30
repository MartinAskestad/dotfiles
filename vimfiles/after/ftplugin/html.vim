setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal number relativenumber
setlocal omnifunc=lsp#complete

if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

if !exists("g:which_key_map['h']")
  let g:which_key_map['h'] = {
  \ 'name': 'html',
  \ 'j': 'Next opening tag',
  \ 'jj': 'Next closing tag',
  \ 'k': 'Previous closing tag',
  \ 'kk': 'Previous opening tag',
  \ 'l': 'Next element closing',
  \ 'h': 'Previous element opening',
  \ 'e': 'Emmet: expand abbreviation',
  \ 'E': 'Emmet: expand word',
  \ 'r': 'Emmet remove tag',
  \ 'n': 'Emmet: next insert point',
  \ 'N': 'Emmet: previous insert point',
  \ }
endif

" go to the next opening tag below current line
nnoremap  <leader>hj 0/$/;/<[a-zA-Z][a-zA-Z0-9]*\%(\_[^>]*>\)\@=<CR>:nohlsearch<CR>

" go  to the next end of closing tag or empty elenent below current line
nnoremap  <leader>hjj 0/$/;/\%([^>]*$\)\@=<CR>:nohlsearch<CR>

" go to the previous closing tab above the current line
nnoremap  <leader>hk $?^?;?>\%([^>]*$\)\@=<CR>:nohlsearch<CR>

" go to the previous opening tab above the current line
nnoremap  <leader>hkk $?^?;?^[^z]*\zs<\%([a-zA-Z][a-zA-Z0-9]*\_[^>]*>\)\@=<CR>:nohlsearch<CR>

" go to the next tag element closing
nnoremap  <leader>hl /><CR>:nohlsearch<CR>

" go to the previous tag element opening
nnoremap  <leader>hh ?<<CR>:nohlsearch<CR>

" Map emmet to leader keys
nnoremap <leader>he :call emmet#expandAbbr(3, "")<CR>
nnoremap <leader>hE :call emmet#expandAbbr(1, "")<CR>
vnoremap <leader>he :call emmet#expandAbbr(2, "")<CR>
nnoremap <leader>hn :call emmet#nextPrev(0)<CR>
nnoremap <leader>hN :call emmet#nextPrev(1)<CR>
nnoremap <leader>hr :call emmet#removeTag()<CR>
nnoremap <leader>hu :call emmet#updateTag()<CR>

" Semantics
setlocal iskeyword=@,48-57,_,-,\"

" Navigation
setlocal suffixesadd+=.html,.css,.txt,.js,.ts,.json

" Add emmet plugin
packadd emmet-vim

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

augroup html_groups
  autocmd!
  autocmd! BufReadPost,BufEnter *.html,*.htm call s:try_change_to_project_path()
augroup END
