local vimp       = require 'vimp'
local telescope  = require 'telescope.builtin'

vimp.nnoremap('<C-P>', function() telescope.find_files{
    prompt_position = 'top',
    sorting_strategy = 'ascending',
    color_devicons = true,
    width = .25,

    layout_strategy = 'horizontal',
    layout_config = {
        preview_width = .65,
    }
} end)
