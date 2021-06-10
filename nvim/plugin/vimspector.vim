nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>m :MaximizerToggle!<CR>

nmap <F4> <Plug>VimspectorToggleBreakpoint
nmap <F9> <Plug>VimspectorStepOut
nmap <F8> <Plug>VimspectorStepOver
nmap <F10> <Plug>VimspectorStepInto

nnoremap <F7> :call vimspector#Continue()<CR>

autocmd BufWinEnter vimspector.* :TSBufDisable highlight
