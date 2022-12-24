-- Semi plugin for note taking
-- Goals:
-- Simple to use
-- Markdown based
-- No bells and whistles (like vim-wiki, neorg)
-- Focus on note taking only: no tasks, calendars and so on

vim.g.vimwiki_list = {
  { path = "~/workspace/notes/", links_space_char = "_" },
}

local notes_group = vim.api.nvim_create_augroup("RDSNotes", {})

vim.api.nvim_create_autocmd({ "BufLeave", "BufDelete", "InsertLeave" }, {
  pattern = "*.wiki",
  command = "write",
  group = notes_group,
  desc = "Save wiki notes after leaving",
})
