if exists('g:ctrlp_git_branches_loaded')
  finish
endif
let g:ctrlp_git_branches_loaded = 1

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#git_branches#init()',
  \ 'accept': 'ctrlp#git_branches#accept',
  \ 'lname': 'Git branches',
  \ 'sname': 'branches',
  \ 'type': 'line',
  \ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function ctrlp#git_branches#id() abort
  return s:id
endfunction

function! ctrlp#git_branches#init() abort
  let l:is_git_repo = finddir(".git", ";") != '' ? 1 : 0
  if !l:is_git_repo
    echoerr "not a git repo"
    return []
  endif
  let l:git_branches = system('git for-each-ref --format="%(refname:short)" refs/heads/')
  let l:branches = split(l:git_branches, "\n")
  let l:branches = l:branches + ['[Create new branch]']
  return l:branches
endfunction

function! ctrlp#git_branches#accept(mode, branch) abort
  call ctrlp#exit()
  if a:branch ==# "[Create new branch]"
    let l:new_branch_name = inputdialog("Branch name: ")
    if len(l:new_branch_name)
      call system("git checkout -b " . l:new_branch_name)
      return
    endif
  endif
  call system("git checkout " . a:branch)
endfunction
