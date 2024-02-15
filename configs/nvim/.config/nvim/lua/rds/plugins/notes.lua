-- Feature list:
-- Create new projects with index.md setup as a template
-- Archive projects easily
-- move notes easily between folders
--

local utils = require "rds.utils"
local base_path = "~/personal/obsidian/notes"

require("obsidian").setup {
  workspaces = {
    {
      name = "personal",
      path = base_path,
    },
  },
  daily_notes = {
    folder = "diary",
  },
  note_id_func = function(title)
    return title
  end,
  prepend_note_id = false,
  note_frontmatter_func = function(note)
    -- Add the title of the note as an alias.
    if note.title then
      note:add_alias(note.title)
    end

    -- Get project
    local project_path = note.path:parent()
    local project_name = vim.fs.basename(project_path:absolute())

    -- Get group name
    local group_path = project_path:parent()
    local group_name = vim.fs.basename(group_path:absolute())

    local out = {
      id = note.id,
      aliases = note.aliases,
      tags = note.tags,
      -- path = note.path,
      project = group_name .. "/" .. project_name,
    }

    -- `note.metadata` contains any manually added fields in the frontmatter.
    --
    -- So here we just make sure those fields are kept in the frontmatter.
    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
      for k, v in pairs(note.metadata) do
        out[k] = v
      end
    end

    return out
  end,
}

vim.keymap.set("n", "<leader>on", "<cmd>ObsidianQuickSwitch<CR>")
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>")
