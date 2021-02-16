local vimp       = require('vimp')
local telescope  = require('telescope.builtin')

require('rds.lsp')
require('rds.snippets')

-- switch between `find_files` and `git_files` using the same mapping
vimp.nnoremap('<C-P>', function()
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/git.lua#L141 
    local cwd = vim.loop.cwd()
    local git_root = vim.fn.systemlist("git -C "..cwd.." rev-parse --show-toplevel")[1]

    if vim.v.shell_error ~= 0 then
        telescope.find_files{}
    else
        telescope.git_files{}
    end
end)
