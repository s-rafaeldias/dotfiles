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
  use "nvim-neotest/nvim-nio"

  use "tpope/vim-projectionist"
  -- make `C-x` and `C-a` work with dates
  use "tpope/vim-speeddating"
  -- use "kyazdani42/nvim-web-devicons"
  -- Super duper plugin to help surrounding text-objects
  -- TODO: make this more natural.
  use "tpope/vim-surround"
  -- Show macros and registers
  -- use "junegunn/vim-peekaboo"
  -- Easier navigation between marked files
  -- use "ThePrimeagen/harpoon"
  use "s-rafaeldias/harpoon"
  -- use {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   requires = { { "nvim-lua/plenary.nvim" } },
  -- }
  -- Neovim lua setup
  use "folke/neodev.nvim"
  -- git interface
  use "tpope/vim-fugitive"
  -- Treesitter stuff
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "nvim-treesitter/playground", run = ":TSInstall query" }
  use "nvim-treesitter/nvim-treesitter-textobjects"
  -- use "nvim-treesitter/nvim-treesitter-context"
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

  -- use {
  --   "ThePrimeagen/refactoring.nvim",
  --   config = function()
  --     require("refactoring").setup {}
  --   end,
  -- }

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
  -- use "mfussenegger/nvim-jdtls"
  -- use { "elixir-tools/elixir-tools.nvim", tag = "stable" }
  use {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = "<C-Z>"
    end,
  }

  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  -- use "leoluz/nvim-dap-go"
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

-- vim.keymap.set("n", "<C-D>", "<C-D>zz")
-- vim.keymap.set("n", "<C-U>", "<C-U>zz")

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

-- plugin: cmp {{{
local cmp = require "cmp"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup {
  completion = {
    keyword_length = 3,
    -- autocomplete = false,
  },

  preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
        else
          fallback()
          -- Trigger completion manually only! https://github.com/hrsh7th/nvim-cmp/issues/178
          -- cmp.complete()
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
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
        else
          fallback()
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
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer" },
    -- { name = "cmp_git" },
  },
}
-- }}}

-- plugin: dap {{{
local dap = require "dap"
local dap_python = require "dap-python"
local dapui = require "dapui"
-- local dap_go = require "dap-go"

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

dap_python.setup "~/miniconda3/envs/dap/bin/python"
dap_python.test_runner = "pytest"

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

-- dap_go.setup()

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

vim.keymap.set("n", "<Leader>dq", function()
  dapui.close {}
end)
vim.keymap.set("n", "<Leader>dt", function()
  local ft = vim.bo.filetype
  if ft == "python" then
    dap_python.test_method()
    -- elseif ft == "go" then
    --   dap_go.debug_test()
  end
end)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  -- dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  -- dapui.close()
end
-- }}}

-- plugin: git {{{
local Worktree = require "git-worktree"
local utils = require "rds.utils"

local create_git_worktree = function()
  local branch = utils.input "Branch name: "
  Worktree.create_worktree(branch, branch, "origin")
end

local group = vim.api.nvim_create_augroup("git", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  desc = "Autocmd to block code changes on main branch (because I always forget this xD)",
  -- TODO: better matching for files?
  pattern = "*.*",
  -- buffer = 0,
  callback = function()
    local branch = vim.fn.FugitiveHead()
    local block_main_flag = vim.env["BLOCK_MAIN"]

    if branch == "main" and block_main_flag == "1" then
      print "Main branch blocked"
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
    end
  end,
})

vim.keymap.set("n", "<Leader>gg", "<Cmd>G<CR>")
vim.keymap.set("n", "<Leader>gp", "<Cmd>G pull<CR>")
vim.keymap.set("n", "<Leader>gP", "<Cmd>G push<CR>")

-- Git worktree extension
-- TODO: do I really want to use worktrees or git stash?
-- I will try git stash (when needed) for now to simplify my workflow
-- vim.keymap.set("n", "<Leader>gl", "<Cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
-- vim.keymap.set("n", "<Leader>ga", "<Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")
-- vim.keymap.set("n", "<Leader>gn", create_git_worktree)
vim.keymap.set("n", "<Leader>gl", "<Cmd>lua require('telescope.builtin').git_branches()<CR>")
-- vim.keymap.set("n", "<Leader>ga", "<Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")
-- vim.keymap.set("n", "<Leader>gn", create_git_worktree)
-- }}}

