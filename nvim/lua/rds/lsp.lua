local vimp       = require('vimp')
local lspconfig  = require('lspconfig')
-- local completion = require('completion')
-- local completion = require('compe')

function custom_attach(client)
    print('Attaching LSP: ' .. client.name)

    -- completion.on_attach(client)

    -- show documentation
    vimp.nnoremap({'override'}, 'K', function()
        vim.lsp.buf.hover()
    end)

    vimp.nnoremap({'override'}, '<C-]', function()
        vim.lsp.buf.definition()
    end)

    -- rename
    vimp.nnoremap({'override'}, '<leader>rr', function()
        vim.lsp.buf.rename()
    end)
end


local servers = { "pyls", "solargraph", "gopls", "tsserver", "clangd" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = custom_attach,
    }
end


require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}


local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  on_attach = custom_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim', 'love'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
