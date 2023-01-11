local lspconfig = require "lspconfig"
local lsp = require "rds.lsp.common"

lspconfig["marksman"].setup {
  on_attach = lsp.custom_attach,
  filetypes = { "markdown", "vimwiki" },
}
