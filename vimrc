"vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
"git interface
Bundle 'tpope/vim-fugitive'
"filesystem
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'kien/ctrlp.vim' 

"html
"Bundle 'isnowfy/python-vim-instant-markdown'
Bundle 'jtratner/vim-flavored-markdown'
Bundle 'suan/vim-instant-markdown'
Bundle 'nelstrom/vim-markdown-preview'
"python sytax checker
Bundle 'nvie/vim-flake8'
"Bundle 'vim-scripts/Pydiction'
Bundle 'vim-scripts/indentpython.vim'
Bundle 'scrooloose/syntastic'
"color
Bundle 'altercation/vim-colors-solarized'
"auto-completion stuff
"Bundle 'klen/python-mode'
Bundle 'Valloric/YouCompleteMe'
"Bundle 'klen/rope-vim'
"Bundle 'davidhalter/jedi-vim'
"Bundle 'ervandew/supertab'
"code folding
Bundle 'tmhedberg/SimpylFold'

"Colors!!!
Bundle 'altercation/vim-colors-solarized'
Bundle 'jnurmine/Zenburn'

filetype plugin indent on		" enables filetype detection
let g:SimpylFold_docstring_preview = 1

"autocomplete
let g:ycm_autoclose_preview_window_after_completion=1

"custom keys
let mapleader=" "
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"look and feel
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme Zenburn
endif

call togglebg#map("<F5>")
"colorscheme zenburn
"set guifont=Monaco:h14

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree


"I don't like swap files
set backupdir=~/dotfiles/vim/backup/
set noswapfile

"turn on numbering
set nu

"python with virtualenv support
py << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	sys.path.insert(0, project_base_dir)
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

"it would be nice to set tag files by the active virtualenv here
":set tags=~/mytags	"tags for ctags and taglist
"omnicomplete
"autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
"au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
"au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
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

" Keep indentation level from previous line:
autocmd FileType python set autoindent

" make backspaces more powerfull
set backspace=indent,eol,start


"Folding based on indentation:
"autocmd FileType python set foldmethod=indent
"use space to open folds
nnoremap <space> za	
"----------Stop python PEP 8 stuff--------------

"js stuff"
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

