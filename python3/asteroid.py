import ast
import _ast
import rich
from rich.tree import Tree

# TODO 要検証、式でなく文は.valueいらない
STATEMENTS = {
    _ast.FunctionDef,
    _ast.Assign,
}

def r(source):
    # TODO bodyが複数あるケースへの対応
    root = ast.parse(source).body[0]
    if type(root) in STATEMENTS:
        return root
    else:
        return root.value

def shave(node):
    return str(node).replace('.', ' ').split()[1]

def name(node):
    if type(node) == _ast.FunctionDef:
        return f"FunctionDef {node.name}"
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
    # slice [lower:upper:step]
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
    # slice [index]
    if type(node) == _ast.Index:
        return [node.value]
    if type(node) == _ast.Assign:
        return node.targets + [node.value]
    if type(node) == _ast.Tuple:
        return node.elts
    if type(node) == _ast.FunctionDef: # TODO FunctionDefが完全でない
        return [node.args, node.body]
    if type(node) == _ast.arguments:
        return node.args # TODO kwargs, kw_defaults, kwonlyargs, vararg
    return []

def rec(node):
    g = Tree(name(node))
    for child in children(node):
        g.add(rec(child))
    return g
