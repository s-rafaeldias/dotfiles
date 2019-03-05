set nocompatible
"set nowrap
set encoding=utf8

""""" START VUNDLE CONFIG

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

""" Utility
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'davidhalter/jedi-vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'cjrh/vim-conda'
Plugin 'fatih/vim-go'

""" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

""" Theme / Interface
Plugin 'AnsiEsc.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jszakmeister/vim-togglecursor'
" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype on
filetype plugin on
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line

" Configurações de beginning
" Disable arrow keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Syntax highlighting
syntax on
" Adiciona número na linha
set number
" Disable annoying beeping
set noerrorbells
set vb t_vb=
" enable syntax highlighting
syntax enable
" show the matching part of the pair for [] {} and ()
set showmatch
" show a visual line under the cursor's current line
set cursorline
" show whitespaces
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·
set list

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='violet'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
set t_Co=256

""" NERDTree Settings
let NERDTreeShowHidden=1

map <C-d> :NERDTreeToggle<CR>

" Cursor settings
let g:togglecursor_insert='blinking_line'


