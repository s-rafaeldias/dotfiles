" Plugins ================================================= {{{
call plug#begin()

""" General plugins
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sodapopcan/vim-twiggy'
" NERDTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'majutsushi/tagbar'
Plug 'wincent/command-t', { 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'TaDaa/vimade'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'

" Python
Plug 'vim-python/python-syntax'
Plug 'davidhalter/jedi-vim'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Clojure
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-highlight'
Plug 'guns/vim-clojure-static'

""" Colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'danilo-augusto/vim-afterglow'
" Initialize plugin system
call plug#end()
" }}}

" General Settings ================================================= {{{
set relativenumber      " show relative numbers
set number              " show line numbers
set cursorline          " show a visual line under the cursor's current line
"set cursorcolumn        " show a visual line under cursor's current column
set showmatch           " show the matching part of the pair for [] {} and ()

set timeoutlen=1000
set ttimeoutlen=0
set updatetime=100

set completeopt-=preview    " Disable preview for autocomplete
set directory=.             " set root directory for .swp files

set noerrorbells        " Disable bells
set novisualbell        " Disable bells

" White space settings
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" Git diff settings
set diffopt=vertical

syntax enable

if has('nvim')
    if $USER ==# 'rafael'
        let g:python3_host_prog = $HOME . '/miniconda3/envs/neovim/bin/python'
    elseif $USER ==# '05018601183'
        let g:python3_host_prog = $HOME . '/anaconda3/envs/neovim/bin/python'
    endif
endif


let mapleader=","

" disable continuation of comments to the next line
autocmd FileType * setlocal formatoptions-=cro

" Disable arrow keys
noremap  <Up> <NOP>
noremap! <Up> <Esc>
noremap  <Down> <NOP>
noremap! <Down> <Esc>
noremap  <Left> <NOP>
noremap! <Left> <Esc>
noremap  <Right> <NOP>
noremap! <Right> <Esc>
" }}}

" Colors ================================================= {{{
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

let g:afterglow_italic_comments=1
colorscheme afterglow
"set background=dark " for the dark version
" }}}

" Fn mappings ================================================= {{{
set pastetoggle=<F2>
" }}}

" INSERT MODE mappings ================================================= {{{
" Upper word on insert mode
inoremap <C-U> <ESC>bveUea
" Remap jk and kj for exit Insert mode
inoremap kj <Esc>
inoremap jk <Esc>
" Disable <Esc> for exit insert mode
inoremap <Esc> <NOP>
" Create new undo block on <CR> in insert mode
inoremap <CR> <C-G>u<CR>
" }}}

" NORMAL MODE mappings ================================================= {{{
" Open vim config
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" Reload vim config
nnoremap <leader>sv :source $MYVIMRC<CR>

" Move line up
nnoremap - ddp
" Move line down
nnoremap _ ddkP
" <CR> on normal mode add a new line below cursor
nnoremap <CR> o<ESC>

" Upper word on normal mode
nnoremap <C-U> bveUe

" Move to next buffer
nnoremap <S-TAB> :bn<CR>
" Move to previous buffer
nnoremap <C-TAB> :bp<CR>

" Wrap word in double quotes
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
" Wrap word in single quotes
nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel
" highligth trailing spaces
nnoremap <Leader>w :execute ":match Error " . '/\v\s+$/' <CR>
" Paste clipboard (register *)
nnoremap <Leader>P "*P
nnoremap <Leader>p <F2>"*p<F2>
" }}}

" VISUAL MODE mappings ================================================= {{{
" Wrap selected area in Visual mode in single quotes
vnoremap <Leader>' <Esc>`>a'<Esc>`<i'<Esc>
" Wrap selected area in Visual mode in double quotes
vnoremap <Leader>" <Esc>`>a"<Esc>`<i"<Esc>
" Copy selected text to + register (clipboard)
vnoremap <Leader>y "+y
" }}}

" Plugin: Airline ================================================= {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='afterglow'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#coc#enabled = 1
" }}}

" Plugin: NERDTree ================================================= {{{
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2
map <C-D> :NERDTreeToggle<CR>
" }}}

" Plugin: GitGutter ================================================= {{{
autocmd BufWritePost * GitGutter
" }}}

" Plugin: Tagbar ================================================= {{{
nmap <F8> :TagbarToggle<CR>
" }}}

" Plugin: kien/rainbow_parentheses.vim ================================================= {{{
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
" }}}

" Plugin: nerdcommenter ================================================= {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" }}}

" Plugin: Coc ================================================= {{{
" Trigger coc completion with <C-SPACE>
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Disable Coc for clojure files
autocmd BufNew,BufEnter *.clj  execute "silent! CocDisable"
autocmd BufLeave *.clj execute "silent! CocEnable"
" }}}

" Language: Python ================================================= {{{
autocmd FileType python set ts=4
autocmd FileType python set expandtab
autocmd FileType python set shiftwidth=4

let g:python_highlight_all=1
let g:jedi#completions_enabled = 0
" }}}

" Language: Go ================================================= {{{
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
" Error and warning signs.
"let g:ale_sign_error = '⤫'
"let g:ale_sign_warning = '⚠'
" }}}

" Language: Vimscript ================================================= {{{
autocmd FileType vim set expandtab
autocmd FileType vim set shiftwidth=4
autocmd FileType vim set softtabstop=4
autocmd FileType vim set tabstop=4
autocmd FileType vim set foldmethod=marker
" }}}

" Language: Json ================================================= {{{
autocmd FileType json syntax match Comment +\/\/.\+$+
" }}}
