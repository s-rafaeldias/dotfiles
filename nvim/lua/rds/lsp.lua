local vimp       = require('vimp')
local lspconfig  = require('lspconfig')
local completion = require('completion')

function custom_attach(client)
    print('Attaching LSP: ' .. client.name)

    completion.on_attach(client)

    -- show documentation
    vimp.nnoremap({'override'}, 'K', function()
        vim.lsp.buf.hover()
    end)

    vimp.nnoremap({'override'}, '<leader>gd', function()
        vim.lsp.buf.definition()
    end)

    -- rename
    vimp.nnoremap({'override'}, '<leader>rr', function()
        vim.lsp.buf.rename()
    end)
end


local servers = { "pyls", "solargraph", "gopls" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = custom_attach,
    }
end
