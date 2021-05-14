" Plugins ================================================= {{{
call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'rbgrouleff/bclose.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'TimUntersberger/neogit'
Plug 'godlygeek/tabular'


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'ThePrimeagen/git-worktree.nvim'
" Plug '/Users/rafael/workspace/projects/git-worktree.nvim'
Plug 'ThePrimeagen/harpoon'

Plug 'tpope/vim-surround'
Plug 'nathangrigg/vim-beancount'
" Plug 'tpope/vim-repeat'
" Plug 'guns/vim-sexp'
" Plug 'ThePrimeagen/vim-be-good'
Plug 'SirVer/ultisnips'

Plug 'Yggdroot/indentLine'
" Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

" Plug 'tjdevries/nlua.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/lsp_extensions.nvim'
" Plug 'nvim-lua/completion-nvim'
Plug 'euclidianAce/BetterLua.vim'
Plug 'svermeulen/vimpeccable'
Plug 'nvim-lua/lsp-status.nvim'


Plug 'gruvbox-community/gruvbox'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'

" Plug 'Olical/conjure'
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'mattn/emmet-vim', { 'for': 'html' }
" Plug 'cakebaker/scss-syntax.vim'

" Python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}

Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'json', 'typescriptreact', 'javascriptreact'] }
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
" Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

call plug#end()
" }}}

" General Settings ================================================= {{{
if has('nvim')
    let g:python3_host_prog = $HOME . '/miniconda3/envs/neovim/bin/python'
    let g:python_host_prog = $HOME . '/miniconda3/envs/neovim2/bin/python'
endif

" Enable matchit
runtime macros/matchit.vim

" set nowrap
set relativenumber
set number
set nohlsearch
set hidden
set cursorline
set showmatch
set splitright
set incsearch
set scrolloff=10
set signcolumn=yes

set tabstop=4
set expandtab
set shiftwidth=4

" White space settings
set listchars=eol:↵,tab:↦\ ,trail:~,extends:>,precedes:<
set list

set timeoutlen=300
set ttimeoutlen=0
set updatetime=40

set noerrorbells            " Disable bells
set novisualbell            " Disable bells

set completeopt-=preview
set completeopt=menuone,noinsert,noselect

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" disable continuation of comments to the next line
autocmd FileType * setlocal formatoptions-=cro

" Git diff settings
set diffopt=vertical

let mapleader=" "
" let maplocalleader=","

set directory=.
set tags=./tags,tags;$HOME

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
" highlight Normal guibg=none
" }}}

" INSERT MODE mappings ================================================= {{{
" Upper word on insert mode
" Remap lk and kj for exit Insert mode
inoremap lk <esc><right>
inoremap kl <esc><right>
" Create new undo block on <CR> in insert mode
inoremap <CR> <C-G>u<CR>
" }}}

" NORMAL MODE mappings ================================================= {{{
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

nnoremap <F2> :Goyo<CR>
nnoremap <F3> :luafile %<CR>
" }}}

" VISUAL MODE mappings ================================================= {{{
" Copy selected text to + register (clipboard)
vnoremap <Leader>y "+y
vnoremap D "_d
" }}}

" TERMINAL mappings ================================================= {{{
tnoremap <Esc> <C-\><C-n>
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

" Plugin: Goyg ================================================= {{{
let g:goyo_width = 120
" }}}

" Plugin: LSP ================================================= {{{
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_ignore_case = 1
" let g:completion_enable_snippet = ''
" }}}

" Plugin: kien/rainbow_parentheses.vim ================================================= {{{
autocmd FileType * RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" }}}

" Plugin: nerdcommenter ================================================= {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" }}}

" Plugin: utilsnips ================================================= {{{
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'my_snippets']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
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
" }}}

" Language: HTML/CSS ================================================= {{{
augroup HTML_CSS_IDE
    let g:user_emmet_mode='inv'
    let g:user_emmet_expandabbr_key='<Tab>'
    autocmd!
    autocmd FileType css,scss,html
                \  set expandtab
                \| set tabstop=2
                \| set shiftwidth=2
augroup END
" }}}

" Language: Javascript ================================================= {{{
augroup JS_IDE
    autocmd!
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FileType javascript,javascriptreact,jsontypescript,typescript,typescriptreact
                \  set tabstop=2
                \| set expandtab
                \| set shiftwidth=2
augroup END
" }}}

" Language: Markdown ================================================= {{{
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
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

" LUA BABYYYYY
lua require('init')
