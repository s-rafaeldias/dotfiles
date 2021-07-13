-- making sure packer is installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

return require('packer').startup(function (use)
    -- Utils
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'rbgrouleff/bclose.vim'
    use 'famiu/nvim-reload'
    use 'svermeulen/vimpeccable'
    -- Essentials
    use 'jiangmiao/auto-pairs'
    use 'junegunn/vim-peekaboo'
    use 'junegunn/rainbow_parentheses.vim'
    use 'tpope/vim-surround'
    use 'Yggdroot/indentLine'
    use 'szw/vim-maximizer'
    -- Git
    use 'tpope/vim-fugitive'
    use 'TimUntersberger/neogit'
    use 'sindrets/diffview.nvim'
    use 'ThePrimeagen/git-worktree.nvim'
    -- Comments
    use 'scrooloose/nerdcommenter'
    -- Harpoon
    use 'ThePrimeagen/harpoon'
    -- Theme
    use 'gruvbox-community/gruvbox'
    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'nvim-lua/lsp_extensions.nvim'
    use 'ray-x/lsp_signature.nvim'
    -- use {'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}}
    -- Telescope
    use 'nvim-lua/telescope.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    -- Debug
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    -- Languages
    use 'euclidianAce/BetterLua.vim'
    use 'plasticboy/vim-markdown'
    use 'ekalinin/Dockerfile.vim'
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'
end)
