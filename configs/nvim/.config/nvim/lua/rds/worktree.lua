local Worktree = require "git-worktree"
local Path = require "plenary.path"
local Job = require "plenary.job"

-- Create a "session" file at root repo after quitting
-- Add autocmd for opening and loading this file if exists
-- Add autocmd for closing vim and saving the session file (`:mks`)

-- TODO: how to get the root path from git when inside a worktree?
-- Have a specify filename for the session file (shada-file?)
