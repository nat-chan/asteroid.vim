scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim
"if exists('s:is_loaded')
"    finish
"endif
"let s:is_loaded = 1

" autocmd! BufWritePost asteroid.vim source asteroid.vim

" TODO
" execute 'py3 ' . s:sourcecode
" readfile
py3 << EOF
import ast
import _ast
import rich
from rich.tree import Tree

from io import StringIO

import vim

# python function
def r(source):
    return ast.parse(source).body[0].value

def shave(node):
    return str(node).replace('.', ' ').split()[1]

def name(node):
    if hasattr(node, 'id'):
        return node.id
    if hasattr(node, 'n'):
        return str(node.n)
    if hasattr(node, 'op'):
        return shave(node.op)
    if hasattr(node, 'ops'):
         # TODO multiple elements
        return shave(node.ops[0])
    return shave(node)

def children(node):
#    if hasattr(node, 'left') and hasattr(node, 'right'):
    if type(node) == _ast.BinOp:
        return [node.left, node.right]
#    if hasattr(node, 'left') and hasattr(node, 'comparators'):
    if type(node) == _ast.Compare:
        return [node.left]+node.comparators
    if type(node) == _ast.Subscript:
        return [node.value, node.slice]
    if (hasattr(node, 'lower') and
        hasattr(node, 'upper') and
        hasattr(node, 'step')):
        lower = node.lower
        if lower == None:
            lower = _ast.Num(0)
        upper = node.upper
        if upper == None:
            upper = _ast.Num(float("inf"))
        step = node.step
        if step == None:
            step = _ast.Num(1)
        return [lower, upper, step]
    return []

def rec(node):
    g = Tree(name(node))
    for child in children(node):
        g.add(rec(child))
    return g

# vim function
def selected():
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
    return txt

def show():
    lines = selected()
    assert len(lines) == 1
    line = lines.pop()
    tree = rec(r(line))
    #print('\n'.join(map(str, range(10))))
    stringio = StringIO()
    rich.print(tree, file=stringio)
    txt = stringio.getvalue()
    for line in txt.split('\n'):
            print(line)
    #print(txt)

EOF

function! asteroid#selected()
    py3 print(selected())
endfunction

function! asteroid#show()
    py3 show()
endfunction

function! asteroid#version()
    py3 print(sys.version)
endfunction

function! asteroid#path()
    echo s:script_dir
endfunction

command! -range AstSelected call asteroid#selected()
command! -range AstShow call asteroid#show()
command! AstVersion call asteroid#version()
command! AstPath call asteroid#path()


let &cpoptions = s:save_cpo
unlet s:save_cpo
