setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldmethod=syntax foldlevel=10

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

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldmethod=marker:
