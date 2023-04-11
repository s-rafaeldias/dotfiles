local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
local mason_lspconfig = require "mason-lspconfig"

local custom_attach = function(client, bufnr)
  vim.notify("Attaching LSP: " .. client.name)
  local opts = { noremap = true }

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
  -- "elixirls",
  -- "pylsp",
  -- "rust_analyzer",
  "lua_ls",
  -- "sumneko_lua",
  "marksman",
  "powershell_es",
  "bashls",
}

mason_lspconfig.setup {
  ensure_installed = lsp_servers,
}

for _, lsp in ipairs(lsp_servers) do
  lspconfig[lsp].setup {
    on_attach = custom_attach,
  }
end

-- Python {{{
lspconfig["pylsp"].setup {
  on_attach = custom_attach,
  settings = {
    pylsp = {
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
          maxLineLength = 100,
        },
        flake8 = {
          enabled = false,
        },
        ruff = {
          enabled = true,
          lineLength = 100,
        },
        rope_autoimport = {
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
--   dap = {
--     adapter = require("rust-tools.dap").get_codelldb_adapter(
--       "/Users/rafael/personal/nvim/codelldb/extension/adapter/codelldb",
--       "/Users/rafael/personal/nvim/codelldb/extension/lldb/lib/liblldb.dylib"
--     ),
--   },
--   server = { on_attach = custom_attach },
-- }
-- }}}

-- Null-ls {{{
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.rustfmt,
    -- null_ls.builtins.formatting.mix,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.jq.with {
      args = { "--indent", "2" },
    },
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
  },
}
-- }}}
