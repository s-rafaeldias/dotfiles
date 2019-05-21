""" Capotes Vimrc
""" Arquivo de configurações do VIM
""" Sections:
""" 00 - Vundle
""" 01 - Colors
""" 02 - Misc
""" 03 - Spaces & Tabs
""" 04 - UI Layout
""" 05 - Searching
""" 06 - Leader Shortcus
""" 07 - Fn Shortcus
""" 08 - Powerline
""" 09 - NERDTree
""" 10 - YouCompleteMe
""" 11 - Launch Config
""" 12 - Tmux
""" 13 - AutoGroups
""" 14 - Backups
""" 15 - Custom Functions

""" 00 - Vundle {{{
""""" START VUNDLE CONFIG
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

""" Utility
Plugin 'tpope/vim-fugitive'
Plugin 'wincent/command-t'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'editorconfig/editorconfig-vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'majutsushi/tagbar'

""" C++
Plugin 'octol/vim-cpp-enhanced-highlight'

""" Python
Plugin 'cjrh/vim-conda'
Plugin 'davidhalter/jedi-vim'

""" Ruby/Rails
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rbenv'

""" Go
Plugin 'fatih/vim-go'

""" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

""" YAML
Plugin 'avakhov/vim-yaml'

""" UI Interface
Plugin 'Lokaltog/powerline'
Plugin 'AnsiEsc.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jszakmeister/vim-togglecursor'

""" Themes
Plugin 'sonph/onehalf', {'rtp': 'vim/'}
Plugin 'jacoborus/tender.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype on
filetype plugin on
filetype plugin indent on    " required
" Put your non-Plugin stuff after this line
""" }}}

""" 01 - Colors {{{
syntax on	" Syntax highlighting
syntax enable	" Enable syntax highlighting
set background=dark
set t_Co=256
colorscheme tender
""" }}}

""" 02 - Misc {{{
"set nocompatible
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

set timeoutlen=1000 ttimeoutlen=0


set tags=./tags
if $PATH !~ "\.rbenv"
    let $PATH="/home/rafael/.rbenv/shims:/home/rafael/.rbenv/bin:" . $PATH
endif

set completeopt-=preview
""" }}}

""" 03 - Spaces & Tabs {{{
"" show whitespaces
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·
set list
"" }}}

""" 04 - UI Layout {{{
set number					" show line numbers
set cursorline					" show a visual line under the cursor's current line
set showmatch					" show the matching part of the pair for [] {} and ()
let g:togglecursor_insert='blinking_line'

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
""" }}}

""" 05 - Searching {{{
""" }}}

""" 06 - Leader Shortcus {{{
""" }}}

""" 07 - Fn Shortcus {{{
set pastetoggle=<F2>
nmap <F8> :TagbarToggle<CR>
""" }}}

""" 08 - Powerline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='tender'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
""" }}}

""" 09 - NERDTree {{{
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
let NERDTreeChDirMode=2
map <C-d> :NERDTreeToggle<CR>
""" }}}

""" 10 - YouCompleteMe {{{
let g:ycm_filetype_blacklist = { 'python': 1, 'go': 1, 'ruby': 1 }
""" }}}

""" 11 - Launch Confi {{{g
""" }}}

""" 12 - Tmux {{{
""" }}}

""" 13 - AutoGroups {{{
" disable continuation of comments to the next line
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
" Ruby settings
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
""" }}}

""" 14 - Backups {{{
""" }}}

""" 15 - Custom Functions {{{
""" }}}
