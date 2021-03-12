local vimp       = require 'vimp'
local telescope  = require 'telescope.builtin'

require 'rds.lsp'
require 'rds.snippets'

-- MAPPINGS
vimp.nnoremap('<C-P>', function() telescope.find_files() end)


-- Reload configs
