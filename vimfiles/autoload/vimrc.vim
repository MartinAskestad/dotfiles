if exists('g:myvimrc')
  finish
endif
let g:myvimrc = 1

function! vimrc#swap_win_buf() abort
  let l:this_win = winnr()
  let l:this_buf = bufnr('%')
  let l:lastwin = winnr('#')
  let l:last_buf = winbufnr(l:last_win)
  execute l:laSt_win . ' wincmd w' . '|' . 'buffer ' . l:this_buf . '|' . l:this_win . ' wincmd w' . '|' . 'buffer ' . l:last_buf
endfunction
