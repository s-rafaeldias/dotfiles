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

-- vim.api.nvim_create_autocmd({ "BufWrite" }, {
--   pattern = "*.wiki",
--   command = "VimwikiTOC",
--   group = notes_group,
--   desc = "Update Table Of Contents (TOC) for wiki page",
-- })
-- }}}

-- Sessions {{{
local session_filename = "Session.vim"
local sessions_group = vim.api.nvim_create_augroup("RDSession", {})

local function persist_session()
  -- cannot use `show-toplevel` because some repos I work on are bare repos
  -- with git-worktree (https://git-scm.com/docs/git-worktree)
  local git_path = vim.fn.system "git rev-parse --git-common-dir"
  git_path = string.gsub(git_path, "%s+", "")

  -- don't create session file for non-git folders
  if vim.v.shell_error ~= 0 then
    return
  end

  if git_path == "." or git_path == ".git" then
    vim.cmd [[ mks! ]]
    return
  end

  local cmd = "mks! " .. git_path .. "/" .. session_filename
  vim.cmd(cmd)
end

vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  callback = persist_session,
  group = sessions_group,
  desc = "Create session file before leaving",
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.findfile(session_filename) ~= "" then
      local cmd = "so " .. session_filename
      vim.cmd(cmd)
    end
  end,
  group = sessions_group,
  desc = "Load session file if it exists",
})
-- }}}
