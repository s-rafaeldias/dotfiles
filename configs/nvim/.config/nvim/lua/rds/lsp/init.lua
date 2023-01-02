local lspconfig = require "lspconfig"
local null_ls = require "null-ls"
local lsp_common = require "rds.lsp.common"
local mason_lspconfig = require "mason-lspconfig"

-- require("lsp_signature").setup {
--   bind = true,
--   doc_lines = 0,
--   hint_enable = true,
--   floating_window = false,
--   hint_prefix = "🐍 ",
-- }

mason_lspconfig.setup {
  ensure_installed = lsp_common.lsp_servers,
}

for _, lsp in ipairs(lsp_common.lsp_servers) do
  lspconfig[lsp].setup {
    on_attach = lsp_common.custom_attach,
  }
end

require "rds.lsp.python"
require "rds.lsp.lua"
require "rds.lsp.arduino"
require "rds.lsp.scala"

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
    -- python
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    -- lua
    null_ls.builtins.formatting.stylua,
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
