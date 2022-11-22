setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldmethod=syntax foldlevel=10

setlocal iskeyword+=-

:highlight VendorPrefix gui=bold
:match VendorPrefix /-\(moz\|webkit\|o\ms\)-[a-zA-Z]\+/

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
  endif
endfunction

command! SwitchToTS call s:try_switch_file('.ts')
command! SwitchToHTML call s:try_switch_file('.html')

nnoremap <buffer> <Leader>at :SwitchToTS<CR>
nnoremap <buffer> <Leader>ah :SwitchToHTML<CR>

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

if !exists('g:loaded_textobj_css')
  packadd vim-textobj-css
endif

packadd vim-prettier
let g:prettier#autoformat_config_present=1
let g:prettier#quickfix_auto_focus=0

augroup css
  au!
  au BufWritePre,TextChanged,InsertLeave *.css Prettier
augroup END

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldmethod=marker:
