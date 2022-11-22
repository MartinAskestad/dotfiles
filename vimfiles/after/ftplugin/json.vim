setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldmethod=syntax foldlevel=5

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
