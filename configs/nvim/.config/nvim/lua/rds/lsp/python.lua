local lspconfig = require "lspconfig"
local lsp = require "rds.lsp.common"

lspconfig["pylsp"].setup {
  on_attach = lsp.custom_attach,
  cmd = {
    "docker",
    "exec",
    "-i",
    "pydev",
    "pylsp",
  },
  before_init = function(params)
    params.processId = vim.NIL
  end,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "E501" },
          maxLineLength = 100,
        },
        flake8 = {
          maxLineLength = 100,
          enabled = false,
        },
        ruff = {
          enabled = true,
        },
      },
    },
  },
}
