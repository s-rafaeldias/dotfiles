local Worktree = require "git-worktree"
-- local Job = require "plenary.job"
local utils = require "rds.utils"
-- local neogit = require "neogit"

-- require("gitsigns").setup {
--   keymaps = {},
-- }

local create_git_worktree = function()
  local branch = utils.input "Branch name: "
  Worktree.create_worktree("branches/" .. branch, branch, "origin")
end

local group = vim.api.nvim_create_augroup("git", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  desc = "Autocmd to block code changes on main branch (because I always forget this xD)",
  -- TODO: better matching for files?
  pattern = "*.*",
  -- buffer = 0,
  callback = function()
    local branch = vim.fn.FugitiveHead()
    local block_main_flag = vim.env["BLOCK_MAIN"]

    if branch == "main" and block_main_flag == "1" then
      print "Main branch blocked"
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
    end
  end,
})

return {
  create_git_worktree = create_git_worktree,
}
