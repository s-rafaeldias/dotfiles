" Python configuration using conda
let g:python3_host_prog = '/home/05018601183/anaconda3/envs/neovim/bin/python'
set directory=.

" ===================================
"              Plugins
" ===================================
call plug#begin()

""" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

""" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/vim-easy-align'

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
"              netrw
" ===================================
let g:netrw_banner = 1
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25

" ===================================
"            UI Layout
" ===================================
set rnu 	 " show relative numbers
set nu 		 " show line numbers
set cursorline   " show a visual line under the cursor's current line
set cursorcolumn " show a visual line under cursor's current column
set showmatch	 " show the matching part of the pair for [] {} and ()

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

set background=dark
colorscheme tender

" White space settings
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<,space:·
set list

" Cursor settings
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175


" ===================================
"          Misc
" ===================================
set timeoutlen=1000 ttimeoutlen=0
set updatetime=100
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
" Upper word on insert mode
inoremap <c-u> <esc>bveUea
" Upper word on normal mode
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
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" comment code
augroup codeComment
	autocmd!
	autocmd FileType python nnoremap <buffer> <Leader>c I#<Esc>
	autocmd FileType yaml nnoremap <buffer> <Leader>c I# <Esc>
	autocmd FileType vim nnoremap <buffer> <Leader>c I"<Esc>
augroup END

" Open init.vim filetype config on a new tab
"augroup nvimSettings
	"autocmd!
"augroup END

