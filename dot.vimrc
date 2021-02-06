" From https://realpython.com/vim-and-python-a-match-made-in-heaven/
set foldmethod=indent
" set foldnestmax=10
" set nofoldenable
set foldlevel=99

set wrap linebreak nolist
set formatoptions=1

" block edit shortcuts:
" https://stackoverflow.com/questions/9549729/vim-insert-the-same-characters-across-multiple-lines

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

" make backspaces more powerfull
set backspace=indent,eol,start

" show (partial) command in status line
set showcmd

" auto change to dir of current file
set autochdir

" other code indentation
au BufNewFile,BufRead *.js, *.html, *.css set
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2

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
  ":color slate
  :color desert

" hilighting
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
nnoremap <space> za<Esc>

"file open
noremap f :e .<cr>

"search word
nnoremap t *

"search word
nnoremap t *

"search clear 
nnoremap T :noh<Cr>

"delete line
"nnoremap D d<Esc>

"delete char right
inoremap <C-x> <Esc>lxi

"delete char left 
inoremap <C-d> <Esc>lXi

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
nnoremap N /<Cr>

"next page
noremap <C-n> <C-f>  

"prev line
noremap p <Up>
noremap j <Up>
inoremap <C-p> <Up>

"prev search
nnoremap P ?<Cr>h

"prev page
noremap <C-p> <C-b>  

"next char 
"          l
inoremap <C-l> <Right>

"prev char
noremap k h
inoremap <C-k> <Left>

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
nnoremap 8 :make<Cr>:cw<Cr>
nnoremap 9 :cn<Cr>
nnoremap 0 :cp<Cr>
"nnoremap <M-l> :cl<Cr>

"explorer
nnoremap <C-a> :tabnew<Cr>:ex .<Cr>

"let mapleader = ","
