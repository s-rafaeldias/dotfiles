local set = vim.opt

-- Testing this
set.guicursor = "a:block"

set.relativenumber = true
set.number = true
set.hlsearch = false
set.cursorline = true
set.colorcolumn = "80"
set.splitright = true
-- set.scrolloff = 10 -- add a "buffer" of 10 lines up and down the cursor position
set.signcolumn = "yes"
set.wrap = false -- Don't wrap text when there is not enough space on buffer
set.termguicolors = true -- Enables 24-bit RGB on TUI
set.wrapscan = true
set.laststatus = 3
set.mouse = nil

set.tabstop = 4
set.expandtab = true
set.shiftwidth = 4
set.softtabstop = 4
set.autoindent = true
set.ignorecase = true
set.smartindent = true

-- By default, uses `marker` for folding
set.foldmethod = "marker"
-- To use treesitter folding, just add the `vim.cmd` bellow on `after/ftplugin/[lang].vim
-- vim.cmd [[
--   set foldmethod=expr
--   set foldexpr=nvim_treesitter#foldexpr()
--   set nofoldenable
-- ]]

set.listchars = {
  tab = "↦ ",
  trail = "~",
  extends = ">",
  precedes = "<",
}
set.list = true

set.timeoutlen = 300
set.ttimeoutlen = 0
set.updatetime = 40

set.shortmess:remove "F"
-- set.completeopt:remove "preview"
set.completeopt = "menuone,noinsert,noselect"

set.swapfile = false
set.directory = "."
-- set.backup = false
set.undofile = true

set.wildignore:append "*node_modules*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,~$,*.log,*.aux,*.cls,*.aux,*.bbl,*.blg,*.fls,*.fdb*/,*.toc,*.out,*.glo,*.log,*.ist,*fdb_latexmk"

vim.g.mapleader = " "

-- Git stuff
set.diffopt:append { "linematch:60", "vertical" }

-- Providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Disable conceal on json
-- vim.g.vim_json_conceal = 0

-- Colorscheme
vim.cmd [[ colorscheme catppuccin-macchiato ]]
-- vim.cmd [[ colorscheme kiss ]]
