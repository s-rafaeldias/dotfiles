-- TODO: make this flexible somehow (probably using capture groups)
local pprint = require("rds.utils").print_tbl
local get_node_text = vim.treesitter.get_node_text

local M = {}

---@return TSNode | nil
local function get_current_function_node()
  local node = vim.treesitter.get_node()

  while node ~= nil do
    if node:type() == "function_definition" then
      -- p(node:named_child_count())
      break
    end

    node = node:parent()
  end

  if node == nil then
    print "d is nil"
    return
  end

  return node
end

---@param function_node TSNode
---@return string[]
local function get_arguments(function_node)
  local params = function_node:field("parameters")[1]
  local args = {}

  -- TODO: get *args and **kwargs
  -- TODO: get return type

  for v in params:iter_children() do
    local t = v:type()

    if t == "identifier" then
      local text = string.format(":param %s: {}", get_node_text(v, 0))
      table.insert(args, text)
    elseif t == "typed_parameter" then
      local ident
      local type
      for k in v:iter_children() do
        if k:type() == "identifier" then
          ident = get_node_text(k, 0)
        elseif k:type() == "type" then
          type = get_node_text(k, 0)
        end
      end

      table.insert(args, string.format(":param %s: {}", ident))
      table.insert(args, string.format(":type %s: %s", ident, type))
    end

    -- pprint(args)
    return args
  end
end

---@param node TSNode
---@return string
local function get_return_type(node)
  local ret_type = node:field("return_type")[1]

  if not ret_type then
    pprint "No return type defined"
    return ""
  end

  for v in ret_type:iter_children() do
    local ident = get_node_text(v, 0)
  end

  return ""
end

function M.run()
  local f = get_current_function_node()
  if not f then
    return
  end

  get_arguments(f)
  get_return_type(f)
end
return M
