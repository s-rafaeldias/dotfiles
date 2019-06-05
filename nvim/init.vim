" Python configuration using conda
let g:python3_host_prog = '/home/05018601183/anaconda3/envs/neovim/bin/python'

" ===================================
"              Plugins
" ===================================
call plug#begin()
" Git
Plug 'airblade/vim-gitgutter'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-easy-align'

" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

""" Misc
Plug 'jszakmeister/vim-togglecursor'

""" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
let g:deoplete#enable_at_startup = 1

""" Themes
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'


" Initialize plugin system
call plug#end()


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

"let g:neodark#background = '#202020'
"let g:neodark#use_256color = 1
colorscheme onedark

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
" Upper word on insert mode
inoremap <c-u> <esc>bveUea
" Upper word on normal mode
nnoremap <c-u> bveUe
" Remap jk for exit Insert mode
inoremap kj <Esc>
inoremap <Esc> <nop>


" ===================================
""" Leader Shortcus
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
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
