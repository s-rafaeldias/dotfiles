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
" Ranger
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
" displays tags in a window
Plug 'majutsushi/tagbar'
" Fades inactive buffers
Plug 'TaDaa/vimade'
" Language pack
Plug 'sheerun/vim-polyglot'
" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Code comments
Plug 'scrooloose/nerdcommenter'
" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'
" Color matching (), {}, []
Plug 'kien/rainbow_parentheses.vim'
" Show content of registers
Plug 'junegunn/vim-peekaboo'
" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Wakatime
Plug 'wakatime/vim-wakatime'
" Syntax checking hacks
Plug 'vim-syntastic/syntastic'
" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Show indentation line
Plug 'Yggdroot/indentLine'
""" Colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'danilo-augusto/vim-afterglow'
Plug 'tyrannicaltoucan/vim-deep-space'

""" Languages
" Dockerfile
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
" Python
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'psf/black'
Plug 'davidhalter/jedi-vim'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': 'v1.20' }
" Clojure
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
" Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
" Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
" Javascript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'
" HTML
Plug 'mattn/emmet-vim'
" Haskell
Plug 'neovimhaskell/haskell-vim'
" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
" Plug 'tpope/vim-endwise'

" Initialize plugin system
call plug#end()
" }}}

" General Settings ================================================= {{{
if has('nvim')
    let g:python3_host_prog = $HOME . '/miniconda3/envs/neovim/bin/python'
    let g:python_host_prog = $HOME . '/miniconda3/envs/neovim2/bin/python'
endif

set relativenumber      " show relative numbers
set number              " show line numbers
set cursorline          " show a visual line under the cursor's current line
set showmatch           " show the matching part of the pair for [] {} and ()
set scrolloff=10
set signcolumn=yes      " always show signcolumns

set timeoutlen=1000
set ttimeoutlen=0
set updatetime=100

set completeopt-=preview    " Disable preview for autocomplete

set noerrorbells        " Disable bells
set novisualbell        " Disable bells

" White space settings
set listchars=eol:¬,tab:>\ ,trail:~,extends:>,precedes:<
set list

" Git diff settings
set diffopt=vertical

" Change <Leader> to ','
let mapleader=","

set directory=.

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
syntax enable

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

set background=dark
let g:deepspace_italics=1
colorscheme deep-space
hi MatchParen guibg=#c47ebd guifg=#51617d
" let g:afterglow_italic_comments=1
" colorscheme afterglow
" set background=dark " for the dark version
" }}}

" Fn mappings ================================================= {{{
set pastetoggle=<F2>
" }}}

" INSERT MODE mappings ================================================= {{{
" Upper word on insert mode
inoremap <C-U> <ESC>bveUea
" Remap jk and kj for exit Insert mode
inoremap kj <Esc><Right>
inoremap jk <Esc><Right>
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

" Move between windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

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

" Wrap word in double quotes
nnoremap <Leader>" viw<esc>a"<esc>bi"<esc>lel
" Wrap word in single quotes
nnoremap <Leader>' viw<esc>a'<esc>bi'<esc>lel
" highligth trailing spaces
nnoremap <Leader>w :execute ":match Error " . '/\v\s+$/' <CR>
" Paste clipboard (register *)
nnoremap <Leader>P "*P
nnoremap <Leader>p "*p
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
let g:airline_theme='deep_space'
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
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
autocmd BufWritePost * GitGutter
" }}}

" Plugin: Tagbar ================================================= {{{
nmap <F9> :TagbarToggle<CR>
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
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-python',
            \ 'coc-yaml',
            \ 'coc-highlight',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-emmet']

" Use <C-N> to trigger completion.
inoremap <silent><expr> <C-N> coc#refresh()
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

" Plugin: FZF ================================================= {{{
nnoremap <Leader>t :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>gf :GFiles?<CR>
nnoremap <Leader>ft :Filetypes<CR>
" }}}

" Language: Elixir ================================================= {{{
" Format files on save with 'mix format'
autocmd BufWritePost *.exs,*.ex silent :!mix format
" }}}

" Language: Golang ================================================= {{{
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_fmt_fail_silently = 1
" Error and warning signs.
" let g:ale_sign_error = '⤫'
" let g:ale_sign_warning = '⚠'
" }}}

" Language: Haskell ================================================= {{{
autocmd FileType haskell set expandtab

let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2
" }}}

" Language: Javascript/JSON ================================================= {{{
" JSON
autocmd FileType json syntax match Comment +\/\/.\+$+

" Javascript
autocmd FileType javascript set ts=2
autocmd FileType javascript set expandtab
autocmd FileType javascript set shiftwidth=2

" Typescript
autocmd FileType typescript.tsx set ts=2
autocmd FileType typescript.tsx set expandtab
autocmd FileType typescript.tsx set shiftwidth=2
" }}}

" Language: Markdown ================================================= {{{
let g:markdown_folding = 1
let g:markdown_enable_folding = 1
" }}}

" Language: Python ================================================= {{{
autocmd FileType python set ts=4
autocmd FileType python set expandtab
autocmd FileType python set shiftwidth=4
autocmd FileType python set foldmethod=indent
autocmd FileType python set foldnestmax=2
autocmd FileType python normal zR

autocmd BufWritePre *.py execute ':Black'
let g:black_linelength = 79

let g:python_highlight_all=1
let g:jedi#completions_enabled = 1
" let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
" }}}

" Language: Vimscript ================================================= {{{
autocmd FileType vim set expandtab
autocmd FileType vim set shiftwidth=4
autocmd FileType vim set softtabstop=4
autocmd FileType vim set tabstop=4
autocmd FileType vim set foldmethod=marker
" }}}
