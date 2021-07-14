-- vim.o  => :set
-- vim.wo => :setlocal
-- vim.go => :setglobal

local set = vim.o
local setlocal = vim.wo

set.relativenumber = true
set.number = true
set.hlsearch = false
set.hidden = true
set.cursorline = true
set.showmatch = true
set.splitright = true
set.scrolloff = 10
set.signcolumn = "yes"
set.wrap = false
set.termguicolors = true

set.tabstop = 4
set.expandtab = true
set.shiftwidth = 4
set.softtabstop = 4

vim.opt.listchars = {
    eol = "↵",
    tab = "↦ ",
    trail = "~",
    extends = ">",
    precedes = "<"
}
set.list = true

set.timeoutlen = 300
set.ttimeoutlen = 0
set.updatetime = 40

-- set.errorbells = false
-- set.visualbell = false

vim.opt.completeopt:remove("preview")
set.completeopt = "menuone,noinsert,noselect"

set.swapfile = false
set.directory = "."
-- set.backup = false
set.undofile = true

vim.opt.wildignore:append("*node_modules*,_site,*/__pycache__/,*/venv/*,*/target/*,*/.vim$,~$,*.log,*.aux,*.cls,*.aux,*.bbl,*.blg,*.fls,*.fdb*/,*.toc,*.out,*.glo,*.log,*.ist,*fdb_latexmk")

set.diffopt = "vertical"

-- TODO: better way to do this?
vim.cmd [[
    autocmd FileType * setlocal formatoptions-=cro
]]

vim.g.mapleader = " "
vim.g["python3_host_prog"] = vim.env.HOME.."/miniconda3/envs/neovim/bin/python"
vim.g["python_host_prog"] = vim.env.HOME.."/miniconda3/envs/neovim2/bin/python"

vim.cmd [[ colorscheme gruvbox ]]
