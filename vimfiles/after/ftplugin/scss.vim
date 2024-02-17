setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldmethod=manual foldcolumn=1 foldlevel=4
setlocal number relativenumber

setlocal iskeyword+=-

highlight VendorPrefix gui=italic cterm=italic
match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z]\+/

let b:nerd_icon = ''
