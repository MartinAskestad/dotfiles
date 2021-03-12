if exists('g:ctrlp_npm_script_loaded')
  finish
endif
let g:ctrlp_npm_script_loaded = 1

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#npm_script#init()',
  \ 'accept': 'ctrlp#npm_script#accept',
  \ 'lname': 'NPM-Scripts',
  \ 'sname': 'npmscripts',
  \ 'type': 'line',
  \ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#npm_script#id() abort
  return s:id
endfunction

function! ctrlp#npm_script#init() abort
  let l:package_json = findfile('package.json', ';')
  if !len(l:package_json)
    echoerr "package.json not found"
    return []
  endif
  let l:json = join(readfile(l:package_json), "")
  let l:parsed_json = json_decode(l:json)
  if has_key(l:parsed_json, 'scripts')
    return keys(l:parsed_json['scripts'])
  endif
  return []
endfunction

function! ctrlp#npm_script#accept(mode, script) abort
  call ctrlp#exit()
  let l:package_json = findfile('package.json', ';')
  if !len(l:package_json)
    echoerr "package.json not found"
    return
  endif
  let l:json = join(readfile(l:package_json), "")
  let l:parsed_json = json_decode(l:json)
  let l:script = get(l:parsed_json['scripts'], a:script)
  execute "terminal npm run " . l:script
endfunction

