require("fidget").setup {}

vim.o.winbar = "%=%m %f"

local python_env = function()
  local env = vim.env.CONDA_DEFAULT_ENV
  if env ~= nil then
    return "(" .. env .. ")"
  end
  return ""
end

local branch_color = function(section)
  local branch = require("lualine.components.branch.git_branch").get_branch()

  if branch == "main" then
    return { bg = "red" }
  elseif branch == "dev" or branch == "develop" then
    return { bg = "blue" }
  end

  return nil
end

require("lualine").setup {
  options = { theme = "catppuccin" },
  extensions = { "quickfix", "fugitive" },
  sections = {
    lualine_b = {
      {
        "branch",
        color = branch_color,
      },
      "diff",
      "diagnostics",
    },
    lualine_c = {
      python_env,
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },

    lualine_x = {
      "encoding",
      "require('harpoon.mark').status()",
      "filetype",
    },
  },
}