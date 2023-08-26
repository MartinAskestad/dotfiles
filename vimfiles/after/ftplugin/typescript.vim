setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldenable foldmethod=manual foldcolumn=1
setlocal number relativenumber
setlocal include=\\%(\\<require\\s*(\\s*\\|\\<import\\>[^;\"']*\\)[*\\)[\"']\\zs[^\"']*
setlocal colorcolumn=80 cursorline

nmap <buffer> w <Plug>CamelCaseMotion_w
nmap <buffer> b <Plug>CamelCaseMotion_b
nmap <buffer> e <Plug>CamelCaseMotion_e
nmap <buffer> ge <Plug>CamelCaseMotion_ge

let b:nerd_icon = '󰛦'
