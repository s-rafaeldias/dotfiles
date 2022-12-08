local rds_utils = require "rds.utils"

-- Copy selected text (visual mode) to + register (clipboard)
vim.keymap.set("v", "<Leader>y", '"+y')

-- Use <Esc> to exit insert mode on terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Toggle case of current WORD in insert mode
-- vim.keymap.set("i", "<C-g>", "<Esc>vB~Ea")

-- Reload config
vim.keymap.set("n", "<Leader>sv", "<Cmd>luafile $MYVIMRC<CR>")
vim.keymap.set("n", "<Leader><Leader>s", function()
  vim.cmd "so %"
  vim.notify "File sourced!"
end)

vim.keymap.set("n", "<Leader>e", "<Cmd>Ex!<CR>")

vim.keymap.set("n", "<leader>wd", "<cmd>VimwikiIndex1<cr>")

vim.keymap.set("n", "<leader>q", rds_utils.toggle_qflist)

vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

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
