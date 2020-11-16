print("Loaded init.lua")

-- require('nlua.lsp.nvim').setup(require('nvim_lsp'), {
    -- on_attach=require('completion').on_attach,
    -- globals = {
    -- -- Colorbuddy
    -- "Color", "c", "Group", "g", "s",
    -- }
-- })

local vimp = require('vimp')

vimp.nnoremap('<C-P>', function()
    require'telescope.builtin'.git_files{}
end)
