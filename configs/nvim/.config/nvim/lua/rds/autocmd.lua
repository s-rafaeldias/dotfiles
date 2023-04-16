-- Basic autocmd {{{
local rds_group = vim.api.nvim_create_augroup("RDS", {})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = rds_group,
  desc = "Highlight yank",
})

-- }}}

-- Notes {{{
local notes_group = vim.api.nvim_create_augroup("RDSNotes", {})

vim.api.nvim_create_autocmd({ "BufLeave", "BufDelete", "InsertLeave" }, {
  pattern = "*.wiki",
  command = "write",
  group = notes_group,
  desc = "Save wiki notes after leaving",
})

vim.api.nvim_create_autocmd({ "BufWrite" }, {
  pattern = "*.wiki",
  command = "VimwikiTOC",
  group = notes_group,
  desc = "Update Table Of Contents (TOC) for wiki page",
})
-- }}}
