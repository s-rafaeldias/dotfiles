local lspconfig = require "lspconfig"
local lsp = require "rds.lsp.common"

lspconfig["pylsp"].setup {
  on_attach = lsp.custom_attach,
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
          enabled = true,
        },
      },
    },
  },
}
