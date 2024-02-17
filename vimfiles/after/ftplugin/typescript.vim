setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldenable foldmethod=syntax foldcolumn=1 foldlevel=4
setlocal number relativenumber
setlocal include=\\%(\\<require\\s*(\\s*\\|\\<import\\>[^;\"']*\\)[*\\)[\"']\\zs[^\"']*
setlocal colorcolumn=80

let b:nerd_icon = '󰛦'
