# asteroid.vim
You can't remember the precedence of operators, can you?
"asteroid.vim" will display it in a tree structure. (WIP)
> Note: It is vaporware!! You should not use it.

## Installation

### For [vim-plug](https://github.com/junegunn/vim-plug)
```vim
" add this line to your _vimrc or init.vim
Plug 'nat-chan/asteroid.vim'
```
### Requirements
```vim
:echo has('python3') "returns 1
```

```bash
sudo apt install python3-pip
/bin/python3 -m pip install --user rich
# The above command will install the library under the user's home directory such as "~/.local/lib/python3.8/site-packages/rich".
# This will prevent problems such as not being able to import the library even when developing across multiple virtual environments.
```
