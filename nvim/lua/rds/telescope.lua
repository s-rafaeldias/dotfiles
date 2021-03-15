-- local vimp       = require 'vimp'
local telescope_builtin  = require 'telescope.builtin'
local themes = require 'telescope.themes'
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
        },

        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    }
}

require('telescope').load_extension('fzy_native')

local M = {}

M.search_dotfiles = function()
    telescope_builtin.find_files(themes.get_dropdown({
        layout_strategy = 'center',

        cwd = '~/.dotfiles',
        prompt_title = '< dotfiles >'
        })
    )
end

-- things I usually search/want to search:
-- TODOs (maybe add then to quicklist)


return M
