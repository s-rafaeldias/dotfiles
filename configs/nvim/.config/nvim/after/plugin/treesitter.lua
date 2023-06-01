local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
  ensure_installed = {
    "scala",
    "sql",
    "elixir",
    "ruby",
    "go",
    "markdown",
    "lua",
    "python",
    "bash",
    "nix",
    "c",
    "cpp",
    "cmake",
    "dockerfile",
    "javascript",
    "json",
    -- "comment",
    -- "jsonc",
    "make",
    "query",
    "regex",
    "rst",
    "vim",
    "yaml",
    -- "tsx",
    -- "typescript",
    "terraform",
    "toml",
    "http",
    "rust",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
  },
  indent = {
    enable = false,
  },
  highlight = {
    enable = true,
  },
  playgroud = {
    enable = true,
  },
  -- rainbow = {
  --   enable = true,
  --   extended_mode = true,
  -- },
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = false,
    },
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      -- TODO: test this
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      -- goto_next_end = {
      --   ["<Leader>M"] = "@function.outer",
      --   ["]["] = "@class.outer",
      -- },
    },
    lsp_interop = {
      enable = true,
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
}

require("treesitter-context").setup {}
