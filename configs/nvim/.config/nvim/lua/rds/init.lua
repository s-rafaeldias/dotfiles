require "rds.plugins.pydoc"

function R()
  require"rds.utils".reload("rds.plugins.pydoc")
  require "rds.plugins.pydoc".run()
end
