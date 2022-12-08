local neorg = require "neorg"

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          personal = "~/workspace/notes/neorg",
          work = "~/workspace/fdp/notes",
        },
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "personal",
      },
    },
  },
}
