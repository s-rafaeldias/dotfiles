" Plugins ================================================= {{{
call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'rbgrouleff/bclose.vim'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
" Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'Yilin-Yang/vim-markbar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'nathangrigg/vim-beancount'
" Plug 'tpope/vim-repeat'
" Plug 'guns/vim-sexp'
Plug 'ThePrimeagen/vim-be-good'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'gruvbox-community/gruvbox'

Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'Olical/conjure'
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mattn/emmet-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'keith/swift.vim'

call plug#end()
" }}}

" General Settings ================================================= {{{
if has('nvim')
    let g:python3_host_prog = $HOME . '/miniconda3/envs/neovim/bin/python'
    let g:python_host_prog = $HOME . '/miniconda3/envs/neovim2/bin/python'
endif

" Enable matchit
runtime macros/matchit.vim

set nowrap
set relativenumber          " show relative numbers
set number                  " show line numbers
" set cursorline              " show a visual line under the cursor's current line
set showmatch               " show the matching part of the pair for [] {} and ()
set scrolloff=10
set signcolumn=yes          " always show signcolumns
set timeoutlen=300
set ttimeoutlen=0
set updatetime=40
set completeopt-=preview    " Disable preview for autocomplete
set noerrorbells            " Disable bells
set novisualbell            " Disable bells
set splitright
set completeopt=menuone,noinsert,noselect


set noswapfile              " Don't create .swp files
set nobackup
set undodir=~/.vim/undodir
set undofile

" White space settings
set listchars=eol:↵,tab:↦\ ,trail:~,extends:>,precedes:<
set list

" Git diff settings
set diffopt=vertical

let mapleader=" "
let maplocalleader=","

set directory=.
set tags=./tags,tags;$HOME

" disable continuation of comments to the next line
autocmd FileType * setlocal formatoptions-=cro

" Enable highligthing a selection on yank
autocmd TextYankPost * silent! lua vim.highlight.on_yank()

" Lets try this touch typing thing
map j <Left>
map k <Down>
map l <Up>
map ; <Right>
nnoremap <C-W>j <C-w>h
nnoremap <C-W>k <c-w>j
nnoremap <c-w>l <c-w>k
nnoremap <c-w>; <c-w>l
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
colorscheme gruvbox
" }}}

" Fn mappings ================================================= {{{
nnoremap <F3> :set hlsearch!<CR>
" }}}

" INSERT MODE mappings ================================================= {{{
" Upper word on insert mode
inoremap <C-U> <ESC>bveUea
" Remap jk and kj for exit Insert mode
inoremap lk <Esc><Right>
inoremap kl <Esc><Right>
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
" nnoremap <CR> o<ESC>

" Move to next buffer
nnoremap <S-TAB> :bn<CR>

" Paste clipboard (register *)
nnoremap <Leader>P "*P
nnoremap <Leader>p "*p
" }}}

" VISUAL MODE mappings ================================================= {{{
" Copy selected text to + register (clipboard)
vnoremap <Leader>y "+y
vnoremap D "_d
" }}}

" Plugin: Airline ================================================= {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#enabled = 1
" }}}

" Plugin: LSP ================================================= {{{
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'nvim_lsp'.tsserver.setup{on_attach=require'completion'.on_attach}
lua require'nvim_lsp'.jedi_language_server.setup{on_attach=require'completion'.on_attach}
lua require'nvim_lsp'.solargraph.setup{on_attach=require'completion'.on_attach}
lua require'nvim_lsp'.sourcekit.setup{on_attach=require'completion'.on_attach}
lua require'nvim_lsp'.jdtls.setup{on_attach=require'completion'.on_attach}
lua require'nvim_lsp'.gopls.setup{on_attach=require'completion'.on_attach}

