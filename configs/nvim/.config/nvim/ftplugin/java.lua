local custom_attach = function(client, bufnr)
  -- vim.notify("Attaching LSP: " .. client.name)
  local opts = { noremap = true }

  -- require("lsp_signature").on_attach({
  --   bind = true,
  --   hint_prefix = "🐍 ",
  --   doc_lines = 0,
  --   floating_window = false,
  -- }, bufnr)

  -- lsp_status.on_attach(client)

  local function definition_split()
    -- TODO: check how many splits we have and add some smart logic here
    vim.cmd "vs"
    vim.lsp.buf.definition()
  end

  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "", { callback = definition_split, noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<Cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>rr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ff", "<Cmd>lua vim.lsp.buf.format { async=true }<CR>", opts)
end

local java_config = {
  cmd = { "/Users/rafael/.local/bin/java-lsp/bin/jdtls" },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  on_attach = custom_attach,
}
require("jdtls").start_or_attach(java_config)
