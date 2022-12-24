require("packer").startup(function(use)
  -- Utils
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "lewis6991/impatient.nvim"

  -- Theme
  -- use "gruvbox-community/gruvbox"
  use "joshdick/onedark.vim"
  -- statusline
  use "nvim-lualine/lualine.nvim"

  use "ThePrimeagen/harpoon"
  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  }
  -- Show macros and registers
  use "junegunn/vim-peekaboo"
  -- Super duper plugin to help surrounding text-objects
  use "tpope/vim-surround"
  use { "vimwiki/vimwiki", branch = "dev" }
  -- use "nvim-neorg/neorg"

  -- Git stuff {{{
  use {
    "tpope/vim-fugitive",
    requires = {
      -- GBrowse for GitHub
      "tpope/vim-rhubarb",
      -- GBrowse for GitLab
      -- "shumphrey/fugitive-gitlab.vim",
    },
  }
  use "TimUntersberger/neogit"
  use "ThePrimeagen/git-worktree.nvim"
  use {
    "akinsho/git-conflict.nvim",
    tag = "*",
  }
  -- }}}

  -- Debugging {{{
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "leoluz/nvim-dap-go"
  use "mfussenegger/nvim-dap-python"
  -- }}}

  -- LSP stuff {{{
  -- use "folke/trouble.nvim"
  use "neovim/nvim-lspconfig"
  use "nvim-lua/lsp_extensions.nvim"
  -- use "nvim-lua/lsp-status.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "j-hui/fidget.nvim"
  -- use "ray-x/lsp_signature.nvim"
  use "simrat39/rust-tools.nvim"
  use "scalameta/nvim-metals"
  -- }}}

  -- Auto complete stuff {{{
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      -- "petertriho/cmp-git",
    },
  }
  -- snippets
  use { "L3MON4D3/LuaSnip", rtp = "." }
  use "rafamadriz/friendly-snippets"
  -- }}}

  -- Treesitter {{{
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-treesitter/playground", run = ":TSInstall query" }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "nvim-treesitter/nvim-treesitter-context"
  use "p00f/nvim-ts-rainbow"

  use "Afourcat/treesitter-terraform-doc.nvim"
  -- }}}

  -- Telescope {{{
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "nvim-lua/telescope.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  -- }}}

  -- SQL stuff {{{
  -- use {
  --   "tpope/vim-dadbod",
  --   requires = {
  --     "kristijanhusak/vim-dadbod-completion",
  --     "kristijanhusak/vim-dadbod-ui",
  --   },
  -- }
  -- }}}

  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "WhoIsSethDaniel/mason-tool-installer.nvim"
end)
