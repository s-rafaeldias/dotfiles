local vimp              = require 'vimp'
local telescope_builtin = require 'telescope.builtin'
local neogit            = require 'neogit'
local treesitter        = require 'nvim-treesitter.configs'

require 'rds.lsp'
require 'rds.telescope'
require 'rds.statusline'
require 'rds.harpoon'
require 'rds.worktree'

-- TODO: create a utils module later
RELOAD = function(pkg)
    package.loaded[pkg] = nil
    return require(pkg)
end


-- TODO: put treesitter config on its own module
treesitter.setup {
    ensure_installed = { 'lua', 'javascript', 'python', 'bash', 'beancount', 'c', 'cpp', 'ruby', 'tsx', 'typescript', 'comment', 'json', 'toml', 'jsonc' };
    highlight = {
        enable = true
    }
}

neogit.setup {}


-- Mappings {{{
vimp.nnoremap({'override'}, '<C-P>', function() RELOAD('rds.telescope').find_files{
   find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git' }
} end)
vimp.nnoremap({'override'}, '<C-B>', function() telescope_builtin.buffers{} end)
vimp.nnoremap({'override'}, '<Leader>ev', function() RELOAD('rds.telescope').search_dotfiles{} end)

-- Git stuff
vimp.nnoremap({'override'}, '<Leader>g', function() neogit.open({ kind = "split" }) end)
vimp.nnoremap({'override'}, '<Leader>G', function() require('telescope').extensions.git_worktree.git_worktrees() end)
-- }}}
