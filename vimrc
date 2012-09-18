"package manager for VIM
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"look and feel
"syntax enable
"set background=dark
"colorscheme solarized
colorscheme zenburn
set guifont=Monaco:h14

filetype on		" enables filetype detection
filetype plugin on	" enables filetype specific plugins

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"I don't like swap files
set backupdir=~/.vim/backup/
set noswapfile

:set tags=~/mytags	"tags for ctags and taglist
"omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Automatically indent based on file type:
filetype indent on
" Keep indentation level from previous line:
autocmd FileType python set autoindent
" make backspaces more powerfull
"set backspace=indent,eol,start


"Folding based on indentation:
set foldmethod=indent
"use space to open folds
nnoremap <space> za	
"----------Stop python PEP 8 stuff--------------
"

