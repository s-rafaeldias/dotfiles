local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local pytest = s(
  "test",
  fmt(
    [[
      def test_{}():
          {}
    ]],
    { i(1), i(2) }
  )
)

local main_py = s(
  "main",
  fmt(
    [[
    if __name__ == "__main__":
        {}
    ]],
    { i(1) }
  )
)

local def_py = s(
  "def",
  fmt(
    [[
    def {}({}) -> {}:
        {}
    ]],
    { i(1), i(2), i(3, "None"), i(4) }
  )
)

local lambda_py = s("lambda", fmt("lambda {}: {}", { i(1), i(2) }))

return {
  main_py,
  lambda_py,
  def_py,
  pytest,
}
