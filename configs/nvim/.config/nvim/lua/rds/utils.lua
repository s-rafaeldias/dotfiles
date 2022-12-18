local M = {}

function M.reload(pkg)
  package.loaded[pkg] = nil
  return require(pkg)
end

function M.print_tbl(v)
  print(vim.inspect(v))
end

---@param prompt string
---@return string
function M.input(prompt)
  local result
  vim.ui.input({ prompt = prompt }, function(input)
    result = input
  end)
  return result
end

---@param prompt string
---@param default_value string
---@return string
function M.input_with_default(prompt, default_value)
  local result = M.input(prompt)

  return result or default_value
end

---@return boolean
function M.is_working_machine()
  return vim.env["WORKING_MACHINE"] ~= nil
end

function M.toggle_qflist()
  local qf_exists = false

  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end

  if qf_exists == true then
    vim.cmd "cclose"
  elseif not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  else
    vim.notify "Quickfix list empty"
  end
end

return M
