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
vim.keymap.set("n", "<Leader>x", "<cmd>.lua<cr>")
vim.keymap.set("v", "<Leader>x", ":lua<cr>")

vim.keymap.set("n", "<Leader>e", "<Cmd>Ex!<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("v", "<Leader>y", '"+y')

-- Make numbered jump add to jumplist
-- Ref: https://vi.stackexchange.com/a/7697
vim.cmd [[
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
]]

vim.g.user_emmet_leader_key = "<C-Z>"

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

-- TODO: move this to its own module?
-- Reusable code {{{
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
  vim.keymap.set("n", "<Leader>cf", "<Cmd>lua vim.lsp.buf.format()<CR>")
end
-- }}}

require("lazy").setup {
  spec = {
    {
      "folke/tokyonight.nvim",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      enabled = false,
      config = function()
        -- load the colorscheme here
        vim.cmd [[colorscheme tokyonight]]
      end,
    },
    {
      "catppuccin/nvim",
      lazy = false,
      config = function()
        require("catppuccin").setup {}

        vim.cmd [[ colorscheme catppuccin-mocha ]]
      end,
    },

    { "tpope/vim-speeddating" },
    { "tpope/vim-projectionist" },
    { "mattn/emmet-vim" },
    {
      "tpope/vim-fugitive",
      config = function()
        vim.keymap.set("n", "<Leader>gg", "<Cmd>G<CR>")
        vim.keymap.set("n", "<Leader>gp", "<Cmd>G pull<CR>")
        vim.keymap.set("n", "<Leader>gP", "<Cmd>G push<CR>")
      end,
    },
    { "williamboman/mason.nvim", opts = {} },

    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local harpoon = require "harpoon"
        harpoon:setup()

        vim.keymap.set("n", "<Leader>a", function()
          harpoon:list():add()
        end)
        vim.keymap.set("n", "<Leader>h", function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set("n", "<Leader><Leader>j", function()
          harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<Leader><Leader>k", function()
          harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<Leader><Leader>l", function()
          harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<Leader><Leader>;", function()
          harpoon:list():select(4)
        end)
      end,
    },

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

    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },
    { "leoluz/nvim-dap-go", dependencies = { "mfussenegger/nvim-dap" } },
    { "mfussenegger/nvim-jdtls", dependencies = { "mfussenegger/nvim-dap" } },
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
            fzf = {
              fuzzy = true,
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
          },
          pickers = {
            diagnostics = { theme = "ivy" },
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

    -- {{{ cmp
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-path" },
      },
      config = function()
        local cmp = require "cmp"

        local t = function(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
        end

        cmp.setup {
          completion = {
            -- keyword_length = 3,
            autocomplete = false,
          },

          preselect = cmp.PreselectMode.None,

          -- snippet = {
          --   expand = function(args)
          --     require("luasnip").lsp_expand(args.body)
          --   end,
          -- },

          mapping = {
            ["<C-q>"] = cmp.mapping.close(),
            ["<C-y>"] = cmp.mapping.confirm { select = true },
            ["<C-n>"] = cmp.mapping {
              c = function()
                if cmp.visible() then
                  cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                else
                  vim.api.nvim_feedkeys(t "<Down>", "n", true)
                end
              end,
              i = function()
                if cmp.visible() then
                  cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                else
                  -- Trigger completion manually only! https://github.com/hrsh7th/nvim-cmp/issues/178
                  cmp.complete()
                end
              end,
            },
            ["<C-p>"] = cmp.mapping {
              c = function()
                if cmp.visible() then
                  cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
                else
                  vim.api.nvim_feedkeys(t "<Up>", "n", true)
                end
              end,
              i = function()
                if cmp.visible() then
                  cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
                else
                  cmp.complete()
                end
              end,
            },
          },

          formatting = {
            format = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                buffer = "[Buf]",
                nvim_lua = "[NVIM_LUA]",
                path = "[Path]",
                luasnip = "[Snip]",
                nvim_lsp_signature_help = "🐍",
              })[entry.source.name]

              return vim_item
            end,
          },

          sources = {
            -- { name = "nvim_lsp_signature_help" },
            { name = "nvim_lsp" },
            -- { name = "luasnip" },
            -- { name = "nvim_lua" },
            { name = "path" },
            -- { name = "buffer" },
            -- { name = "cmp_git" },
          },
        }
      end,
    },
    -- }}}

    -- Elixir stuff {{{
    {
      "elixir-tools/elixir-tools.nvim",
      version = "*",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local elixir = require "elixir"
        local elixirls = require "elixir.elixirls"

        elixir.setup {
          nextls = { enable = false },
          elixirls = {
            enable = true,
            settings = elixirls.settings {
              dialyzerEnabled = true,
              enableTestLenses = true,
            },
            on_attach = custom_attach,
          },
          projectionist = { enable = true },
        }
      end,
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },
    -- }}}
  },
}
