vim.loader.enable()

-- {{{ Opts
local set = vim.opt

set.guicursor = "a:block"
set.cursorline = true
set.colorcolumn = "80"
set.relativenumber = true
set.number = true
set.signcolumn = "yes"

set.hlsearch = false
set.splitright = true
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
set.completeopt = "menuone,noinsert,noselect"

set.swapfile = false
set.directory = "."
set.undofile = true
set.undodir = vim.fn.expand "~/.undodir"

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
vim.g.vim_json_conceal = 0

-- Execute current (lua) line and visual selection
vim.keymap.set("n", "<Leader><Leader>x", "<cmd>.lua<cr>")
vim.keymap.set("v", "<Leader><Leader>x", ":lua<cr>")

vim.keymap.set("n", "<Leader>e", "<Cmd>Ex!<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("v", "<Leader>y", '"+y')

-- Make numbered jump add to jumplist
-- Ref: https://vi.stackexchange.com/a/7697
vim.cmd [[
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
]]

-- Colorscheme
-- vim.cmd [[ colorscheme tokyonight ]]
-- vim.cmd [[ colorscheme catppuccin-macchiato ]]
-- vim.cmd [[ colorscheme kiss ]]
-- }}}

-- {{{ autocmd's
local rds_group = vim.api.nvim_create_augroup("RDS", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = rds_group,
  desc = "Highlight yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- }}}

-- {{{ Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- }}}

require("lazy").setup {
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        -- load the colorscheme here
        vim.cmd [[colorscheme tokyonight]]
      end,
    },
    { "tpope/vim-speeddating" },
    { "tpope/vim-projectionist" },
    { "tpope/vim-fugitive" },
    { "williamboman/mason.nvim", opts = {} },

    -- {{{ lsp stuff
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        {
          "folke/lazydev.nvim",
          ft = "lua", -- only load on lua files
          opts = {
            library = {
              -- See the configuration section for more details
              -- Load luvit types when the `vim.uv` word is found
              { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
          },
        },
      },
      config = function()
        local custom_attach = function(client, bufnr)
          -- vim.notify("Attaching LSP: " .. client.name)
          local function definition_split()
            vim.cmd "vs"
            vim.lsp.buf.definition()
          end

          vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
          vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
          vim.keymap.set("n", "gD", "", { callback = definition_split, noremap = true })
          vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")
          vim.keymap.set("n", "gs", "<Cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>")
          vim.keymap.set("n", "<Leader>rr", "<Cmd>lua vim.lsp.buf.rename()<CR>")
          vim.keymap.set("n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>")
          vim.keymap.set("v", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>")
          vim.keymap.set("n", "<Leader>gf", "<Cmd>lua vim.lsp.buf.format()<CR>")
        end

        local lsp_servers = {
          "clangd",
          "jsonls",
          "gopls",
          -- "terraformls",
          -- "pylsp",
          -- "rust_analyzer",
          "lua_ls",
          -- "sumneko_lua",
          "marksman",
          -- "powershell_es",
          "bashls",
          -- "metals",
          -- "zls",
          -- "ocamllsp",
          "ts_ls",
          "volar",
          -- "prismals",
          -- "elmls",
          "tailwindcss",
          -- "astro",
          -- "ruff_lsp",
          -- "gdscript",
          -- "intelephense",
          -- "ruby_lsp",
          -- "htmx",
        }

        local lspconfig = require "lspconfig"
        for _, lsp in ipairs(lsp_servers) do
          local base_config = {
            on_attach = custom_attach,
            -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
          }

          if lsp == "intelephense" then
            local php_config = vim.deepcopy(base_config)
            php_config.filetypes = {
              "php",
              "blade",
            }
            base_config = php_config
          elseif lsp == "ruby_lsp" then
            local ruby_config = vim.deepcopy(base_config)
            ruby_config.init_options = {
              formatter = "standard",
              linters = { "standard" },
            }
            base_config = ruby_config
          end

          lspconfig[lsp].setup(base_config)
        end
      end,
    },
    -- }}}

    -- {{{ treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      dependencies = {
        { "nvim-treesitter/playground", build = ":TSInstall query" },
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
      config = function()
        local treesitter = require "nvim-treesitter.configs"
        treesitter.setup {
          auto_install = false,
          ignore_install = {},
          sync_install = false,
          ensure_installed = {
            "bash",
            -- "blade",
            "c",
            "cmake",
            "comment",
            "cpp",
            "dockerfile",
            "elixir",
            "git_config",
            "git_rebase",
            "gitcommit",
            "gitignore",
            "gitattributes",
            "go",
            "gomod",
            "gosum",
            "gotmpl",
            "html",
            "http",
            "java",
            "javascript",
            "json",
            "lua",
            "make",
            "markdown",
            "python",
            "query",
            "regex",
            "rst",
            "rust",
            "sql",
            "terraform",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
            "embedded_template",
            -- "jsonc",
          },
          indent = {
            enable = true,
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
          -- refactor = {
          --   highlight_definitions = {
          --     enable = true,
          --     -- Set to false if you have an `updatetime` of ~100.
          --     clear_on_cursor_move = false,
          --   },
          -- },

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
      end,
    },
    -- }}}

    -- {{{ telescope
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
        },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      config = function()
        local actions = require "telescope.actions"

        require("telescope").setup {
          defaults = {
            file_ignore_patterns = {
              "node_modules/*",
              "*.pyc",
              ".venv/*",
              ".mypy_cache/*",
              ".pytest_cache/*",
              "**/__pycache__/*",
              "__pycache__/*",
              ".DS_Store/",
              ".DS_Store",
              ".git/*",
            },
            sorting_strategy = "ascending",

            fzf = {
              fuzzy = true,
              override_generic_sorter = false, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },

            layout_config = {
              prompt_position = "top",
            },

            mappings = {
              i = { ["<C-q>"] = actions.send_to_qflist },
            },
          },

          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_dropdown {},
            },
          },
        }

        require("telescope").load_extension "fzf"
        require("telescope").load_extension "ui-select"

        vim.keymap.set("n", "<Leader>t", "<Cmd>Telescope<CR>")
        vim.keymap.set("n", "<C-P>", require("telescope.builtin").git_files)
        vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)

        vim.keymap.set("n", "<C-F>", "<Cmd>lua require'telescope.builtin'.live_grep { hidden=true }<CR>")
        vim.keymap.set("n", "<C-B>", "<Cmd>lua require'telescope.builtin'.buffers{}<CR>")
        vim.keymap.set("n", "<leader>?", "<Cmd>lua require'telescope.builtin'.diagnostics{}<CR>")
        -- vim.keymap.set({ "n", "x" }, "<leader>rf", function()
        --   require("telescope").extensions.refactoring.refactors()
        -- end)
      end,
    },
    -- }}}
  },
}
