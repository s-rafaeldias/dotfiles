local vimp       = require('vimp')
local lspconfig  = require('lspconfig')
local completion = require('completion')

local lsp_status = require('lsp-status')
lsp_status.register_progress()

function custom_attach(client)
    completion.on_attach(client)
    lsp_status.on_attach(client)

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
    lspconfig[lsp].setup {
        on_attach = custom_attach,
        capabilities = lsp_status.capabilities
    }
end
