import vim

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
    rich.print(tree)

