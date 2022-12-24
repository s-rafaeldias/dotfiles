-- Groups {{{
local rds_group = vim.api.nvim_create_augroup("RDS", {})
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

-- }}}
