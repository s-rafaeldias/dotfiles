local vimp       = require 'vimp'
local telescope  = require 'telescope.builtin'
local neogit     = require 'neogit'

require 'rds.lsp'
require 'rds.telescope'

-- TODO: create a utils module later
RELOAD = function(pkg)
    package.loaded[pkg] = nil
    return require(pkg)
end

-- Mappings {{{
vimp.nnoremap('<C-P>', function() RELOAD('rds.telescope').find_files{} end)
-- vimp.nnoremap('<Leader>ts', function() telescope.treesitter{} end)
vimp.nnoremap('<Leader>fg', function() telescope.git_files{} end)
vimp.nnoremap('<C-B>', function() telescope.buffers{} end)
vimp.nnoremap('<Leader>ev', function() RELOAD('rds.telescope').search_dotfiles() end)
vimp.nnoremap('<Leader>rs', function() RELOAD('rds.telescope').search_pi() end)

vimp.nnoremap('<Leader>g', function() neogit.status.create('split') end)
-- }}}
