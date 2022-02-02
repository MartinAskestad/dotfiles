setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldmethod=manual foldlevel=10

setlocal iskeyword=@,48-57,_,-,\"

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
command! SwitchToCSS call s:try_switch_file('.css,.scss')

nnoremap <buffer> <Leader>at :SwitchToTS<CR>
nnoremap <buffer> <Leader>as :SwitchToCSS<CR>

" go to the next opening tag below the current line
nnoremap <buffer> <Leader>hj 0/$/;/<[a-zA-Z][a-zA-Z0-9]*\%(\_[^>]*>\)\@=<CR>
" go to next end of closing tag or empty element below current line
nnoremap <buffer> <Leader>hl 0/$/;/\%([^>]*$\)\@=<CR>
" go to the previous opening tag above the current line
nnoremap <buffer> <Leader>hk $?^?;?^[^<]*\zs<\%([a-za-z][a-za-z0-9]*\_[^>]*>\)\@=<CR>
" go to the previous closing tag above the current line
nnoremap <buffer> <Leader>hh $?^?;?>\%([^>]*$\)\@=<CR>
" Go to the next tag element closing
nnoremap <buffer> <Leader>hL /><CR>
" Go to the previous tag element opening
nnoremap <buffer> <Leader>hH ?<<CR>

" operator-pending variants of the above normal mode mappings
onoremap <buffer> ]] /<\%([a-z][a-zA-Z0-9]*\_[^>]*>\)\@=<CR>
onoremap <buffer> ][ />\%([^>]*$\)\@=<CR>
onoremap <buffer> [[ ?^[^<]*\zs<\%([a-za-z][a-za-z0-9]*\_[^>]*>\)\@=<CR>
onoremap <buffer> [] \%([^>]*$\)\@=<CR>
onoremap <buffer> ]} /><CR>
onoremap <buffer> [{ ?<<CR>

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldmethod=marker:
