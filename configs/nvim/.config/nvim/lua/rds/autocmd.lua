-- Groups {{{
local rds_group = vim.api.nvim_create_augroup("RDS", {})
local rds_init_group = vim.api.nvim_create_augroup("RdsInit", {})
-- }}}

-- Autocmds {{{
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = rds_group,
  desc = "Highlight yank",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".envrc",
  group = rds_init_group,
  desc = "Set .envrc filetype to `sh`",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_option(bufnr, "filetype", "sh")
  end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   pattern = "*",
--   desc = "Enters main branch whenever we start nvim in a git bare repo",
--   group = rds_init_group,
--   callback = function()
--     local branch = vim.fn.FugitiveHead()
--     -- quit as fast as possible if I'm not on a git repo
--     if branch == "" then
--       return
--     end
--
--     local inside_worktree
--     vim.fn.jobstart({ "git", "rev-parse", "--is-inside-work-tree" }, {
--       stdout_buffered = true,
--       on_stdout = function(_, output)
--         inside_worktree = output[1]
--
--         if branch == "main" and inside_worktree == "false" then
--           require("git-worktree").switch_worktree "branches/main"
--         end
--       end,
--     })
--   end,
-- })
-- }}}
