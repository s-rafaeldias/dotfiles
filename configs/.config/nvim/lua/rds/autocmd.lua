local session_filename = "Session.vim"

local function persist_session()
  -- cannot use `show-toplevel` because some repos I work on are bare repos
  -- with git-worktree (https://git-scm.com/docs/git-worktree)
  local git_path = vim.fn.system "git rev-parse --git-common-dir" or ""
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

vim.api.nvim_create_user_command("Mks", persist_session, {})
