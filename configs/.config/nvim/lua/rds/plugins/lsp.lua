--
-- Setting up my own LSP for playground
local function start_spark_lsp()
  vim.lsp.set_log_level(0)

  local client_id = vim.lsp.start {
    name = "custom_lsp",
    cmd = { "custom_lsp" },
    root_dir = vim.fs.normalize "~/code/mylsp",
  }

  for _, client in ipairs(vim.lsp.get_clients()) do
    vim.print(client.name)
  end
end

local spark_lsp_group = vim.api.nvim_create_augroup("SparkLSP", { clear = true })

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = "python",
--   callback = function()
--     print "Starting spark LSP"
--     start_spark_lsp()
--   end,
--   group = spark_lsp_group,
--   desc = "",
-- })

vim.api.nvim_create_user_command("Spk", start_spark_lsp, {})
