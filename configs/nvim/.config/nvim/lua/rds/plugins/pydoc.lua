local p = require("rds.utils").print_tbl
local get_node_text = vim.treesitter.get_node_text

local M = {}

---@return TSNode | nil
local function get_current_function_node() -- 0-index position
  local d = vim.treesitter.get_node()

  while d ~= nil do
    if d:type() == "function_definition" then
      print(vim.inspect(d:named_child_count()))
      break
    end

    d = d:parent()
  end

  if d == nil then
    print "d is nil"
    return
  end

  return d
end

---@param function_node TSNode
---@return string[]
local function get_arguments(function_node)
  local params = function_node:field("parameters")[1]
  local args = {}

  for v in params:iter_children() do
    if v:type() == "identifier" then
      local text = string.format("%s: Any", get_node_text(v, 0))
      table.insert(args, text)
    elseif v:type() == "typed_parameter" then
      print "t"
      local ident
      local type
      for k in v:iter_children() do
        if k:type() == "identifier" then
          ident = get_node_text(k, 0)
        elseif k:type() == "type" then
          type = get_node_text(k, 0)
        end
      end

      table.insert(args, string.format("%s: %s", ident, type))
    end
  end

  p(args)
  return args
end

function M.run()
  local f = get_current_function_node()
  if f then
    get_arguments(f)
  end
end
return M
