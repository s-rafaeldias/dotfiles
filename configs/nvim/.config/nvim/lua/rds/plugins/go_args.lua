local api = vim.api
local ns = api.nvim_create_namespace "go_args"

local ids = {}

M = {}

function M.add_marks()
  local bufnr = api.nvim_get_current_buf()
  local text = { "text3", "Comment" }
  local opts = {
    virt_text = { text },
    virt_text_pos = "overlay",
    -- right_gravity = false
    end_col = 3,
    end_right_gravity = true,
  }
  local id = api.nvim_buf_set_extmark(bufnr, ns, 0, 0, opts)

  table.insert(ids, id)
end

function M.clear_marks()
  local bufnr = api.nvim_get_current_buf()

  for _, id in ipairs(ids) do
    api.nvim_buf_del_extmark(bufnr, ns, id)
  end
end

return M
