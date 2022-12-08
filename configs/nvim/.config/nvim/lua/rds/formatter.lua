require("formatter").setup {
  logging = false,
  filetype = {
    python = {
      function()
        return {
          exe = "black",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = false,
        }
      end,
    },
    lua = {
      function()
        return {
          exe = "stylua",
          args = { vim.api.nvim_buf_get_name(0) },
          stdin = false,
        }
      end,
    },
    cpp = {
      function()
        return {
          exe = "clang-format",
          args = { "-i", vim.api.nvim_buf_get_name(0) },
          stdin = false,
        }
      end,
    },
    ruby = {
      function()
        return {
          exe = "rubocop",
          args = { "-x", vim.api.nvim_buf_get_name(0) },
          stdin = false,
        }
      end,
    },
  },
}
