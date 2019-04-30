" Python config
" set tabs to have 4 spaces
setlocal ts=4
" indent when moving to the next line while writing code
setlocal autoindent
" expand tabs into spaces
setlocal expandtab
" when using the >> or << commands, shift lines by 4 spaces
setlocal shiftwidth=4
" enable all Python syntax highlighting features
let python_highlight_all = 1

setlocal completeopt-=preview
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "1"
let g:jedi#popup_select_first = 0
