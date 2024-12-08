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

-- {{{ Plugins with lazy.nvim
-- {{{2 Bootstrap lazy.nvim
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
-- 2}}}

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
    {
      "neovim/nvim-lspconfig",
      config = function()
        local custom_attach = function(client, bufnr)
          vim.notify("Attaching LSP: " .. client.name)
          local opts = { noremap = true }
          local function definition_split()
            vim.cmd "vs"
            vim.lsp.buf.definition()
          end

          vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
          vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
          vim.keymap.set("n", "gD", "", { callback = definition_split, noremap = true })
          vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
          vim.keymap.set("n", "gs", "<Cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>", opts)
          vim.keymap.set("n", "<Leader>rr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
          vim.keymap.set("n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
          vim.keymap.set("v", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
          vim.keymap.set("n", "<Leader>ff", "<Cmd>lua vim.lsp.buf.format()<CR>", opts)
        end
      end,
    },
    { -- Fuzzy Finder (files, lsp, etc)
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

        local project_files = function()
          local _in_git_repo = vim.fn.system { "git", "rev-parse", "--is-inside-work-tree" }
          if vim.v.shell_error == 0 then
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
        vim.keymap.set("n", "<leader>?", "<Cmd>lua require'telescope.builtin'.diagnostics{}<CR>")
        -- vim.keymap.set({ "n", "x" }, "<leader>rf", function()
        --   require("telescope").extensions.refactoring.refactors()
        -- end)
      end,
    },
  },
}

-- }}}
