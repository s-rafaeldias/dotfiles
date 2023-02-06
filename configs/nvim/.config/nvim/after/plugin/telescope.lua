require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules/*",
      "*.pyc",
    },
    sorting_strategy = "ascending",

    fzf = {
      fuzzy = true,
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },

    layout_config = {
      prompt_position = "top",
    },

    mappings = {
      i = { ["<C-q>"] = require("telescope.actions").send_to_qflist },
    },
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

require("telescope").load_extension "git_worktree"
require("telescope").load_extension "fzf"
require("telescope").load_extension "ui-select"

local project_files = function()
  local in_git_repo = vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true"
  if in_git_repo then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files()
  end
end

vim.keymap.set("n", "<Leader>t", "<Cmd>Telescope<CR>")
vim.keymap.set("n", "<C-P>", project_files)
vim.keymap.set("n", "<leader>pf", require("telescope.builtin").find_files)

vim.keymap.set("n", "<C-F>", "<Cmd>lua require'telescope.builtin'.live_grep { hidden=true }<CR>")
vim.keymap.set("n", "<C-B>", "<Cmd>lua require'telescope.builtin'.buffers{}<CR>")
vim.keymap.set("n", "<leader>x", "<Cmd>lua require'telescope.builtin'.diagnostics{}<CR>")
