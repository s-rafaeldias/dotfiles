local rds_utils = require "rds.utils"
local tmux = require "harpoon.tmux"

-- Copy selected text (visual mode) to + register (clipboard)
vim.keymap.set("v", "<Leader>y", '"+y')

-- Use <Esc> to exit insert mode on terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Toggle case of current WORD in insert mode
-- vim.keymap.set("i", "<C-g>", "<Esc>vB~Ea")

-- Reload config
-- vim.keymap.set("n", "<Leader>sv", "<Cmd>luafile $MYVIMRC<CR>")

-- Switch between related files. See `tpope/vim-projectionist`
vim.keymap.set("n", "<Leader>s", "<Cmd>A<CR>")
vim.keymap.set("n", "<Leader>S", "<Cmd>AV<CR>")

vim.keymap.set("n", "<Leader>e", "<Cmd>Ex!<CR>")

vim.keymap.set("n", "<leader>q", rds_utils.toggle_qflist)

vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

-- vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<Leader>a", "<Cmd>lua require'harpoon.mark'.add_file()<CR>")
vim.keymap.set("n", "<Leader>h", "<Cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>")

vim.keymap.set("n", "<Leader><Leader>j", "<Cmd>lua require'harpoon.ui'.nav_file(1)<CR>")
vim.keymap.set("n", "<Leader><Leader>k", "<Cmd>lua require'harpoon.ui'.nav_file(2)<CR>")
vim.keymap.set("n", "<Leader><Leader>l", "<Cmd>lua require'harpoon.ui'.nav_file(3)<CR>")
vim.keymap.set("n", "<Leader><Leader>;", "<Cmd>lua require'harpoon.ui'.nav_file(4)<CR>")

vim.keymap.set("n", "<Leader><Leader>u", function()
  tmux.gotoTerminal(3)
end)

-- Make numbered jump add to jumplist
-- Ref: https://vi.stackexchange.com/a/7697
-- vim.cmd [[
--     nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
--     nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
-- ]]
vim.keymap.set("n", "k", function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. "<Up>"
  end
  return "<Up>"
end, {
  expr = true,
})

vim.keymap.set("n", "j", function()
  if vim.v.count > 0 then
    return "m'" .. vim.v.count .. "<down>"
  end
  return "<down>"
end, {
  expr = true,
})
