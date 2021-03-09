if exists('g:ctrlp_branch_loaded')
  finish
endif
let g:ctrlp_branch_loaded = 1

call add(g:ctrlp_ext_vars, {
  \ 'init': 'branch#init()',
  \ 'accept': 'branch#accept',
  \ 'lname': 'Branches',
  \ 'sname': 'branches',
  \ 'type': 'line',
  \ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! branch#id() abort
  return s:id
endfunction

function! branch#init() abort
  if !s:is_git_repo()
    echoerr "not a git repo"
    return []
  endif
  let git_result = system("git for-each-ref --format='%(refname:short)' refs/heads/")
  let branches = split(git_result, '\n')
  return branches
endfunction

function! branch#accept(mode, str) abort
  call system('git checkout ' . a:str)
  call ctrlp#exit()
endfunction

function! s:is_git_repo(...)
  let path = a:0 > 0 ? a:1 : getcwd()
  return finddir('.git', fnameescape(path)) != '' ? 1 : 0
endfunction

command! Branch call ctrlp#init(branch#id())

