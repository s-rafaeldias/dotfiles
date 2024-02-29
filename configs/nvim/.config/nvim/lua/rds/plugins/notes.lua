-- Feature list:
-- Create new projects with index.md setup as a template
-- Archive projects easily
-- move notes easily between folders

local utils = require "rds.utils"
local BASE_PATH = "~/personal/obsidian/notes"

local function create_note()
  -- get type of note (projects, area, resoures/references, archive)
  -- TODO: create enum for projects
  local projects = { "1_projeto", "2_area", "3_resources", "4_archive" }
  local project_type = ""

  vim.ui.select(projects, {
    prompt = "Select project type:",
  }, function(choice)
    project_type = choice
  end)

  local sub_project_path = vim.fs.dir(vim.fs.joinpath(BASE_PATH, project_type))
  local sub_projects = {}
  for name, type in sub_project_path do
    if type == "directory" then
      table.insert(sub_projects, name)
    end
  end

  local sub_project_selected = ""
  vim.ui.select(sub_projects, {
    prompt = "Select subproject:",
  }, function(choice)
    sub_project_selected = choice
  end)

  local sub_project_selected = ""
  local note = utils.input "note name: "
  note = note .. ".md"

  local note_path = vim.fs.joinpath(BASE_PATH, project_type, sub_project_selected)
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(buf, note_path)

  -- given the type, get the "project" (subfolder)
  -- Create new note on this path
  -- add template?
  -- open new note
  -- save new note (will this trigger the template engine from obsidian.nvim?)
end

require("obsidian").setup {
  workspaces = {
    {
      name = "personal",
      path = BASE_PATH,
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
    -- print("path")
    -- utils.print_tbl(note.path)
    local project_path = note.path:parent()
    -- print("project path: ")
    -- utils.print_tbl(project_path)
    local project_name = vim.fs.basename(project_path.filename)
    -- print("project name:", project_name)

    -- Get group name
    local group_path = project_path:parent()
    local group_name = vim.fs.basename(group_path.filename)

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

vim.keymap.set("n", "<leader>nl", "<cmd>ObsidianQuickSwitch<CR>")
vim.keymap.set("n", "<leader>ns", "<cmd>ObsidianSearch<CR>")
vim.keymap.set("n", "<leader>nn", create_note)
