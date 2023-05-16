local ls = require "luasnip"
local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require "luasnip.util.events"
-- local ai = require "luasnip.nodes.absolute_indexer"
local fmt = require("luasnip.extras.fmt").fmt

-- Snippets setup {{{
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {
  silent = true,
})
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {
  silent = true,
})
--- }}}

--- Global snippets {{{
local todo = s("todo", t { "# TODO: " }, i(1))
--- }}}

local global_snips = { todo }

local py_snips = require "rds.snippets.python"
vim.list_extend(py_snips, global_snips)
ls.add_snippets("python", py_snips)

ls.add_snippets("sh", {
  s(
    "bash",
    t {
      "#!/bin/bash",
      "set -euo pipefail",
      "IFS=$'\\n\\t'",
    }
  ),
})
