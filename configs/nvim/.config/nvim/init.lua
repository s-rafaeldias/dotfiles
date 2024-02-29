vim.loader.enable()

-- {{{ Basic opts
local set = vim.opt

set.guicursor = "a:block"

set.relativenumber = true
set.number = true
set.hlsearch = false
set.cursorline = true
set.colorcolumn = "80"
set.splitright = true
-- set.scrolloff = 10 -- add a "buffer" of 10 lines up and down the cursor position
set.signcolumn = "yes"
set.wrap = false
set.termguicolors = true
set.wrapscan = true
set.laststatus = 3
set.mouse = ""

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
-- }}}

-- {{{ Plugins
-- require "rds.packer"
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

  use "tpope/vim-projectionist"
  -- make `C-x` and `C-a` work with dates
  use "tpope/vim-speeddating"
  -- use "kyazdani42/nvim-web-devicons"
  -- Super duper plugin to help surrounding text-objects
  -- TODO: make this more natural.
  -- use "tpope/vim-surround"
  -- Show macros and registers
  use "junegunn/vim-peekaboo"
  -- Easier navigation between marked files
  use "ThePrimeagen/harpoon"
  -- use {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   requires = { { "nvim-lua/plenary.nvim" } },
  -- }
  -- Neovim lua setup
  use "folke/neodev.nvim"
  -- plugin for comments
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  }
  -- git interface
  use "tpope/vim-fugitive"
  -- Treesitter stuff
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-treesitter/playground", run = ":TSInstall query" }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "nvim-treesitter/nvim-treesitter-context"
  -- use "nvim-treesitter/nvim-treesitter-refactor"

  -- fuzzy finder
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "nvim-lua/telescope.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"

  -- UI for working with git worktree: https://dev.to/yankee/practical-guide-to-git-worktree-58o0
  use "ThePrimeagen/git-worktree.nvim"
  -- Install stuff when I'm lazy (or don't care too much for it): LSP, linter, formatters...
  use {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {}
    end,
  }

  use {
    "ThePrimeagen/refactoring.nvim",
    config = function()
      require("refactoring").setup {}
    end,
  }

  -- Snippets engine
  use { "L3MON4D3/LuaSnip", rtp = "." }

  -- Auto complete
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      -- "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      -- "petertriho/cmp-git",
    },
  }

  -- use "folke/trouble.nvim"
  use "neovim/nvim-lspconfig"
  use "nvim-lua/lsp_extensions.nvim"
  use "nvim-lua/lsp-status.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "ray-x/lsp_signature.nvim"

  -- use "simrat39/rust-tools.nvim"
  -- use "scalameta/nvim-metals"
  use "mfussenegger/nvim-jdtls"
  -- use { "elixir-tools/elixir-tools.nvim", tag = "stable" }
  use {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = "<C-Z>"
    end,
  }

  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "leoluz/nvim-dap-go"
  use "mfussenegger/nvim-dap-python"

  use "nvim-lualine/lualine.nvim"
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup {
        integrations = {
          vimwiki = true,
          harpoon = true,
          dap = {
            enabled = true,
            enable_ui = true,
          },
        },
      }
    end,
  }

  use {
    "epwalsh/obsidian.nvim",
    tag = "*", -- recommended, use latest release instead of latest commit
  }
end)
-- }}}

-- Mappings {{{
local rds_utils = require "rds.utils"
local tmux = require "harpoon.tmux"

-- Copy selected text (visual mode) to + register (clipboard)
vim.keymap.set("v", "<Leader>y", '"+y')

-- Use <Esc> to exit insert mode on terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Switch between related files. See `tpope/vim-projectionist`
vim.keymap.set("n", "<Leader>s", "<Cmd>A<CR>")
vim.keymap.set("n", "<Leader>S", "<Cmd>AV<CR>")

vim.keymap.set("n", "<Leader>e", "<Cmd>Ex!<CR>")

vim.keymap.set("n", "<leader>q", rds_utils.toggle_qflist)

vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

-- vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<Leader>a", "<Cmd>lua require'harpoon.mark'.add_file()<CR>")
vim.keymap.set("n", "<Leader>h", "<Cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>")

vim.keymap.set("n", "<Leader><Leader>j", "<Cmd>lua require'harpoon.ui'.nav_file(1)<CR>")
vim.keymap.set("n", "<Leader><Leader>k", "<Cmd>lua require'harpoon.ui'.nav_file(2)<CR>")
vim.keymap.set("n", "<Leader><Leader>l", "<Cmd>lua require'harpoon.ui'.nav_file(3)<CR>")
vim.keymap.set("n", "<Leader><Leader>;", "<Cmd>lua require'harpoon.ui'.nav_file(4)<CR>")

vim.keymap.set("n", "<Leader><Leader>u", function()
  tmux.gotoTerminal(3)
end)

-- Make numbered jump add to jumplist
-- Ref: https://vi.stackexchange.com/a/7697
-- vim.cmd [[
--     nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
--     nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
-- ]]
vim.keymap.set("n", "k", function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. "<Up>"
  end
  return "<Up>"
end, {
  expr = true,
})

vim.keymap.set("n", "j", function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. "<down>"
  end
  return "<down>"
end, {
  expr = true,
})
-- }}}

-- autocmd {{{
local rds_group = vim.api.nvim_create_augroup("RDS", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = rds_group,
  desc = "Highlight yank",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.gohtml",
  command = "set filetype=html",
  group = rds_group,
  desc = "Set Go HTML template filetype as HTML",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.mli",
  command = "set filetype=ocamlinterface",
  group = rds_group,
  desc = "Set MLI files to ocamlinterface",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.gohtml",
  command = "set filetype=html",
  group = rds_group,
  desc = "Set Go HTML template filetype as HTML",
})
-- }}}

-- require "rds.opt"
-- require "rds.mappings"
-- require "rds.autocmd"

require "rds"