" let g:coc_global_extensions = [
            " \ 'coc-json',
            " \ 'coc-yaml',
            " \ 'coc-highlight',
            " \ 'coc-html',
            " \ 'coc-css',
            " \ 'coc-emmet',
            " \ 'coc-vimlsp',
            " \ 'coc-ultisnips',
            " \ 'coc-conjure',
            " \ 'coc-clangd',
            " \ 'coc-jedi',
            " \ 'coc-solargraph',
            " \ 'coc-rls',
            " \ 'coc-tsserver'
            " \]

" let g:coc_filetype_map = {
    " \ 'scss': 'scss',
" \ }

" " Use <C-N> to trigger completion.
" inoremap <SILENT><EXPR> <C-N> coc#refresh()
" " Use <TAB> for select completion
" inoremap <EXPR> <TAB> pumvisible() ? "\<C-Y>" : "\<C-G>u\<CR>"
" " Make <cr> select the first completion item and confirm completion when no item have selected
" inoremap <SILENT><EXPR> <TAB> pumvisible() ? coc#_select_confirm() : "\<C-G>u\<CR>"

" " Close the preview window when completion is done.
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" " Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
    " execute 'h '.expand('<cword>')
  " else
    " call CocAction('doHover')
  " endif
" endfunction

" augroup COC
    " autocmd!
    " nmap <silent> <Leader>gd <Plug>(coc-definition)
" augroup END
" }}}

" Plugin: FZF ================================================= {{{
let g:fzf_layout =  { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS = '--reverse'
nnoremap <C-P> :Files<CR>
nnoremap <C-B> :Buffers<CR>
nnoremap <Leader>gf :GFiles<CR>
nnoremap <Leader>ft :Filetypes<CR>
" }}}

" Plugin: kien/rainbow_parentheses.vim ================================================= {{{
augroup RAINBOW_PARENTHESES
    autocmd!
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

" Language: C/C++ ================================================= {{{
augroup C_IDE
    autocmd!
    autocmd FileType cpp
                \  set noexpandtab
                \| set tabstop=4
augroup END

let g:syntastic_cpp_checkers = ['cpplint']
let g:syntastic_c_checkers = ['cpplint']
let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
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
" let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled=1
let g:go_def_mode='gopls'
let g:go_auto_type_info = 1
let g:go_fmt_fail_silently = 1

augroup GO_IDE
    autocmd!
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

" Language: HTML/CSS ================================================= {{{
augroup HTML_CSS_IDE
    autocmd!
    autocmd FileType css,scss
                \  set expandtab
                \| set tabstop=2
                \| set shiftwidth=2
augroup END
" }}}

" Language: Javascript ================================================= {{{
augroup JS_IDE
    autocmd!
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FileType javascript,javascriptreact,json
                \  set tabstop=2
                \| set expandtab
                \| set shiftwidth=2
augroup END
" }}}

" Language: Lua ================================================= {{{
augroup LUA_IDE
    autocmd!
    autocmd FileType lua
                \  set tabstop=4
                \| set expandtab
                \| set shiftwidth=4
augroup END
" }}}

" Language: Python ================================================= {{{
augroup PYTHON_IDE
    autocmd!
    autocmd FileType python
                \  set tabstop=4
                \| set expandtab
                \| set shiftwidth=4
                \| set foldmethod=indent
                \| set foldnestmax=2
                \| normal zR
augroup END

let g:black_linelength = 100
let g:python_highlight_all=1
" }}}

" Language: Rust ================================================= {{{
let g:rustfmt_autosave = 1
" }}}

" Language: Rust ================================================= {{{
let g:syntastic_swift_swiftlint_use_defaults = 1 
let g:syntastic_swift_checkers = ['swiftlint', 'swiftpm'] 
" }}}

" Language: Vimscript ================================================= {{{
augroup VIML_IDE
    autocmd!
    autocmd FileType vim
                \  set expandtab
                \| set shiftwidth=4
                \| set softtabstop=4
                \| set tabstop=4
                \| set foldmethod=marker
augroup END
" }}}
