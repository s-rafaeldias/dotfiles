local rds_utils = require "rds.utils"

-- Copy selected text (visual mode) to + register (clipboard)
vim.keymap.set("v", "<Leader>y", '"+y')

-- Use <Esc> to exit insert mode on terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Toggle case of current WORD in insert mode
-- vim.keymap.set("i", "<C-g>", "<Esc>vB~Ea")

-- Reload config
vim.keymap.set("n", "<Leader>sv", "<Cmd>luafile $MYVIMRC<CR>")

-- Switch between related files. See `tpope/vim-projectionist`
vim.keymap.set("n", "<Leader>s", "<Cmd>AV<CR>")

vim.keymap.set("n", "<Leader>e", "<Cmd>Ex!<CR>")

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

-- Git {{{
-- vim.keymap.set("n", "<Leader>gg", neogit.open)
vim.keymap.set("n", "<Leader>gg", "<Cmd>G<CR>")
vim.keymap.set("n", "<Leader>gp", "<Cmd>G pull<CR>")
vim.keymap.set("n", "<Leader>gP", "<Cmd>G push<CR>")
-- Git worktree extension
vim.keymap.set("n", "<Leader>gl", "<Cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>")
vim.keymap.set("n", "<Leader>ga", "<Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>")
vim.keymap.set("n", "<Leader>gn", require("rds.git").create_git_worktree)
-- }}}

-- DAP {{{
-- }}}
