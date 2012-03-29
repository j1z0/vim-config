set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set smartindent
set autoindent
set noswapfile


set hlsearch
set incsearch
set showmatch

filetype on
filetype plugin on
set ofu=syntaxcomplete#Complete
autocmd FileType python set
set tags+=$HOME/.vim/tags/python.ctags

syntax on
set background=dark
colorscheme zenburn
let g:zenburn_force_dark_Background=1
set guifont=Inconsolata:h18
let Tlist_User_Right_Window = 1

nnoremap <F8> :!/opt/local/bin/ctags -R --python-kinds=-i *.py<CR>
nnoremap <F4> :TlistToggle<CR>
inoremap <S-space> <C-x><C-o>
nnoremap <C-f><C-f> :FufFile<CR>
nnoremap <F3> :NERDTreeToggle<CR>


autocmd FileType python set omnifunc=pythoncomplete#Complete | set expandtab
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" Add the virtualenv's site-packages to vim path
"python << EOF
"python << EOF
"import os.path
"import sys
"import vim
"if 'VIRTUAL_ENV' in os.environ:
"     project_base_dir = os.environ['VIRTUAL_ENV']
"     sys.path.insert(0, project_base_dir)
"     activate_this = os.path.join(project_base_dir,
"     'bin/activate_this.py')
"     execfile(activate_this, dict(__file__=activate_this))
"EOF
