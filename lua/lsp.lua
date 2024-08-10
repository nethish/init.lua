
local lsp_zero = require('lsp-zero')
local lazypath =  vim.fn.stdpath("data") .. "/lazy"

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr}) end)


lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({
    buffer = bufnr,
  })
end)

-- You must call require('lspconfig').gopls.setup({}) to setup the LSP
-- Instead use mason lspconfig integration
require('mason-lspconfig').setup({
  handlers = {
  function(server_name)
    require('lspconfig')[server_name].setup({})
  end,
  }
})

require('lspconfig').gopls.setup({
  -- settings = {
  --   gopls = {
  --     gofumpt = true
  --   }
  -- }
})

require('lspconfig').rust_analyzer.setup({
  -- settings = {
  --   gopls = {
  --     gofumpt = true
  --   }
  -- }
})

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT', -- Lua version (Lua 5.1, 5.2, 5.3, LuaJIT)
        path = vim.split(package.path, ';'), -- Set the path to search for Lua modules
      },
      diagnostics = {
        globals = {'vim'}, -- Recognize the 'vim' global
      },
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file("", true), -- Recognize the libraries in runtime
          lazypath,
        },
        maxPreload = 1000,
        preloadFileSize = 100,
      },
      telemetry = {
        enable = false, -- Disable telemetry data
      },
    },
  },
})

-- vim.api.nvim_set_keymap('n', '<leader>fmt', ':lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('V', '<c-f>', ':lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })
--
-------------------------

local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format({details = true})
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = 'luasnip', priority = 1000},
    {name = 'nvim_lsp', priority = 100},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'nvim_lua'}
  },
  preselect = 'item',
  -- completion = {
  --   completeopt = 'menu,menuone,noinsert'
  -- },
  -- mapping = cmp.mapping.preset.insert({
  --   ['<CR>'] = cmp.mapping.confirm({select = false}),
  --   ['<Tab>'] = cmp_action.tab_complete(),
  --   ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
  -- }),
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  }),
  --- (Optional) Show source name in completion menu
  formatting = cmp_format,
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

-------------------------------------------------- FRIENDLY SNIPPETS --------------------------------------------------

require('luasnip.loaders.from_vscode').lazy_load()

-------------------------------------------------- COMMAND LINE --------------------------------------------------

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline({
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c' }),
  }),
  sources = {
    { name = 'buffer' }
  },
})

cmp.setup.cmdline('?', {
    mapping = cmp.mapping.preset.cmdline({
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c' }),
    }),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
  -- mapping = cmp.mapping.preset.cmdline(),
  mapping = cmp.mapping.preset.cmdline({
      ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'c' }),
      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'c' }),
  }),
  sources = cmp.config.sources({
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'luasnip'},
    {name = 'nvim_lua'},
    {name = 'cmdline'}
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})