-- plugin: lsp {{{
local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
local lsp_status = require "lsp-status"

require("neodev").setup()

lsp_status.register_progress()

local custom_attach = function(client, bufnr)
  -- vim.notify("Attaching LSP: " .. client.name)
  local opts = { noremap = true }

  -- require("lsp_signature").on_attach({
  --   bind = true,
  --   hint_prefix = "🐍 ",
  --   doc_lines = 0,
  --   floating_window = false,
  -- }, bufnr)

  lsp_status.on_attach(client)

  local function definition_split()
    -- TODO: check how many splits we have and add some smart logic here
    vim.cmd "vs"
    vim.lsp.buf.definition()
  end

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "", { callback = definition_split, noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<Cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>rr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ff", "<Cmd>lua vim.lsp.buf.format { async=true }<CR>", opts)
end

local lsp_servers = {
  "clangd",
  "jsonls",
  "gopls",
  "terraformls",
  -- "pylsp",
  -- "rust_analyzer",
  "lua_ls",
  -- "sumneko_lua",
  "marksman",
  -- "powershell_es",
  "bashls",
  -- "metals",
  "zls",
  -- "ocamllsp",
  "tsserver",
  "vuels",
  -- "prismals",
  -- "elmls",
  "tailwindcss",
  -- "astro",
  "ruff_lsp",
}

for _, lsp in ipairs(lsp_servers) do
  lspconfig[lsp].setup {
    on_attach = custom_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  }
end

-- Elixir {{{
-- require("elixir").setup {
--   nextls = {
--     enable = false,
--     on_attach = custom_attach,
--     init_options = {
--       experimental = {
--         completions = {
--           enable = true, -- control if completions are enabled. defaults to false
--         },
--       },
--     },
--   },
--   credo = { enable = true },
--   elixirls = { enable = true, on_attach = custom_attach },
-- }
-- }}}

-- Python {{{
lspconfig["pylsp"].setup {
  on_attach = custom_attach,
  settings = {
    pylsp = {
      plugins = {
        -- TODO: remove this after formatter is added to ruff-lsp
        black = {
          enabled = true,
          line_length = 80,
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
  },
}
-- }}}

-- Lua {{{
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig["lua_ls"].setup {
  -- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  on_attach = custom_attach,
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim", "love" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
-- }}}

-- Arduino {{{
-- lspconfig["arduino_language_server"].setup {
--   on_attach = custom_attach,
--   cmd = {
--     "arduino-language-server",
--     "-cli-config",
--     "/Users/rafael/Library/Arduino15/arduino-cli.yaml",
--     "-fqbn",
--     "esp8266:esp8266:nodemcu",
--     "-cli",
--     "arduino-cli",
--     "-clangd",
--     "clangd",
--   },
-- }
-- }}}

-- Markdown {{{
lspconfig["marksman"].setup {
  on_attach = custom_attach,
  filetypes = { "markdown", "vimwiki" },
}
-- }}}

-- Rust {{{
-- require("rust-tools").setup {
--   server = { on_attach = custom_attach },
--   -- Link for fixing codelldb: https://github.com/vadimcn/codelldb/discussions/456#discussioncomment-874122
--   dap = {
--     adapter = require("rust-tools.dap").get_codelldb_adapter(
--       "/Users/rafael/.local/share/nvim/mason/packages/codelldb/codelldb",
--       "/Users/rafael/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
--     ),
--   },
-- }
-- }}}

-- Metals (scala) {{{
-- local metals_config = require("metals").bare_config()
-- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
-- metals_config.on_attach = custom_attach
-- metals_config.init_options.statusBarProvider = "on"
--
-- local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   -- NOTE: You may or may not want java included here. You will need it if you
--   -- want basic Java support but it may also conflict if you are using
--   -- something like nvim-jdtls which also works on a java filetype autocmd.
--   pattern = { "scala", "sbt" },
--   callback = function()
--     require("metals").initialize_or_attach(metals_config)
--   end,
--   group = nvim_metals_group,
-- })
-- }}}

-- Null-ls {{{
null_ls.setup {
  sources = {
    -- Lua
    null_ls.builtins.formatting.stylua,
    -- Rust
    -- null_ls.builtins.formatting.rustfmt,
    -- TF
    null_ls.builtins.formatting.terraform_fmt,
    -- JSON
    null_ls.builtins.formatting.jq.with {
      args = { "--indent", "2" },
    },
    -- null_ls.builtins.formatting.rustywind,
    -- null_ls.builtins.formatting.ocamlformat,
    -- null_ls.builtins.formatting.zigfmt,
    -- Bash
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
  },
}
-- }}}
-- }}}

-- plugin: snippets {{{
local ls = require "luasnip"
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local tt = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require "luasnip.util.events"
-- local ai = require "luasnip.nodes.absolute_indexer"
local fmt = require("luasnip.extras.fmt").fmt

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {
  silent = true,
})
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {
  silent = true,
})

local py_snips = require "rds.snippets.python"
ls.add_snippets("python", py_snips)

-- bash
ls.add_snippets("sh", {
  s(
    "bash",
    tt {
      "#!/bin/bash",
      "set -euo pipefail",
      "IFS=$'\\n\\t'",
    }
  ),
})

-- Go
ls.add_snippets("go", {
  s("todo", tt { "// TODO: " }, i(1)),
  s(
    "handler",
    fmt(
      [[
      func {}(w http.ResponseWriter, r *http.Request) {{
      	{}
      }}
      ]],
      { i(1), i(2) }
    )
  ),
  s(
    "err",
    fmt(
      [[
      if err != nil {{
      	{}
      }}
      {}
      ]],
      { i(1, "panic(err)"), i(2) }
    )
  ),
})
-- }}}

-- statusline {{{
vim.o.winbar = "%=%m %f"
-- local python_env = function()
--   -- TODO: remove conda usage (now is all via venv)
--   local env = vim.env.CONDA_DEFAULT_ENV
--   if env ~= nil then
--     return "(" .. env .. ")"
--   end
--   return ""
-- end

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
  -- options = { theme = "catppuccin" },
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
      -- "encoding",
      "require('harpoon.mark').status()",
      "filetype",
    },
  },
}
-- }}}

