local dap = require "dap"
local dap_python = require "dap-python"
local dapui = require "dapui"
-- local dap_go = require "dap-go"

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

dap_python.setup "~/miniconda3/envs/dap/bin/python"
dap_python.test_runner = "pytest"

dapui.setup {
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        "console",
      },
      size = 10,
      position = "bottom",
    },
  },
}
-- dap_go.setup()

vim.keymap.set("n", "<Leader>dd", function()
  dap.continue()
end)
vim.keymap.set("n", "<Leader>db", function()
  dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>dn", function()
  dap.step_over()
end)
vim.keymap.set("n", "<Leader>dp", function()
  dap.step_back()
end)
vim.keymap.set("n", "<Leader>di", function()
  dap.step_into()
end)
vim.keymap.set("n", "<Leader>do", function()
  dap.step_out()
end)
vim.keymap.set("n", "<Leader>dr", function()
  dap.repl.open()
end)
vim.keymap.set("n", "<Leader>dc", function()
  dap.run_to_cursor()
end)
vim.keymap.set("n", "<Leader>dq", function()
  dapui.close {}
end)
vim.keymap.set("n", "<Leader>dt", function()
  local ft = vim.bo.filetype
  if ft == "python" then
    dap_python.test_method()
  -- elseif ft == "go" then
  --   dap_go.debug_test()
  end
end)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  -- dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  -- dapui.close()
end
