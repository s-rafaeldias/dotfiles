" Python configuration using conda
let g:python3_host_prog = '/home/rafael/miniconda3/envs/neovim/bin/python'
set directory=.

" ===================================
"              Plugins
" ===================================
call plug#begin()

""" Git
Plug 'tpope/vim-fugitive'

""" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-easy-align'

""" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

""" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

""" Misc
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'

""" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

""" Themes
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'jacoborus/tender.vim'

""" Airline
Plug 'Lokaltog/powerline'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" Initialize plugin system
call plug#end()


" ===================================
"            Airline
" ===================================
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='tender'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#enabled = 1

" ===================================
"            NERDTree
" ===================================
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden=1
let NERDTreeChDirMode=2
map <c-d> :NERDTreeToggle<CR>


" ===================================
"            UI Layout
" ===================================
set rnu 	" show relative numbers
set nu 		" show line numbers
set cursorline  " show a visual line under the cursor's current line
set showmatch	" show the matching part of the pair for [] {} and ()

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" White space settings
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·
set list

" Cursor settings
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175

set timeoutlen=1000 ttimeoutlen=0
set updatetime=100

set background=dark
set t_Co=256
colorscheme tender
set completeopt-=preview

" ===================================
"          Custom mappings
" ===================================
" Disable arrow keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Move line up
nnoremap - ddp
" Move line down
nnoremap _ ddkP
" Upper word on Insert mode
inoremap <c-u> <esc>bveUea
" Upper word on Normal mode
nnoremap <c-u> bveUe
" Remap jk for exit Insert mode
inoremap kj <Esc>
inoremap <Esc> <nop>


" ===================================
"          Leader Shortcus
" ===================================
let mapleader=","
" Open vim config
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" Reload vim config
nnoremap <leader>sv :source $MYVIMRC<CR>
" Wrap word in double quotes
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
" Wrap word in single quotes
nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel
" Wrap selected area in Visual mode in single quotes
vnoremap <Leader>' <Esc>`>a'<Esc>`<i'<Esc>
" Wrap selected area in Visual mode in double quotes
vnoremap <Leader>" <Esc>`>a"<Esc>`<i"<Esc>


" ===================================
"            Fn Shortcuts
" ===================================
set pastetoggle=<F2>
nmap <F8> :TagbarToggle<CR>


" ===================================
"             Autocmd
" ===================================
" disable continuation of comments to the next line
autocmd BufNewFile,BufRead * setlocal formatoptions-=cronoremap 
