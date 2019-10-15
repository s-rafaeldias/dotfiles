" Plugins
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
""" Colorscheme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'danilo-augusto/vim-afterglow'

""" Languages
" Dockerfile
Plug 'ekalinin/Dockerfile.vim', { 'for': 'dockerfile' }
" Python
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'psf/black'
Plug 'davidhalter/jedi-vim'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
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

" Initialize plugin system
call plug#end()

