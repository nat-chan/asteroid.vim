scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim
let s:script_dir = expand('<sfile>:p:h')
"if exists('s:is_loaded')
"    finish
"endif
"let s:is_loaded = 1

" autocmd! BufWritePost asteroid.vim source asteroid.vim

py3file <sfile>:h:h/python3/asteroid.py
py3file <sfile>:h:h/python3/vim_settings.py

function! asteroid#selected()
    py3 print(selected())
endfunction

function! asteroid#show()
    py3 show()
endfunction

function! asteroid#version()
    py3 print(sys.version, sys.prefix)
endfunction

function! asteroid#path()
    echo fnamemodify("<sfile>", ":p:h:h") . "/python3/asteroid.py"
endfunction

function! asteroid#exe()
    let l:txt = ""
    for l:line in readfile(expand("%"))
        let l:txt .= l:line . "\n"
    endfor
    echo l:txt
endfunction

command! -range AstSelected call asteroid#selected()
command! -range AstShow call asteroid#show()
command! AstVersion call asteroid#version()
command! AstPath call asteroid#path()
command! AstExe call asteroid#exe()


let &cpoptions = s:save_cpo
unlet s:save_cpo
