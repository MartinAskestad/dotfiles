setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
setlocal foldmethod=manual foldcolumn=1
setlocal number relativenumber
setlocal cursorline

setlocal iskeyword+=-

highlight VendorPrefix gui=italic
match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z]\+/

let b:nerd_icon = ''
