local lspconfig = require "lspconfig"
local lsp = require "rds.lsp.common"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local sumneko_root_path = vim.fn.stdpath "cache" .. "/lspconfig/sumneko_lua/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

lspconfig.sumneko_lua.setup {
  -- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  on_attach = lsp.custom_attach,
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
