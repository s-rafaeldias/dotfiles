local Worktree = require "git-worktree"
local Path = require "plenary.path"
local Job = require "plenary.job"

-- Enable full logs
-- vim.g.git_worktree_log_level = "trace"

-- Worktree.on_tree_change(function(op, metadata)
-- local is_poupex_dag = not not (string.find(vim.loop.cwd(), "/workspace/poupex/dags.git", 1, true))
-- print("HEY", string.find(vim.loop.cwd(), "/workspace/poupex/dags.git", 1, true))

-- if op == Worktree.Operations.Create and is_poupex_dag then
-- Job
-- :new({
-- command = "pip",
-- args = { "install", "-r", "requirements.txt" },
-- on_exit = function()
-- print "Pip installed run successfully!"
-- end,
-- })
-- :start()
-- end
-- end)
