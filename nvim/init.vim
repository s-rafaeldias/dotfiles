" ===================================
" Plugins
" ===================================
call plug#begin()

""" General plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'wincent/command-t', { 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'junegunn/vim-easy-align'
" Deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

""" Language support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'sheerun/vim-polyglot'
" Python
Plug 'vim-python/python-syntax'
Plug 'davidhalter/jedi-vim'
Plug 'cjrh/vim-conda'
"Plug 'deoplete-plugins/deoplete-jedi'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}

""" Colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'jacoborus/tender.vim'
Plug 'rakr/vim-one'

" Initialize plugin system
call plug#end()


" ===================================
" General Settings
" ===================================
set relativenumber      " show relative numbers
set number              " show line numbers
set cursorline          " show a visual line under the cursor's current line
set cursorcolumn        " show a visual line under cursor's current column
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

syntax enable

if has('nvim')
    let g:python3_host_prog = '/home/rafael/miniconda3/envs/neovim/bin/python'
endif

let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'ruby': ['bundle', 'exec', 'solargraph', 'stdio'],
    \ }

let mapleader=","

" ===================================
" Colors
" ===================================
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

colorscheme one
set background=dark " for the dark version


" ===================================
"            Airline
" ===================================
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='one'
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1


" ===================================
" NerdTree
" ===================================
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2
map <C-D> :NERDTreeToggle<CR>


" ===================================
" Custom mappings
" ===================================
" Disable arrow keys
noremap  <Up> <NOP>
noremap! <Up> <Esc>
noremap  <Down> <NOP>
noremap! <Down> <Esc>
noremap  <Left> <NOP>
noremap! <Left> <Esc>
noremap  <Right> <NOP>
noremap! <Right> <Esc>

" Move line up
nnoremap - ddp
" Move line down
nnoremap _ ddkP
" Upper word on insert mode
inoremap <C-U> <ESC>bveUea
" Upper word on normal mode
nnoremap <C-U> bveUe
" Remap jk for exit Insert mode
inoremap kj <Esc>
inoremap <Esc> <NOP>

" highligth trailing spaces
map <Leader>w :execute "normal! :match Error " . '/\v\s+$/' <CR>


" ===================================
" Leader Shortcus
" ===================================
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
" Fn Shortcuts
" ===================================
set pastetoggle=<F2>
nmap <F8> :TagbarToggle<CR>


" ===================================
" Autocmd
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
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

autocmd BufWritePost * GitGutter


" ===================================
" Language: Python
" ===================================
let g:python_highlight_all=1
let g:jedi#completions_enabled = 0


" ===================================
" Language: Go
" ===================================
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
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'


" ===================================
" Language: Vimscript
" ===================================
au FileType vim set expandtab
au FileType vim set shiftwidth=4
au FileType vim set softtabstop=4
au FileType vim set tabstop=4


"function SetLSPShortcuts()
"  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  "nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  "nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  "nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  "nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  "nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  "nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  "nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  "nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  "nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
"endfunction()

"augroup LSP
  "autocmd!
  "autocmd FileType * call SetLSPShortcuts()
"augroup END

