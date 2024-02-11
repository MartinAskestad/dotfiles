if exists('g:gitvim')
  finish
endif
let g:gitvim = 1

function! git#name() abort
  if get(b:, 'git_pwd', '') !=# expand('%:p:h') || !has_key(b:, 'git_path')
    call git#detect(expand('%:p:h'))
  endif
  if has_key(b:, 'git_path') && filereadable(b:git_path)
    let branch = get(readfile(b:git_path), 0, '')
    if branch =~# '^ref: '
      return substitute(branch, '^ref: \%(refs/\%(heads/\|remotes/\|tags/\)\=\)\=', '', '')
    elseif branch =~# '^\x\{20\}'
      return branch[:6]
    endif
  endif
  return ''
endfunction

function! git#dir(path) abort
  let path = a:path
  let prev = ''
  let git_modules = path =~# '/\.git/modules/'
  while path !=# prev
    let dir = path . '/.git'
    let type = getftype(dir)
    if type ==# 'dir' && isdirectory(dir.'/objects') && isdirectory(dir.'/refs') && getfsize(dir.'/HEAD') > 10
      return dir
    elseif type ==# 'file'
      let reldir = get(readfile(dir), 0, '')
      if reldir =~# '^gitdir: '
        return simplify(path . '/' . reldir[8:])
      endif
    elseif git_modules && isdirectory(path.'/objects') && isdirectory(path.'/refs') && getfsize(path.'/HEAD') > 10
      return path
    endif
    let prev = path
    let path = fnamemodify(path, ':h')
  endwhile
  return ''
endfunction

function! git#detect(path) abort
  unlet! b:git_path
  let b:git_pwd = expand('%:p:h')
  let dir = git#dir(a:path)
  if dir !=# ''
    let path = dir . '/HEAD'
    if filereadable(path)
      let b:git_path = path
    endif
  endif
endfunction
