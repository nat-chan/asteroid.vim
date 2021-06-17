scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim
if exists('s:is_loaded')
    finish
endif
let s:is_loaded = 1

function! asteroid#test()
py3 << EOF
import vim
buf = vim.current.buffer
l1, c1 = buf.mark('<')
l2, c2 = buf.mark('>')
txt = list()
for i in range(l1-1, l2):
    s = 0
    e = 2147483647
    if i == l1-1:
        s = c1
    if i == l2-1:
        e = c2
    txt.append(buf[i][s:e+1])
print(txt)
EOF
endfunction

command! -range Ast call asteroid#test()

command! AsteroidVersion call asteroid#version()

let &cpoptions = s:save_cpo
unlet s:save_cpo
