local utils = require "rds.utils"

local function create_new_route()
  local route = utils.input "Route path: "
  local cwd = vim.uv.cwd()

  local path = cwd .. "/" .. route
  print(path)

  vim.fn.system("mkdir -p " .. path)
  vim.fn.system("touch" .. path .. "{page,loading}.tsx")
end

vim.api.nvim_create_user_command("NextNewRoute", create_new_route, {})
