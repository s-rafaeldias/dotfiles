-- Semi plugin for note taking
-- Goals:
-- Simple to use
-- Markdown based
-- No bells and whistles (like vim-wiki, neorg)
-- Focus on note taking only: no tasks, calendars and so on

-- require("hologram").setup {
--   auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
-- }

vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_folding = "expr:quick"
vim.g.vimwiki_auto_header = 1
vim.g.vimwiki_list = {
  {
    path = "~/workspace/notes/",
    links_space_char = "_",
    syntax = "markdown",
  },
}
