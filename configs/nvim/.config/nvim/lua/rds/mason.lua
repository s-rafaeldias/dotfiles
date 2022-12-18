local mason = require "mason"

mason.setup {}

-- Ensure a few tools are setup.
-- For any LSP server, I will use `mason-lspconfig`
require('mason-tool-installer').setup{
  ensure_installed = {
    -- Python stuff
    "black",
  }
}
