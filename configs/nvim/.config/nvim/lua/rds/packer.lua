require("packer").startup(function(use)
  -- Essentials {{{
  use "wbthomason/packer.nvim"
  use "tpope/vim-projectionist"
  -- make `C-x` and `C-a` work with dates
  use "tpope/vim-speeddating"
  -- use "kyazdani42/nvim-web-devicons"
  -- Super duper plugin to help surrounding text-objects
  use "tpope/vim-surround"
  -- Show macros and registers
  use "junegunn/vim-peekaboo"
  -- Easier navigation between marked files
  use "ThePrimeagen/harpoon"
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
  -- }}}

  -- Good to have {{{
  -- UI for working with git worktree: https://dev.to/yankee/practical-guide-to-git-worktree-58o0
  use "ThePrimeagen/git-worktree.nvim"
  -- Install stuff when I'm lazy (or don't care too much for it): LSP, linter, formatters...
  use {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {}
    end,
  }
  -- use "williamboman/mason-lspconfig.nvim"
  -- use "WhoIsSethDaniel/mason-tool-installer.nvim"

  -- Snippets engine
  use { "L3MON4D3/LuaSnip", rtp = "." }
  -- use "rafamadriz/friendly-snippets"

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

  -- LSP stuff {{{2
  -- use "folke/trouble.nvim"
  use "neovim/nvim-lspconfig"
  use "nvim-lua/lsp_extensions.nvim"
  use "nvim-lua/lsp-status.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "ray-x/lsp_signature.nvim"
  -- }}}

  -- }}}

  -- Language specifics {{{
  -- use "NoahTheDuke/vim-just"
  -- use "fatih/vim-go"
  use "simrat39/rust-tools.nvim"
  -- use "scalameta/nvim-metals"
  use {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = "<C-Z>"
    end,
  }

  -- Debugging {{{2
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "leoluz/nvim-dap-go"
  use "mfussenegger/nvim-dap-python"
  -- }}}
  -- }}}

  -- Theme {{{
  -- use "gruvbox-community/gruvbox"
  -- use "joshdick/onedark.vim"
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
  -- }}}

  -- Utils {{{
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"
  -- }}}
end)
