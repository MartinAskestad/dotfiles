setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldmethod=syntax foldlevel=3

let test#javascript#ava#executable = 'node_modules\.bin\ava'
let test#javascript#ava#file_pattern = '\.test\.ts'

setlocal include=\\%(\\<require\\s*(\\s*\\\|\\<import\\>[^;\"']*\\)[\"']\\zs[^\"']*

let s:save_cpo = &cpo
set cpo&vim

let b:textobj_function_select = function('textobj#function#javascript#select')

if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= ' | '
else
  let b:undo_ftplugin = ''
endif
let b:undo_ftplugin .= 'unlet! b:textobj_function_select'

let &cpo = s:save_cpo
unlet s:save_cpo

function s:try_switch_file(extension)
  let l:current_buffer_without_extension = expand('%:p:r')
  let l:current_buffer_path = expand('%:p:h')
  execute 'setlocal suffixesadd=' . a:extension
  let l:found_file = findfile(l:current_buffer_without_extension, expand('%:p:h'))
  if len(l:found_file)
    let l:bnr = bufwinnr(l:found_file)
    if l:bnr > 0
      execute l:bnr . 'wincmd w'
    else
      execute 'e ' . fnameescape(l:found_file)
    endif
  else " no file found, search in file instead
    if a:extension == '.html'
      :execute "normal! gg" . '/template' . "\<CR>"
    else
      :execute "normal! gg" . '/styles' . "\<CR>"
    endif
  endif
endfunction

command! SwitchToHTML call s:try_switch_file('.html')
command! SwitchToCSS  call s:try_switch_file('.css,.scss')

nnoremap <buffer> <Leader>ah :SwitchToHTML<CR>
nnoremap <buffer> <Leader>as :SwitchToCSS<CR>

inoremap <buffer><expr> " strpart(getline('.'), col('.') - 1, 1) == '"'
      \ ? "\<Right>" : "\"\"\<Left>"
inoremap <buffer><expr> ' strpart(getline('.'), col('.') - 1, 1) == "'"
      \ ? "\<Right>" : "''\<Left>"
inoremap <buffer><expr> ` strpart(getline('.'), col('.') - 1, 1) == "`"
      \ ? "\<Right>" : "``\<Left>"
inoremap <buffer> ( ()<Left>
inoremap <buffer> [ []<Left>
inoremap <buffer> { {}<Left>
inoremap <buffer> {<CR> {<CR>}<ESC>O
inoremap <buffer> {;<CR> {<CR>};<ESC>O
inoremap <buffer><expr> ) strpart(getline('.'), col('.') - 1, 1) == ")" ? "\<Right>" : ")"
inoremap <buffer><expr> ] strpart(getline('.'), col('.') - 1, 1) == "]" ? "\<Right>" : "]"
inoremap <buffer><expr> } strpart(getline('.'), col('.') - 1, 1) == "}" ? "\<Right>" : "}"

let empty_pairs = ["()", "[]", "{}", "''", "``", '""']

inoremap <buffer><expr> <BS> index(empty_pairs, strpart(getline('.'), col('.') - 2, 2)) > -1 ? "\<Right><BS><BS>" : "\<BS>"

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldmethod=marker:
