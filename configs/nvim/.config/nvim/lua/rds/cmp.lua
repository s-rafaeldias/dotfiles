require("luasnip/loaders/from_vscode").load()
-- require("cmp_git").setup()

local cmp = require "cmp"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup {
  completion = {
    keyword_length = 3,
    -- autocomplete = false,
  },

  preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-q>"] = cmp.mapping.close(),
    ["<C-y>"] = cmp.mapping.confirm { select = true },
    ["<C-n>"] = cmp.mapping {
      c = function()
        if cmp.visible() then
          cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
        else
          vim.api.nvim_feedkeys(t "<Down>", "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
        else
          fallback()
          -- Trigger completion manually only! https://github.com/hrsh7th/nvim-cmp/issues/178
          -- cmp.complete()
        end
      end,
    },
    ["<C-p>"] = cmp.mapping {
      c = function()
        if cmp.visible() then
          cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
        else
          vim.api.nvim_feedkeys(t "<Up>", "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
        else
          fallback()
        end
      end,
    },
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buf]",
        nvim_lua = "[NVIM_LUA]",
        path = "[Path]",
        luasnip = "[Snip]",
        nvim_lsp_signature_help = "[Args]",
      })[entry.source.name]

      return vim_item
    end,
  },

  sources = {
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
    -- { name = "cmp_git" },
  },
}
