source $HOME/.config/nvim/plugins.vimrc
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
" let g:afterglow_italic_comments=1
" colorscheme afterglow
"set background=dark " for the dark version
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
            \ 'coc-solargraph',
            \ 'coc-yaml',
            \ 'coc-highlight',
            \ 'coc-tsserver',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-emmet',
            \ 'coc-elixir']

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

source $HOME/.config/nvim/languages/python.vimrc
source $HOME/.config/nvim/languages/go.vimrc
source $HOME/.config/nvim/languages/haskell.vimrc
source $HOME/.config/nvim/languages/js.vimrc
source $HOME/.config/nvim/languages/clojure.vimrc

" Language: Vimscript ================================================= {{{
autocmd FileType vim set expandtab
autocmd FileType vim set shiftwidth=4
autocmd FileType vim set softtabstop=4
autocmd FileType vim set tabstop=4
autocmd FileType vim set foldmethod=marker
" }}}

" Language: Markdown ================================================= {{{
let g:markdown_folding = 1
let g:markdown_enable_folding = 1
" }}}

