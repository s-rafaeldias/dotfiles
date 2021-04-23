-- local vimp       = require 'vimp'
local telescope_builtin = require 'telescope.builtin'
local themes            = require 'telescope.themes'
local actions           = require 'telescope.actions'

require("telescope").load_extension("git_worktree")
require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            'node_modules/*',
            '*.pyc',
            '.git/*'
        },
        color_devicons = true,
        prompt_position = 'top',
        sorting_strategy = 'ascending',
        width = .25,

        layout_strategy = 'horizontal',
        layout_config = {
            preview_width = .65,
        },

        mappings = {
            i = { ["<C-q>"] = actions.send_to_qflist }
        },
    }
}


local M = {}

M.search_dotfiles = function()
    telescope_builtin.find_files(themes.get_dropdown({
        hidden = true,
        layout_strategy = 'center',

        cwd = '~/.dotfiles',
        prompt_title = '< dotfiles >'
    }))
end

-- things I usually search/want to search:
-- TODO: (maybe add then to quicklist)
M.todos = function()
    -- search all files looking for `TODO:` and add to quicklist
    vim.cmd [[ silent vimgrep! /TODO:/j **/*.* ]]
    telescope_builtin.quickfix()
end

-- Create a custom find_files
M.find_files = function(opts)
  telescope_builtin.find_files(opts)
  -- local find_command = {
      -- 'fd',
      -- '--type',
      -- 'f',
      -- '-H',
      -- '--no-ignore-vcs',
      -- '-E',
      -- '.git',
  -- }

  -- pickers.new(opts, {
      -- prompt_title = 'Find files',
      -- finder = finder.new_oneshot_job(find_command, opts),
      -- previewer = previewer.vim_buffer_cat.new(opts),
      -- sorter = sorter.get_fuzzy_file()
  -- }):find()
end


M.search_pi = function()
    local netrw_result = vim.api.nvim_exec(':Explore scp://pi@192.168.0.23/', {})
    print(vim.inspect(netrw_result))
end

return M
