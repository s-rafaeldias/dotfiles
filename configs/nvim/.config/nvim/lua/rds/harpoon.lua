local tmux = require "harpoon.tmux"

vim.keymap.set("n", "<Leader>a", "<Cmd>lua require'harpoon.mark'.add_file()<CR>")
vim.keymap.set("n", "<Leader>h", "<Cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>")

vim.keymap.set("n", "<Leader><Leader>j", "<Cmd>lua require'harpoon.ui'.nav_file(1)<CR>")
vim.keymap.set("n", "<Leader><Leader>k", "<Cmd>lua require'harpoon.ui'.nav_file(2)<CR>")
vim.keymap.set("n", "<Leader><Leader>l", "<Cmd>lua require'harpoon.ui'.nav_file(3)<CR>")
vim.keymap.set("n", "<Leader><Leader>;", "<Cmd>lua require'harpoon.ui'.nav_file(4)<CR>")

vim.keymap.set("n", "<Leader><Leader>u", function()
  tmux.gotoTerminal(3)
end)
