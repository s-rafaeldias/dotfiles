-- Semi plugin for note taking
-- Goals:
-- Simple to use
-- Markdown based
-- No bells and whistles (like vim-wiki, neorg)
-- Focus on note taking only: no tasks, calendars and so on

vim.g.vimwiki_list = {
  {
    path = "~/workspace/notes/",
    links_space_char = "_",
    auto_header = 1,
  },
}

-- require("hologram").setup {
--   auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
-- }
