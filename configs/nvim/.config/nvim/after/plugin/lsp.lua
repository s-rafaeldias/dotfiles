local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
local lsp_status = require "lsp-status"

require("neodev").setup()

lsp_status.register_progress()

local custom_attach = function(client, bufnr)
  -- vim.notify("Attaching LSP: " .. client.name)
  local opts = { noremap = true }

  require("lsp_signature").on_attach({
    bind = true,
    hint_prefix = "🐍 ",
    doc_lines = 0,
    floating_window = false,
  }, bufnr)

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
  "powershell_es",
  "bashls",
  -- "metals",
  "zls",
  "ocamllsp",
  "tsserver",
  "prismals",
  "elmls",
  "tailwindcss",
  "astro",
  "ruff_lsp",
}

for _, lsp in ipairs(lsp_servers) do
  lspconfig[lsp].setup {
    on_attach = custom_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  }
end

-- JS {{{
lspconfig["tsserver"].setup {
  on_attach = custom_attach,
}
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
require("rust-tools").setup {
  server = { on_attach = custom_attach },
  -- Link for fixing codelldb: https://github.com/vadimcn/codelldb/discussions/456#discussioncomment-874122
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      "/Users/rafael/.local/share/nvim/mason/packages/codelldb/codelldb",
      "/Users/rafael/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
    ),
  },
}
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
    -- Python
    -- null_ls.builtins.formatting.ruff,
    -- null_ls.builtins.diagnostics.ruff,
    -- Lua
    null_ls.builtins.formatting.stylua,
    -- Rust
    null_ls.builtins.formatting.rustfmt,
    -- TF
    null_ls.builtins.formatting.terraform_fmt,
    -- JSON
    null_ls.builtins.formatting.jq.with {
      args = { "--indent", "2" },
    },
    null_ls.builtins.formatting.rustywind,
    -- Bash
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
  },
}
-- }}}
