function! s:find_plugin_pack_path() abort
  let l:vimdirname = has("win32") ? "vimfiles" : ".vim"
  let l:home = expand("$HOME/" . l:vimdirname)
  let l:doc_dirs = split( globpath(l:home, "pack/**/doc"), "\n")
  for l:doc_dir in l:doc_dirs
    execute "helptags " . fnameescape(l:doc_dir)
  endfor
endfunction

command! UpdateHelpTags call s:find_plugin_pack_path()
