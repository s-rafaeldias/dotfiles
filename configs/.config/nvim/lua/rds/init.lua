require "rds.plugins.pydoc"
require "rds.plugins.notes"
require "rds.plugins.lsp"

function R()
  require("rds.utils").reload "rds.plugins.pydoc"
  require("rds.plugins.pydoc").run()
end
