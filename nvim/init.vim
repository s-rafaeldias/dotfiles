" Plugins ================================================= {{{
call plug#begin()

""" General plugins
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'jaxbot/github-issues.vim'
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
" Plug 'vim-syntastic/syntastic'
Plug 'dense-analysis/ale'
" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Show indentation line
Plug 'Yggdroot/indentLine'
" Plug 'kana/vim-textobj-user'

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
" Javascript
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" Plug 'jelera/vim-javascript-syntax'
" Plug 'othree/javascript-libraries-syntax.vim'
" HTML
Plug 'mattn/emmet-vim'
" Haskell
Plug 'neovimhaskell/haskell-vim'
" Elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'mhinz/vim-mix-format'

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

" Change <Leader> to ',' and <LocalLeader> to `;`
let mapleader=","
let maplocalleader=";"

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
nnoremap <F3> :set hlsearch!<CR>
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

" Plugin: Ale ================================================= {{{
let g:ale_linters = {
\  'elixir': ['elixir-ls'],
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['prettier'],
\  'elixir': ['mix_format'],
\}

let g:ale_elixir_elixir_ls_release = $HOME . '/.elixir/elixir-ls/rel'
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
" Use <CR> for select completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Make <cr> select the first completion item and confirm completion when no item have selected
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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

" Plugin: GitGutter ================================================= {{{
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
autocmd BufWritePost * GitGutter
" }}}

" Plugin: NERDTree ================================================= {{{
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2
noremap <C-D> :NERDTreeToggle<CR>
" }}}

" Plugin: kien/rainbow_parentheses.vim ================================================= {{{
augroup RAINBOW_PARENTHESES
    au!
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
augroup END
" }}}

" Plugin: nerdcommenter ================================================= {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" }}}

" Plugin: Tagbar ================================================= {{{
nmap <F9> :TagbarToggle<CR>
" }}}

" Language: Elixir ================================================= {{{
" Format files on save with 'mix format'
" autocmd BufWritePost *.exs,*.ex silent :!mix format %
let g:mix_format_on_save = 1
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
let g:go_def_mapping_enabled=1
let g:go_def_mode='gopls'
let g:go_auto_type_info = 1
let g:go_fmt_fail_silently = 1
augroup GO_IDE
    au!
    autocmd FileType go
        \  nmap <buffer> <LocalLeader>r   <Plug>(go-run)
        \| nmap <buffer> <LocalLeader>b   <Plug>(go-build)
        \| nmap <buffer> <LocalLeader>tf  <Plug>(go-alternate-vertical)
        \| nmap <buffer> <LocalLeader>t   <Plug>(go-test)
        \| nmap <buffer> <LocalLeader>c   <Plug>(go-coverage)
        \| nmap <buffer> <LocalLeader>gd  <Plug>(go-doc)
        \| nmap <buffer> <LocalLeader>gv  <Plug>(go-doc-vertical)
        \| nmap <buffer> <LocalLeader>s   <Plug>(go-implements)
        \| nmap <buffer> <LocalLeader>i   <Plug>(go-info)
augroup END
" }}}

" Language: Haskell ================================================= {{{
augroup HASKELL_IDE
    au!
    autocmd FileType haskell set expandtab
augroup END

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
augroup JS_IDE
    au!
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FileType javascript,javascriptreact,json
                \  set ts=2
                \| set expandtab
                \| set shiftwidth=2
augroup END
" }}}

" Language: Markdown ================================================= {{{
let g:markdown_folding = 1
let g:markdown_enable_folding = 1
" }}}

" Language: Python ================================================= {{{
augroup PYTHON_IDE
    au!
    autocmd FileType python
                \  set ts=4
                \| set expandtab
                \| set shiftwidth=4
                \| set foldmethod=indent
                \| set foldnestmax=2
                \| normal zR
    autocmd BufWritePre *.py execute ':Black'
augroup END

let g:black_linelength = 79
let g:python_highlight_all=1
let g:jedi#completions_enabled = 1
" }}}

" Language: Vimscript ================================================= {{{
augroup VIML_IDE
    au!
    autocmd FileType vim
                \  set expandtab
                \| set shiftwidth=4
                \| set softtabstop=4
                \| set tabstop=4
                \| set foldmethod=marker
augroup END
" }}}
