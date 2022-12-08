local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
local lsp_common = require "rds.lsp.common"
-- local lsp_status = require "lsp-status"

-- require("lsp_signature").setup {
--   bind = true,
--   doc_lines = 0,
--   hint_enable = true,
--   floating_window = false,
--   hint_prefix = "🐍 ",
-- }

-- lsp_status.register_progress()

local servers = { "clangd", "jsonls", "gopls", "terraformls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_common.custom_attach,
  }
end

require("lspconfig").elixirls.setup {
  cmd = { "/Users/rafael/.local/bin/elixir-ls/language_server.sh" },
  on_attach = lsp_common.custom_attach,
}

require("rust-tools").setup {
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      "/Users/rafael/workspace/nvim/codelldb/extension/adapter/codelldb",
      "/Users/rafael/workspace/nvim/codelldb/extension/lldb/lib/liblldb.dylib"
    ),
  },
  server = { on_attach = lsp_common.custom_attach },
}

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.formatting.blue,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.mix,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.jq.with {
      args = { "--indent", "2" },
    },
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
  },
}

require "rds.lsp.python"
require "rds.lsp.lua"
require "rds.lsp.arduino"
require "rds.lsp.scala"
