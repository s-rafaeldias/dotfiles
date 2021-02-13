-- local vim        = require('vim')
local vimp       = require('vimp')
local lspconfig  = require('lspconfig')
local completion = require('completion')
local telescope  = require('telescope.builtin')

function custom_attach(client)
    completion.on_attach(client)

    -- show documentation
    vimp.nnoremap({'override'}, 'K', function()
        vim.lsp.buf.hover()
    end)

    vimp.nnoremap({'override'}, '<leader>gd', function()
        vim.lsp.buf.definition()
    end)

    -- show signature
    vimp.nnoremap({'override'}, '<C-k>', function()
        vim.lsp.buf.signature_help()
    end)
end


local servers = { "pyls", "solargraph", "gopls" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup { on_attach = custom_attach }
end


vimp.nnoremap('<C-P>', function()
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/git.lua#L141 
    local cwd = vim.loop.cwd()
    local git_root = vim.fn.systemlist("git -C "..cwd.." rev-parse --show-toplevel")[1]

    if vim.v.shell_error ~= 0 then
        telescope.find_files{}
    else
        telescope.git_files{}
    end
end)