-- plugin: telescope {{{
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

require("telescope").load_extension "git_worktree"
require("telescope").load_extension "fzf"
-- require("telescope").load_extension "ui-select"
-- require("telescope").load_extension "refactoring"

local project_files = function()
  local in_git_repo = vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true"
  if in_git_repo then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files()
  end
end

vim.keymap.set("n", "<Leader>t", "<Cmd>Telescope<CR>")
vim.keymap.set("n", "<C-P>", project_files)
vim.keymap.set("n", "<leader>pf", require("telescope.builtin").find_files)

vim.keymap.set("n", "<C-F>", "<Cmd>lua require'telescope.builtin'.live_grep { hidden=true }<CR>")
vim.keymap.set("n", "<C-B>", "<Cmd>lua require'telescope.builtin'.buffers{}<CR>")
vim.keymap.set("n", "<leader>x", "<Cmd>lua require'telescope.builtin'.diagnostics{}<CR>")
vim.keymap.set({ "n", "x" }, "<leader>rf", function()
  require("telescope").extensions.refactoring.refactors()
end)
-- }}}

-- plugin: treesitter {{{
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
    "vimdoc",
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

-- require("treesitter-context").setup {}
-- }}}

-- require "rds.opt"
-- require "rds.mappings"
-- require "rds.autocmd"

require "rds"
