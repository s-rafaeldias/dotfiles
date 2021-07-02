local vimp       = require('vimp')
local lspconfig  = require('lspconfig')

vim.lsp.set_log_level("debug")

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
    calc = false;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = false;
    tags = false;
    snippets_nvim = true;
    treesitter = false;
  };
}

-- Use <CR> for snippets on insert mode
vim.cmd [[ inoremap <silent><expr> <CR> compe#confirm('<CR>') ]]

require('rust-tools').setup{}

function custom_attach(client)
    print('Attaching LSP: ' .. client.name)
    require'lsp_signature'.on_attach()
    -- if client.name == "tsserver" then
        -- local ts_utils = require("nvim-lsp-ts-utils")
        -- ts_utils.setup{}
    -- end

    -- show documentation
    vimp.nnoremap({'override'}, 'K', function()
        vim.lsp.buf.hover()
    end)

    vimp.nnoremap({'override'}, 'gd', function()
        vim.lsp.buf.definition()
    end)

    -- rename
    vimp.nnoremap({'override'}, '<leader>rr', function()
        vim.lsp.buf.rename()
    end)

    vimp.nnoremap({'override'}, 'ga', function()
        vim.lsp.buf.code_action()
    end)
end


local servers = { "pyright", "solargraph", "gopls", "tsserver", "clangd", "rust_analyzer" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = custom_attach,
    }
end

lspconfig.elixirls.setup {
    on_attach = custom_attach,
    cmd = { "/Users/rafael/tmp/elixir-ls/language_server.sh" }
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
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
  -- on_attach = custom_attach,
  -- -- Include globals you want to tell the LSP are real :)
  -- globals = {
    -- -- Colorbuddy
    -- "Color", "c", "Group", "g", "s",
  -- }
-- })

-- -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use

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
