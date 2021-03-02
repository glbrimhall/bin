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

"From https://stackoverflow.com/questions/2355834/how-can-i-autoformat-indent-c-code-in-vim
"cleanup tab spacing
nnoremap Z gg=G

"match boundaries
map b %

"fold
nnoremap z  za<Esc>

"file open
noremap F :tab split<cr>:e .<cr>

"delete line  well,
"nnoremap D d<Esc>

"delete char right
nnoremap x  "_x
inoremap <C-x> <Esc>l"_xi

"delete char left
inoremap <C-d> <Esc>l"_Xi
nnoremap <BS>  "_X

"paste
nnoremap w P<Esc>
inoremap <C-w> <Esc>lPi

"set clipboard=unnamedplus
"set clipboard=unnamed

"del line above
nnoremap D :-1d<Cr>

"<space> insert
nnoremap <space> i<space><Right><Esc>

"redo
noremap <C-u> <C-r>

"undo
inoremap <C-u> <Esc>ui

"select line
nnoremap v V

"select region
nnoremap V <C-v>

"split window
nnoremap 2 :sp<cr>

"unsplit window 
nnoremap 1 :on<cr>

"new window
nnoremap 3 :tab split<cr>

"Window switch
noremap t gt 
inoremap <C-t> gt 

"Split Window switch
noremap o <C-w>w 
inoremap <C-o> <C-w>w 

"line begin
noremap a 0
inoremap <C-a> <Esc>0i

"line end
noremap e $
inoremap <C-e> <Esc>$i

"insert endline
nnoremap E $i<Right>

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

"search clear
nnoremap T :noh<Cr>

" search & replace
nnoremap s *:%s//

"next page
noremap N <C-f>

"prev line
noremap p <Up>
noremap j <Up>
inoremap <C-p> <Up>

"prev page
nnoremap P <C-b>

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

"escape 
noremap A <Esc>
inoremap <C-A> <Esc>

" From https://stackoverflow.com/questions/13701506/vim-quick-column-insert
"vnoremap <C-Space> I<Space><Esc>gv
"vnoremap <C-S-Space> A<Space><Esc>gv
set virtualedit=block

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

function! LangIndentSettings(indent=4,cols=79,fold="syntax")
    "let l:tablen=str2nr(a:indent, 10) 
    "let l:tablen=0+a:indent 
    let tabstop=a:indent
    let &softtabstop=a:indent     
    let &shiftwidth=a:indent     
    let &textwidth=a:cols
    set autoindent
    set smartindent
    set smarttab
    set expandtab
    set fileformat=unix
    let &foldmethod=a:fold
    "set foldmethod=indent
    "set foldnestmax=10
    "set nofoldenable
    set foldlevel=99
endfunction

function! CLangIndentSettings()
    call LangIndentSettings(3)
    set cino={1s}s 
endfunction

augroup LangIndentGroup 
    autocmd!
"    BufNewFile,BufRead *.py call LangIndentSettings() 
    au FileType python call LangIndentSettings(4,79,"indent")
    au FileType vimrc call LangIndentSettings(4)
    au FileType cpp call CLangIndentSettings()
    au BufNewFile,BufRead *.html,*.css call LangIndentSettings(2) 
    au BufNewFile,BufRead *.js,*.xml,*.jsr call LangIndentSettings(3) 
augroup END

"From https://www.reddit.com/r/vim/comments/bzbv98/detect_whether_caps_locks_is_on/
function! Cap_Status()
    let St = systemlist('xset -q | grep "Caps Lock" | awk ''{print $4}''')[0]
    redraw
    if St == "on"
	highlight Cursor guifg=white guibg=green
	let St = "CAPS"
    else
	highlight Cursor guifg=white guibg=black
	let St = ""
    endif
    
    return St
endfunction

set laststatus=2
set statusline=
set statusline+=\ %f
set statusline+=%=%{Cap_Status()}\ C%c
set foldmethod=indent
" set foldnestmax=10
" set nofoldenable
set foldlevel=99

set wrap linebreak nolist
set formatoptions=1

" block edit shortcuts:
" https://stackoverflow.com/questions/9549729/vim-insert-the-same-characters-across-multiple-lines

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

" Hilighting
let python_highlight_all=1
syntax on

" line numbering
set number

augroup XML
autocmd!
autocmd FileType xml,ui,xhtml,html,xsd let g:xml_syntax_folding=1
augroup END

"rebuild help:
":help add-local-help

:filetype plugin on

"From https://vim.fandom.com/wiki/Highlight_unwanted_spaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Color for dark
":color slate
":color desert

" Color for light
:color peachpuff

