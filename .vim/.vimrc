""" Capotes Vimrc
""" Arquivo de configurações do VIM
""" Sections:
""" 00 - Vundle
""" 01 - Colors
""" 02 - Misc
""" 03 - Spaces & Tabs
""" 04 - UI Layout
""" 05 - Searching
""" 06 - Folding
""" 08 - Leader Shortcus
""" 09 - Powerline
""" 10 - CrtlP
""" 11 - NERDTree
""" 12 - Syntastic
""" 13 - Launch Config
""" 14 - Tmux
""" 15 - AutoGroups
""" 16 - Backups
""" 17 - Custom Functions

""" 00 - Vundle {{{
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
Plugin 'editorconfig/editorconfig-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'

""" C++
Plugin 'octol/vim-cpp-enhanced-highlight'

""" Python
Plugin 'cjrh/vim-conda'
Plugin 'davidhalter/jedi-vim'

""" Ruby/Rails
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rbenv'

""" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

""" YAML
Plugin 'avakhov/vim-yaml'

""" Theme / Interface
Plugin 'Lokaltog/powerline'
Plugin 'AnsiEsc.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jszakmeister/vim-togglecursor'
Plugin 'sonph/onehalf', {'rtp': 'vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype on
filetype plugin on
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line
" }}}

""" 01 - Colors {{{
syntax on	" Syntax highlighting
syntax enable	" Enable syntax highlighting
set background=dark
set t_Co=256
colorscheme onehalfdark
"}}}

""" 02 - Misc {{{
set nocompatible
set encoding=utf8

" Disable arrow keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Disable annoying beeping
set noerrorbells
set vb t_vb=
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

nnoremap <leader>. :CtrlPTag<cr>
set tags=./tags
"}}}

"" 03 - Spaces & Tabs {{{
" show whitespaces
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·
set list

"}}}

""" 04 - UI Layout {{{
set number					" show line numbers
set cursorline					" show a visual line under the cursor's current line
set showmatch					" show the matching part of the pair for [] {} and ()
let g:togglecursor_insert='blinking_line'

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
"}}}

""" 05 - Searching {{{
set tags=./tags;
"}}}

""" 06 - Folding {{{
"}}}

""" 08 - Leader Shortcuts {{{
"}}}

""" 09 - Powerline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='onehalfdark'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
"}}}

""" 10 - CrtlP {{{
"}}}

""" 11 - NERDTree {{{
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
map <C-d> :NERDTreeToggle<CR>
"}}}

""" 12 - Syntastic {{{
"}}}

""" 13 - Launch Config {{{
"}}}

""" 14 - Tmux {{{
"}}}

""" 15 - AutoGroups {{{
" disable continuation of comments to the next line
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
"}}}

""" 16 - Backups {{{
"}}}

""" 17 - Custom Functions {{{
"}}}
