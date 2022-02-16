if get(g:,'wildmenu_plus', 0) == 1
  finish
endif

let g:wildmenu_plus = 1

let g:wildmenu_file_cmd = get(g:, 'wildmenu_file_cmd', 'fd -t f ')

command! WildmenuBuffers call s:buffer_switch()
command! WildmenuFiles call s:find_file()

function! s:buffer_switch() abort
  let l:search = input('buffers: ', '', 'customlist,Complete_buffers')
  if empty(l:search)
    return
  endif
  let l:bnr = bufwinnr(l:search)
  if l:bnr >= 0
    execute l:bnr . 'wincmd w'
  else 
    execute 'b ' . l:search
  endif
endfunction

function! Complete_buffers(arg, cmd, cur) abort
  let l:buf_search_expr = '\c\V' . a:arg
  let l:buffers = filter(map(
        \filter(range(1, bufnr('$')),
        \"buflisted(v:val) && bufexists(v:val)"),
        \"bufname(v:val)"),
        \"match(v:val, l:buf_search_expr) >= 0")
  return l:buffers
endfunction

function! s:find_file() abort
  let l:file = input('files: ', '', 'customlist,Complete_files')
  if !empty(l:file)
    execute 'e ' . l:file
  endif
  endfunction

function! Complete_files(arg, cmd, cur) abort
  let l:fd_cmd = g:wildmenu_file_cmd . a:arg
  let l:files = systemlist(l:fd_cmd)
  return l:files
endfunction

let g:wildmenu_session_dir = get(g:, 'wildmenu_session_dir', $HOME . '\vimfiles\sessions')
command! WildmenuSessions call s:load_sessions()

function! s:load_sessions() abort
  let l:session = input('sessions: ', '', 'customlist,Complete_sessions')
  if !empty(l:session)
    let l:session = g:wildmenu_session_dir . '/' . l:session
    execute "source " . l:session
  endif
endfunction

function! Complete_sessions(arg, cmd, cur) abort
  let l:arg = a:arg == '' ? '.' : a:arg
  let l:fd_cmd = 'fd ' . l:arg . ' ' . g:wildmenu_session_dir
  let l:session_files = map(systemlist(l:fd_cmd),
        \ "fnamemodify(v:val, ':t')")
 return l:session_files
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldmethod=marker
