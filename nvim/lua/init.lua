local vimp              = require 'vimp'
local telescope_builtin = require 'telescope.builtin'
local neogit            = require 'neogit'
local treesitter        = require 'nvim-treesitter.configs'

require 'rds.lsp'
require 'rds.telescope'
require 'rds.statusline'
require 'rds.harpoon'

-- TODO: create a utils module later
RELOAD = function(pkg)
    package.loaded[pkg] = nil
    return require(pkg)
end


-- TODO: put treesitter config on its own module
treesitter.setup {
    ensure_installed = { 'lua', 'javascript', 'python', 'bash', 'beancount', 'c', 'cpp', 'go', 'ruby', 'tsx', 'typescript', 'comment', 'json', 'toml' };
    highlight = {
        enable = true
    }
}


-- Mappings {{{
vimp.nnoremap({'override'}, '<C-P>', function() RELOAD('rds.telescope').find_files{} end)
vimp.nnoremap({'override'}, '<C-B>', function() telescope_builtin.buffers{} end)
vimp.nnoremap({'override'}, '<Leader>ev', function() RELOAD('rds.telescope').search_dotfiles{} end)
vimp.nnoremap({'override'}, '<Leader>tt', function() RELOAD('rds.telescope').todos() end)

-- Debug stuff
vimp.nnoremap({'override'}, '<Leader>m', function() telescope_builtin.keymaps{} end)

-- Git stuff
vimp.nnoremap({'override'}, '<Leader>g', function() neogit.status.create('split') end)
vimp.nnoremap({'override'}, '<Leader>G', function() require('telescope').extensions.git_worktree.git_worktrees() end)
-- }}}
