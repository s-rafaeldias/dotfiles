local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local t = ls.text_node

return {
  s("todo", t { "# TODO: " }, i(1)),
  s("lambda", fmt("lambda {}: {}", { i(1), i(2) })),
  s("fromi", fmt("from {} import {}", { i(1), i(2) })),
  s(
    "desc",
    fmt(
      [[
      def describe_{}():
          def test_{}():
              {}
      ]],
      { i(1), i(2), i(3, "assert True") }
    )
  ),
  s(
    "test",
    fmt(
      [[
      def test_{}():
          {}
      ]],
      { i(1), i(2, "assert True") }
    )
  ),
  s(
    "main",
    fmt(
      [[
      def main():
          {}

      if __name__ == "__main__":
          main()
      ]],
      { i(1) }
    )
  ),
  s(
    "def",
    fmt(
      [[
      def {}({}) -> {}:
          {}
      ]],
      { i(1), i(2), i(3, "None"), i(4) }
    )
  ),
}
