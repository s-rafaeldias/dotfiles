local telescope_builtin = require 'telescope.builtin'
local themes            = require 'telescope.themes'
local actions           = require 'telescope.actions'
local vimp              = require 'vimp'

require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            'node_modules/*',
            '*.pyc'
        },
        prompt_position = 'top',
        sorting_strategy = 'ascending',

        fzf = {
            fuzzy = true,
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        },

        layout_config = {
            preview_width = .65,
        },

        mappings = {
            i = { ["<C-q>"] = actions.send_to_qflist }
        },
    }
}

require("telescope").load_extension("git_worktree")
require('telescope').load_extension('fzf')


local search_dotfiles = function()
    telescope_builtin.find_files(themes.get_dropdown({
        hidden = true,
        layout_strategy = 'center',

        cwd = '~/.dotfiles',
        prompt_title = '< dotfiles >'
    }))
end


vimp.nnoremap({'override'}, '<C-P>', function() telescope_builtin.find_files{hidden = true} end)
vimp.nnoremap({'override'}, '<C-B>', function() telescope_builtin.buffers{} end)
vimp.nnoremap({'override'}, '<Leader>ev', function() search_dotfiles() end)

-- Quick actions for `file_browser`:
-- <C-E> creates a new file
vimp.nnoremap({'override'}, '<Leader>fb', function() telescope_builtin.file_browser() end)
