if exists('g:myvimrc')
  finish
endif
let g:myvimrc = 1

function! vimrc#swap_win_buf() abort
  let l:this_win = winnr()
  let l:this_buf = bufnr('%')
  let l:last_win = winnr('#')
  let l:last_buf = winbufnr(l:last_win)
  execute l:last_win . ' wincmd w' . '|' . 'buffer ' . l:this_buf . '|' . l:this_win . ' wincmd w' . '|' . 'buffer ' . l:last_buf
endfunction

function! vimrc#CamelCaseCallback() abort
  echom "camel case"
  " nmap <buffer> w <Plug>CamelCaseMotion_w
  " nmap <buffer> b <Plug>CamelCaseMotion_b
  " nmap <buffer> e <Plug>CamelCaseMotion_e
  " nmap <buffer> ge <Plug>CamelCaseMotion_ge
  " sunmap <buffer> w
  " sunmap <buffer> b
  " sunmap <buffer> e
  " sunmap <buffer> ge
endfunction

function! CompleteBuffers(arg, cmd, cur) abort
  let l:buffers = map(filter(range(1, bufnr('$')), { i, nr -> buflisted(nr) && bufexists(nr) } ), { i, nr -> bufname(nr) } )
  if empty(a:arg)
    return l:buffers
  else
    return matchfuzzy(l:buffers, a:arg)
  endif
endfunction

function! vimrc#find_buffer() abort
  let l:search = input('buffers: ', '', 'customlist,CompleteBuffers')
  if empty(l:search)
    return
  endif
  let l:bnr = bufwinnr(l:search)
  if l:bnr >= 0
    execute l:bnr . 'wincmd w'
  else
    execute 'b '. l:search
  endif
endfunction

function! CompleteFiles(arg, cmd, cur) abort
  let l:fd_cmd = 'fd -t f'
  let l:files = systemlist(l:fd_cmd)
  if empty(a:arg)
    return l:files
  else
    return matchfuzzy(l:files, a:arg)
  endif
endfunction

function! vimrc#find_file() abort
  let l:search = input('files: ', '', 'customlist,CompleteFiles')
  if empty(l:search)
    return
  endif
  execute 'e ' . l:search
endfunction

function!CompleteNpm(arg, cmd, cur) abort
  let l:package_json = json_decode(join(readfile(b:package_json_path)))
  let l:scripts = get(l:package_json, 'scripts', [])
  if empty(a:arg)
    return keys(l:scripts)
  endif
  return matchfuzzy(keys(l:scripts), a:arg)
endfunction

function!vimrc#find_npm_script() abort
  let b:package_json_path = findfile('package.json', '.;')
  if empty(b:package_json_path)
    return
  endif
  let l:search  = input('npm: ', '', 'customlist,CompleteNpm')
  if !empty(l:search)
    let l:package_json = json_decode(join(readfile(b:package_json_path)))
    let l:npm_script = get(get(l:package_json, 'scripts', {}), l:search, '')
    if !empty(l:npm_script)
      let l:npm_script = "!start cmd /c " . l:npm_script
      silent exe l:npm_script
    endif
  endif
  unlet! b:package_json_path
endfunction

