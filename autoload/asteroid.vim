scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim
if exists('s:is_loaded')
    finish
endif
let s:is_loaded = 1
let s:script_dir = expand('<sfile>:p:h')

" autocmd! BufWritePost asteroid.vim source asteroid.vim

py3 << EOF
import ast
import vim
from rich.tree import Tree
EOF

function! asteroid#version()
    py3 print(sys.version)
endfunction

function! asteroid#path()
    echo s:script_dir
endfunction


let &cpoptions = s:save_cpo
unlet s:save_cpo
