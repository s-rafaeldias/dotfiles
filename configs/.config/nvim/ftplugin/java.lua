local custom_attach = function(client, bufnr)
  -- vim.notify("Attaching LSP: " .. client.name)
  local function definition_split()
    vim.cmd "vs"
    vim.lsp.buf.definition()
  end

  vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>")
  vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
  vim.keymap.set("n", "gD", definition_split)
  vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>")
  vim.keymap.set("n", "gs", "<Cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>")
  vim.keymap.set("n", "<Leader>cl", "<Cmd>lua vim.lsp.codelens.run()<CR>")
  vim.keymap.set("n", "<Leader>rr", "<Cmd>lua vim.lsp.buf.rename()<CR>")
  vim.keymap.set("n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>")
  vim.keymap.set("v", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>")
  vim.keymap.set("n", "<Leader>cf", "<Cmd>lua vim.lsp.buf.format()<CR>")
end

local bundles = {
  "/Users/rafael/code/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.1.jar",
}
vim.list_extend(bundles, vim.split(vim.fn.glob("/Users/rafael/code/vscode-java-test/server/*.jar", true), "\n"))

local java_config = {
  cmd = { "/Users/rafael/.local/bin/java-lsp/bin/jdtls" },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  on_attach = custom_attach,

  init_options = {
    bundles = bundles,
  },
}
require("jdtls").start_or_attach(java_config)
