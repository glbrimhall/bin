" From: https://git-scm.com/book/en/v2/Git-Tools-Submodules
" git clone --recurse-submodules git@github.com:glbrimhall/dot.vim.git

if isdirectory(expand("~/.vim/bundle/Vundle.vim"))
let g:hasVundle=1

" From https://realpython.com/vim-and-python-a-match-made-in-heaven/
" To install plugins, in vi run :PluginInstall or vim +PluginInstall +qall
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Autocomplete
" 1. sudo apt install cmake python3-dev
" 2. Follow https://github.com/ycm-core/YouCompleteMe#installationa
Plugin 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }

" Hilighting
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " Vundle required 

" Autocomplete
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

" From https://github.com/vim-syntastic/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_python_flake8_exec = 'python3'
"let g:syntastic_python_flake8_args = ['-m', 'flake8']
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python3']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

else

filetype plugin indent on    " Vundle required 

endif

"From https://vim.fandom.com/wiki/Automatically_wrap_left_and_right
set whichwrap+=<,>,h,l,[,]
set backspace=indent,eol,start
syntax on

set foldmethod=indent
" set foldnestmax=10
" set nofoldenable
set foldlevel=99

set wrap linebreak nolist
set formatoptions=1

" block edit shortcuts:
" https://stackoverflow.com/questions/9549729/vim-insert-the-same-characters-across-multiple-lines

" make backspaces more powerfull
set backspace=indent,eol,start

" show (partial) command in status line
set showcmd

" auto change to dir of current file
set autochdir

" make extra whitespace
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" default utf-8
set encoding=utf-8

" show ruler
set ruler

"{{{ no_spacevim
if !exists("g:spacevim_windows_leader")

augroup XML
autocmd!
autocmd FileType xml,ui,xhtml,html,xsd let g:xml_syntax_folding=1
"autocmd FileType xml,ui,xhtml,html,xsd setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
autocmd FileType xml,ui,xhtml,html,xsd setlocal foldmethod=syntax
autocmd FileType xml,ui,xhtml,html,xsd :syntax on
"autocmd FileType xml,ui,xhtml,html,xsd normal zR 
"autocmd FileType xml,ui,xhtml,html,xsd :%foldopen!
augroup END

"matchit
"source ~/.SpaceVim.d/plugin/matchit.vim
":helptags ~/.SpaceVim.d/doc

"rebuild help:
":help add-local-help

:filetype plugin on

" Color for dark
":color slate
":color desert

" Color for light 
:color peachpuff 

" Hilighting
let python_highlight_all=1
syntax on

" line numbering
set nu

endif
"}}} no_spacevim

"Escape 
noremap <C-z> <Esc>
inoremap <C-z> <Esc>

"match boundaries
map b %

"fold
nnoremap z  za<Esc>

"file open
noremap F :e .<cr>

"search word
nnoremap t *

"search clear 
nnoremap T :noh<Cr>

"delete line
"nnoremap D d<Esc>

"delete char right
"From https://vim.fandom.com/wiki/Backspace_and_delete_problems
func Backspace()
if col('.') == 1
if line('.')  != 1
return  "\<ESC><Up>$<Del>"
else
return ""
endif
else
return "\<Left>\<Del>"
endif
endfunc

inoremap <C-x> <Esc>lxi
"nnoremap <BS>  i<BS><Esc> 
"nnoremap <BS>   call Backspace(

"delete char left 
inoremap <C-d> <Esc>lXi
nnoremap <BS>  X

"redo
noremap <C-u> <C-r>

"undo
inoremap <C-u> <Esc>ui

"select line
nnoremap v V

"select region
nnoremap V <C-v>

"split screen
nnoremap 2 :sp<cr>

"unsplit screen
nnoremap 1 :on<cr>

"new window
nnoremap 3 :tab split<cr>

"line begin
noremap a 0
inoremap <C-a> <Esc>0i

"line end
noremap e $
inoremap <C-e> <Esc>$i

"paste
nnoremap w P<Esc>
inoremap <C-w> <Esc>lPi

"del line above
nnoremap D :-1d<Cr>

"insert endline 
"nnoremap I $a

"next word
noremap L w<Esc>

"prev word
noremap K b<Esc>

"next line
noremap n <Down>
inoremap <C-n> <Down>

"next search
nnoremap f /<Cr>

"prev search
nnoremap r ?<Cr>

"next page
noremap N <C-f>  

"prev line
noremap p <Up>
noremap j <Up>
inoremap <C-p> <Up>

"prev page
noremap P <C-b>  

"next char 
"          l
inoremap <C-l> <Right>

"prev char
noremap k h
inoremap <C-k> <Left>

" Getting navigation keys to work in file explorer
" From https://vi.stackexchange.com/questions/5531/how-to-remap-i-in-netrw
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> k h
    noremap <buffer> p <Up>h 
    noremap <buffer> n <Down>
endfunction

"move to split above
nnoremap <C-P> <C-W><C-K>

"move to split below
nnoremap <C-N> <C-W><C-J>

"move to split right
nnoremap <C-K> <C-W><C-L>

"move to split left
nnoremap <C-L> <C-W><C-H>

": mode
"nnoremap ; :

"i mode newline:
nnoremap <CR> i<CR><Esc>

" From https://stackoverflow.com/questions/13701506/vim-quick-column-insert
"vnoremap <C-Space> I<Space><Esc>gv
"vnoremap <C-S-Space> A<Space><Esc>gv
set virtualedit=block

"Window switch
noremap b gt 
inoremap <C-b> gt 

"Split Window switch
noremap o <C-w>w 
inoremap <C-o> <C-w>w 

"compile
"autocmd Filetype cpp source ~/.vim/cpp.vim
"autocmd Filetype python source ~/.vim/python.vim

nnoremap 8 :make<Cr>:cw<Cr>
"nnoremap 9 :cn<Cr>
"nnoremap 0 :cp<Cr>
nnoremap 9 :lnext<Cr>
nnoremap 0 :lprev<Cr>
"nnoremap <M-l> :cl<Cr>

"explorer
nnoremap <C-a> :tabnew<Cr>:ex .<Cr>

"let mapleader = ","

" filetype settings:

" python indentation
au BufNewFile,BufRead *.py set 
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ autoindent
    \ smartindent
    \ smarttab
    \ expandtab
    \ fileformat=unix
    \ number

" other code indentation
au BufNewFile,BufRead *.js, *.html, *.css set 
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2
    \ autoindent



