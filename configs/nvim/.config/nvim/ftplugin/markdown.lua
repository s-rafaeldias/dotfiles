-- Enable go to definition if markdown file is part of a zk notebook
-- if require("zk.util").notebook_root(vim.fn.expand "%:p") ~= nil then
--   vim.keymap.set("n", "gd", vim.lsp.buf.definition)
-- end
--
vim.cmd [[
setlocal spell spelllang=en_us
]]

vim.opt_local.conceallevel = 2
