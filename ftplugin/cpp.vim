setlocal ts=4
setlocal autoindent
setlocal expandtab
setlocal shiftwidth=4

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" C/C++ config
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
