local M = {}

function M.custom_attach(client, bufnr)
  vim.notify("Attaching LSP: " .. client.name)
  local opts = { noremap = true }

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<Cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>rr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ff", "<Cmd>lua vim.lsp.buf.format { async=true }<CR>", opts)
end

return M
