local Worktree = require("git-worktree")
local Path = require('plenary.path')
local Job = require('plenary.job')

-- Enable full logs
vim.g.git_worktree_log_level = 'trace'

-- Since I use tmux all the time, here is a possible fix for this
-- There are two types of sessions I use:
-- 1: Every single window is from the same root dir
-- 2: Windows with diferent root dirs. (Some windows for backend and some for fronted for example)

-- The simple case is 1: simply send a command to change to the new git worktree dir
-- Case 2 has some catches, but for simplicity I prefix related windows with `foo#` (front#editor, back#editor etc)

local tmux_case = function(windows)
end

Worktree.on_tree_change(function (op, metadata)
    -- check if in a tmux session using $TMUX
    if vim.env.TMUX then
        if op == Worktree.Operations.Switch then
            local windows
            Job:new({
                command = "tmux",
                args = { "list-windows" },
                on_exit = function (j, _return_val)
                    windows = j:result()
                end,
            }):sync()

            -- check if is case 1 or 2
            -- send a SIGTERM for related panes in all related windows
            -- change dir
            -- maybe use history to run last command?
        end
    end
end)

