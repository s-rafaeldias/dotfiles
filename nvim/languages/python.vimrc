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
