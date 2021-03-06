local vimp = require 'vimp'
local term = require 'harpoon.term'
local ui   = require 'harpoon.ui'
local mark = require 'harpoon.mark'

require('harpoon').setup ({
    projects = {
        ["$HOME/.dotfiles"] = {
            term = {
                cmds = { "./setup.sh\n" }
            }
        }
    }
})


vimp.nnoremap({'override'}, '<Leader>a', function() mark.add_file() end)
vimp.nnoremap({'override'}, '<Leader>h', function() ui.toggle_quick_menu() end)

vimp.nnoremap({'override'}, '<Leader>j', function() ui.nav_file(1) end)
vimp.nnoremap({'override'}, '<Leader>k', function() ui.nav_file(2) end)
vimp.nnoremap({'override'}, '<Leader>l', function() ui.nav_file(3) end)
vimp.nnoremap({'override'}, '<Leader>;', function() ui.nav_file(4) end)


vimp.nnoremap({'override'}, '<C-J>', function()
    term.sendCommand(1, 1)
    term.gotoTerminal(1)
end)

vimp.nnoremap({'override'}, '<C-K>', function()
    term.sendCommand(2, 2)
    term.gotoTerminal(2)
end)

vimp.nnoremap({'override'}, '<C-L>', function()
    term.sendCommand(3, 3)
    term.gotoTerminal(3)
end)
