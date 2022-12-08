local lspconfig = require "lspconfig"
local lsp = require "rds.lsp.common"

lspconfig["arduino_language_server"].setup {
  on_attach = lsp.custom_attach,
  cmd = {
    "arduino-language-server",
    "-cli-config",
    "/Users/rafael/Library/Arduino15/arduino-cli.yaml",
    "-fqbn",
    "esp8266:esp8266:nodemcu",
    "-cli",
    "arduino-cli",
    "-clangd",
    "clangd",
  },
}
