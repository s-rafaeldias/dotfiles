local vimp       = require 'vimp'
local telescope  = require 'telescope.builtin'

require 'rds.lsp'
require 'rds.telescope'

-- TODO: create a utils module later
RELOAD = function(pkg)
    package.loaded[pkg] = nil
    return require(pkg)
end

-- Mappings {{{
vimp.nnoremap('<C-P>', function() telescope.find_files{ hidden = true } end)
vimp.nnoremap('<Leader>fg', function() telescope.git_files{} end)
vimp.nnoremap('<C-B>', function() telescope.buffers{} end)
vimp.nnoremap('<Leader>ev', function() RELOAD('rds.telescope').search_dotfiles() end)
-- }}}
