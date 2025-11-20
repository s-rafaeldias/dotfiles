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

set.diffopt:append { "linematch:60", "vertical" }

vim.o.winbar = "%=%m %f"

-- Providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.vim_json_conceal = 0

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

-- {{{ Keymaps
-- Execute current (lua) line and visual selection
vim.keymap.set("n", "<Leader>x", "<cmd>.lua<cr>")
vim.keymap.set("v", "<Leader>x", ":lua<cr>")

-- vim.keymap.set("n", "<Leader>e", "<Cmd>Ex!<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("v", "<Leader>y", '"+y')
vim.keymap.set("n", "<leader>q", function()
  local qf_exists = false

  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end

  if qf_exists then
    vim.cmd "cclose"
  elseif not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  else
    vim.notify "Quickfix list empty"
  end
end)
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
  vim.keymap.set("n", "gD", definition_split)
  vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")
  vim.keymap.set("n", "gs", "<Cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>")
  vim.keymap.set("n", "<Leader>cl", "<Cmd>lua vim.lsp.codelens.run()<CR>")
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
    {
      "nvim-lualine/lualine.nvim",
      config = function()
        local branch_color = function()
          local branch = require("lualine.components.branch.git_branch").get_branch()

          local block_main_flag = vim.env["BLOCK_MAIN"]

          if branch == "main" and block_main_flag then
            return { bg = "red" }
          elseif branch == "dev" or branch == "develop" then
            return { bg = "blue" }
          end

          return nil
        end

        require("lualine").setup {
          options = { theme = "catppuccin-mocha" },
          extensions = { "quickfix", "fugitive" },
          sections = {
            lualine_b = {
              {
                "branch",
                color = branch_color,
              },
              "diff",
              "diagnostics",
            },
            lualine_c = {
              {
                "filename",
                file_status = true, -- displays file status (readonly status, modified status)
                path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
              },
            },

            lualine_x = {
              -- "require'lsp-status'.status()",
              "encoding",
              "require('harpoon.mark').status()",
              "filetype",
            },
          },
        }
      end,
    },

    { "tpope/vim-speeddating" },
    {
      "tpope/vim-projectionist",
      config = function()
        vim.keymap.set("n", "<leader>s", "<Cmd>A<CR>")
        vim.keymap.set("n", "<leader>S", "<Cmd>AS<CR>")
      end,
    },
    { "mattn/emmet-vim" },
    {
      "stevearc/oil.nvim",
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      config = function()
        local oil = require "oil"
        oil.setup {
          view_options = {
            show_hidden = true,
            float = {
              max_width = 0.4,
              max_height = 0.4,
            },
          },
        }
        vim.keymap.set("n", "<leader>e", oil.toggle_float)
      end,
    },
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
        "saghen/blink.cmp",

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
          -- "clangd",
          "jsonls",
          "gopls",
          "pylsp",
          "lua_ls",
          "marksman",
          "bashls",
          "ts_ls",
          -- "vue_ls",
          "tailwindcss",
          "docker_compose_language_service",
          "intelephense",
          "ruby_lsp",
          "gdscript",
          -- "htmx",
        }

        local lspconfig = vim.lsp.config
        for _, lsp in ipairs(lsp_servers) do
          local base_config = {
            on_attach = custom_attach,
            capabilities = require("blink.cmp").get_lsp_capabilities(),
          }

          if lsp == "pylsp" then
            local python_config = vim.deepcopy(base_config)
            python_config.settings = {
              plsp = {
                plugins = {
                  black = {
                    enabled = true,
                  },
                  mypy = {
                    enabled = true,
                  },
                  isort = {
                    enabled = true,
                  },
                  pycodestyle = {
                    ignore = { "E501" },
                    maxLineLength = 80,
                  },
                  flake8 = {
                    enabled = false,
                  },
                  ruff = {
                    enabled = true,
                    lineLength = 80,
                  },
                  autopep = {
                    enabled = false,
                  },
                  rope_autoimport = {
                    enabled = false,
                  },
                  pyflakes = {
                    enabled = false,
                  },
                  mccabe = {
                    enabled = false,
                  },
                },
              },
            }

            base_config = python_config
          elseif lsp == "intelephense" then
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
          elseif lsp == "ts_ls" then
            local ts = vim.deepcopy(base_config)
            ts.init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                  languages = { "javascript", "typescript", "vue" },
                },
              },
            }
            ts.filetypes = {
              "javascript",
              "typescript",
              "vue",
            }
            base_config = ts
          end

          vim.lsp.config(lsp, base_config)
          vim.lsp.enable(lsp)
        end
      end,
    },

    {
      "mfussenegger/nvim-dap",
      config = function()
        local dap = require "dap"
        vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

        vim.keymap.set("n", "<Leader>dd", function()
          dap.continue()
        end)
        vim.keymap.set("n", "<Leader>db", function()
          dap.toggle_breakpoint()
        end)
        vim.keymap.set("n", "<Leader>dn", function()
          dap.step_over()
        end)
        vim.keymap.set("n", "<Leader>dp", function()
          dap.step_back()
        end)
        vim.keymap.set("n", "<Leader>di", function()
          dap.step_into()
        end)
        vim.keymap.set("n", "<Leader>do", function()
          dap.step_out()
        end)

        vim.keymap.set("n", "<Leader>dr", function()
          dap.repl.open()
        end)
        vim.keymap.set("n", "<Leader>dc", function()
          dap.run_to_cursor()
        end)
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      config = function()
        local dapui = require "dapui"
        local dap = require "dap"

        dapui.setup {
          layouts = {
            {
              elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
              },
              size = 40,
              position = "left",
            },
            {
              elements = {
                "console",
              },
              size = 10,
              position = "bottom",
            },
          },
        }

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open {}
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          -- dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          -- dapui.close()
        end
        vim.keymap.set("n", "<Leader>dq", function()
          dapui.close {}
        end)
      end,
    },
    {
      "mfussenegger/nvim-dap-python",
      dependencies = { "mfussenegger/nvim-dap" },
      ft = "python",
      config = function()
        local dap_python = require "dap-python"
        dap_python.setup(vim.fs.normalize "~/.local/pipx/venvs/debugpy/bin/python")
        dap_python.test_runner = "pytest"
        vim.keymap.set("n", "<Leader>dt", function()
          dap_python.test_method()
        end)
      end,
    },
    -- { "leoluz/nvim-dap-go", dependencies = { "mfussenegger/nvim-dap" } },
    {
      "mfussenegger/nvim-jdtls",
      ft = { "java" },
      dependencies = { "mfussenegger/nvim-dap" },
      -- config = function()
      -- local bundles = {
      --   "/Users/rafael/code/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.1.jar",
      -- }
      -- vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/rafael/code/vscode-java-test/server/*.jar", true), "\n"))
      --
      -- local java_config = {
      --   cmd = { "/Users/rafael/.local/bin/java-lsp/bin/jdtls" },
      --   root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
      --   on_attach = custom_attach,
      --
      --   init_options = {
      --     bundles = bundles,
      --   },
      -- }
      -- require("jdtls").start_or_attach(java_config)
      -- end,
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

        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.blade = {
          install_info = {
            url = "https://github.com/EmranMR/tree-sitter-blade",
            files = { "src/parser.c" },
            branch = "main",
          },
          filetype = "blade",
        }
        vim.cmd [[
  augroup BladeFiltypeRelated
    au BufNewFile,BufRead *.blade.php set ft=blade
  augroup END
  ]]

        ---@diagnostic disable-next-line: missing-fields
        treesitter.setup {
          auto_install = false,
          ignore_install = {},
          sync_install = false,
          ensure_installed = {
            "bash",
            "c",
            "cmake",
            "comment",
            "cpp",
            "dockerfile",
            "elixir",
            "eex",
            "heex",
            "embedded_template",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
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
            "blade",
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
            buffers = { theme = "ivy" },
            live_grep = { theme = "ivy" },
            git_files = { theme = "ivy" },
            lsp_document_symbols = { theme = "ivy" },
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
        vim.keymap.set("n", "<Leader>gl", "<Cmd>lua require('telescope.builtin').git_branches()<CR>")
        -- vim.keymap.set({ "n", "x" }, "<leader>rf", function()
        --   require("telescope").extensions.refactoring.refactors()
        -- end)
      end,
    },
    -- }}}

    -- -- {{{ cmp
    -- {
    --   "hrsh7th/nvim-cmp",
    --   dependencies = {
    --     { "hrsh7th/cmp-nvim-lsp" },
    --     { "hrsh7th/cmp-path" },
    --   },
    --   config = function()
    --     local cmp = require "cmp"
    --
    --     local t = function(str)
    --       return vim.api.nvim_replace_termcodes(str, true, true, true)
    --     end
    --
    --     cmp.setup {
    --       completion = {
    --         -- keyword_length = 3,
    --         autocomplete = false,
    --       },
    --
    --       preselect = cmp.PreselectMode.None,
    --
    --       -- snippet = {
    --       --   expand = function(args)
    --       --     require("luasnip").lsp_expand(args.body)
    --       --   end,
    --       -- },
    --
    --       mapping = {
    --         ["<C-q>"] = cmp.mapping.close(),
    --         ["<C-y>"] = cmp.mapping.confirm { select = true },
    --         ["<C-n>"] = cmp.mapping {
    --           c = function()
    --             if cmp.visible() then
    --               cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
    --             else
    --               vim.api.nvim_feedkeys(t "<Down>", "n", true)
    --             end
    --           end,
    --           i = function()
    --             if cmp.visible() then
    --               cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
    --             else
    --               -- Trigger completion manually only! https://github.com/hrsh7th/nvim-cmp/issues/178
    --               cmp.complete()
    --             end
    --           end,
    --         },
    --         ["<C-p>"] = cmp.mapping {
    --           c = function()
    --             if cmp.visible() then
    --               cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
    --             else
    --               vim.api.nvim_feedkeys(t "<Up>", "n", true)
    --             end
    --           end,
    --           i = function()
    --             if cmp.visible() then
    --               cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
    --             else
    --               cmp.complete()
    --             end
    --           end,
    --         },
    --       },
    --
    --       formatting = {
    --         format = function(entry, vim_item)
    --           vim_item.menu = ({
    --             nvim_lsp = "[LSP]",
    --             buffer = "[Buf]",
    --             nvim_lua = "[NVIM_LUA]",
    --             path = "[Path]",
    --             luasnip = "[Snip]",
    --             nvim_lsp_signature_help = "🐍",
    --           })[entry.source.name]
    --
    --           return vim_item
    --         end,
    --       },
    --
    --       sources = {
    --         -- { name = "nvim_lsp_signature_help" },
    --         { name = "nvim_lsp" },
    --         -- { name = "luasnip" },
    --         -- { name = "nvim_lua" },
    --         { name = "path" },
    --         -- { name = "buffer" },
    --         -- { name = "cmp_git" },
    --       },
    --     }
    --   end,
    -- },
    -- -- }}}

    -- {{{ blink.nvim
    {
      "saghen/blink.cmp",
      -- optional: provides snippets for the snippet source
      -- dependencies = 'rafamadriz/friendly-snippets',
      -- use a release tag to download pre-built binaries
      version = "v0.*",
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = { preset = "default" },

        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
        },

        cmdline = { enabled = false },

        sources = {
          -- min_keyword_length = 3,
          default = { "lsp", "path", "snippets", "buffer" },
        },

        completion = {
          list = {
            selection = { auto_insert = false, preselect = false },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },

          menu = {
            draw = {
              -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
              treesitter = { "lsp" },
            },
          },
        },
        -- experimental signature help support
        signature = { enabled = true },
      },
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
