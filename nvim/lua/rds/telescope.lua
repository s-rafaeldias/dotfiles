-- local vimp       = require 'vimp'
local telescope_builtin  = require 'telescope.builtin'
local actions = require 'telescope.actions'

require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            'node_modules/*',
            '*.pyc',
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
        }
    }
}

local M = {}

M.search_dotfiles = function()
    telescope_builtin.find_files {
        cwd = '~/.dotfiles',
        prompt_title = '< dotfiles >'
    }
end

-- things I usually search/want to search:
-- TODOs (maybe add then to quicklist)


-- vimp.nnoremap('<C-P>', function() telescope_builtin.find_files{} end)
return M
