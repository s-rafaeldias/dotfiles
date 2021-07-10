" Plugins: ================================================= {{{
call plug#begin()
" Essentials
Plug 'rbgrouleff/bclose.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'svermeulen/vimpeccable'
Plug 'gruvbox-community/gruvbox'
Plug 'szw/vim-maximizer'
Plug 'famiu/nvim-reload'

"Plug 'tpope/vim-commentary'
"Plug 'JoosepAlviste/nvim-ts-context-commentstring'


" Git
Plug 'tpope/vim-fugitive'
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'

" Telescope
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Debug
" Plug 'puremourning/vimspector'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

Plug '/Users/rafael/workspace/projects/nvim-remote-container'

" Languages
" Plug 'Olical/conjure'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'mattn/emmet-vim', { 'for': 'html' }
" Plug 'cakebaker/scss-syntax.vim'
Plug 'euclidianAce/BetterLua.vim'
Plug 'nathangrigg/vim-beancount'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
" Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'json', 'typescriptreact', 'javascriptreact'] }
" Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'simrat39/rust-tools.nvim'

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
set softtabstop=4

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

set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk

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
inoremap <silent><expr> <CR> compe#confirm('<CR>')
" }}}

" NORMAL MODE mappings ================================================= {{{
" Reload vim config
" nnoremap <leader>sv :source $MYVIMRC<CR>

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

nnoremap <F2> :luafile %<CR>
" }}}

" VISUAL MODE mappings ================================================= {{{
" Copy selected text to + register (clipboard)
vnoremap <Leader>y "+y
vnoremap D "_d
" }}}

" TERMINAL mappings ================================================= {{{
tnoremap <Esc> <C-\><C-n>
tnoremap <C-C> <C-\><C-n>
" }}}

nnoremap <leader>m :MaximizerToggle!<CR>
let g:maximizer_set_default_mapping = 0
let g:NERDSpaceDelims = 1
let g:NERDCustomDelimiters = { 'fish': { 'left': '#' } }

" Plugin: LSP ================================================= {{{
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_ignore_case = 1
" let g:completion_enable_snippet = ''
" }}}

" Plugin: kien/rainbow_parentheses.vim ================================================= {{{
autocmd FileType * RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" }}}

let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Language: Go ================================================= {{{
augroup GO_IDE
    autocmd!
    autocmd FileType go setlocal noexpandtab
augroup END
" }}}

" Language: HTML/CSS ================================================= {{{
augroup HTML_CSS_IDE
    let g:user_emmet_mode='inv'
    let g:user_emmet_expandabbr_key='<Tab>'
    autocmd!
    autocmd FileType css,scss,html
                \| set tabstop=2
                \| set shiftwidth=2
augroup END
" }}}

" Language: Javascript ================================================= {{{
augroup JS_IDE
    autocmd!
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd FileType javascript,javascriptreact,jsontypescript,typescript,typescriptreact
                \| set tabstop=2
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
                \| set foldmethod=marker
augroup END
" }}}


" LUA BABYYYYY
lua require('init')
