local vimp              = require 'vimp'
local neogit            = require 'neogit'
local treesitter        = require 'nvim-treesitter.configs'


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

require 'rds.lsp'
require 'rds.telescope'
require 'rds.statusline'
require 'rds.harpoon'
require 'rds.worktree'

-- Git stuff
vimp.nnoremap({'override'}, '<Leader>g', function() neogit.open({ kind = "split" }) end)
vimp.nnoremap({'override'}, '<Leader>G', function() require('telescope').extensions.git_worktree.git_worktrees() end)
-- }}}
