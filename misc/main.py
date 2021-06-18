#!/usr/bin/env python3
import ast
import _ast
from rich.tree import Tree

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
    if type(root) == _ast.BinOp:
        return [node.left, node.right]
#    if hasattr(node, 'left') and hasattr(node, 'comparators'):
    if type(root) == _ast.Compare:
        return [node.left]+node.comparators
    if type(root) == _ast.Subscript
        return [root.value, root.slice]
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




