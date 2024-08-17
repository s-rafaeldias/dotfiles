setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab

" shortcut for `err` handling in go
" This is not well formatted but gofmt is there for it
ab ee if err != nil {<cr>panic(err)<cr> }
