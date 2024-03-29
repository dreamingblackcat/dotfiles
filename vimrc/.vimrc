"Vundle Plugin Manager Configs
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here'
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'Chiel92/vim-autoformat'
Plugin 'fatih/vim-go'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'mileszs/ack.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'godlygeek/tabular'
Plugin 'hwrod/interactive-replace'
Plugin 'slim-template/vim-slim.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'mxw/vim-jsx'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'elixir-editors/vim-elixir'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'tpope/vim-fugitive'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append ! to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append ! to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append ! to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" General Configs
colorscheme railscasts 
syntax on
set mouse=a     " enable mouse
set number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set visualbell	" Use visual bell (no beeping)
 
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set shiftwidth=2	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=2	" Number of spaces per Tab
set relativenumber 
set term=xterm-256color

" Advanced
set ruler	" Show row and column ruler information
 
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
 
 
" Generated by VimConfig.com

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


" Key Maps
let mapleader = ","
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>
noremap <leader>w <C-w>w
noremap <leader>f :Autoformat<CR>
nnoremap <leader>p :set invpaste paste?<CR>
nnoremap <leader>c :noh<CR>
set pastetoggle=<leader>p
set showmode
let g:ackprg = 'ag --vimgrep'
set tags=./.tags,.tags
nnoremap <leader>g <c-]>:tabe %<CR>gT<c-^>gt
nnoremap <leader>F :CtrlPBufTagAll<CR>
vnoremap <leader>c "+y
nnoremap <leader>; :bnext<CR>
nnoremap <leader>l :bprevious<CR>
nnoremap <leader>rrr :source ~/.vimrc<CR>

"solution for pasting yanked text subsequent times
xnoremap p "_dP

" Syntastic related configs
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_mode_map = { 'mode': 'passive' }
nnoremap <leader>e :SyntasticCheck<CR>
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Custom functions for remvoing trailing whitespace
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.rb,*.js,*.jsx,*.java,*.css,*.scss,*.html,*.erb,*.slim :call <SID>StripTrailingWhitespaces()

