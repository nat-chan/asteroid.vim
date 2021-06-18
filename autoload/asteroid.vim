scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim
if exists('s:is_loaded')
    finish
endif
let s:is_loaded = 1
let s:script_dir = expand('<sfile>:p:h')

" autocmd! BufWritePost asteroid.vim source asteroid.vim
" TODO plugin/asteroid.vimで関数ができ次第こちらに移す

let &cpoptions = s:save_cpo
unlet s:save_cpo
