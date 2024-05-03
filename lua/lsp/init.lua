--
-- local lazy = require('lazy')
--
-- lazy.setup({
--   {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
--   {'williamboman/mason.nvim'},
--   {'williamboman/mason-lspconfig.nvim'},
--   {'neovim/nvim-lspconfig'},
--   {'hrsh7th/nvim-cmp'},
--   {'hrsh7th/cmp-nvim-lsp'},
--   {'hrsh7th/cmp-buffer'},
--   {'hrsh7th/cmp-path'},
--   {'saadparwaiz1/cmp_luasnip'},
--   {'hrsh7th/cmp-nvim-lua'},
--   {'L3MON4D3/LuaSnip'},
--   {'rafamadriz/friendly-snippets'},
-- })
--
local lsp_zero = require('lsp-zero')

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = ''
})

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})


local lua_opts = lsp_zero.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    -- this first function is the "default handler"
    -- it applies to every language server without a "custom handler"
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

local cmp = require('cmp')
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
})

local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- confirm completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- toggle completion menu
    ['<C-e>'] = cmp_action.toggle_completion(),

    -- tab complete
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    -- navigate between snippet placeholder
    ['<C-d>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- scroll documentation window
    ['<C-f>'] = cmp.mapping.scroll_docs(-5),
    ['<C-d>'] = cmp.mapping.scroll_docs(5),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  }
})


-- local lsp = require('lsp-zero').preset({
--   name = 'minimal',
--   set_lsp_keymaps = true,
--   manage_nvim_cmp = true
-- })
--
-- lsp.setup_nvim_cmp({
--   select_behavior = 'insert'
-- })
--
-- lsp.on_attach(function(client, bufnr)
--     -- see :help lsp-zero-keybindings
--     -- to learn the available actions
--     lsp.default_keymaps({ buffer = bufnr })
-- end)
--
-- require('lsp-zero').ensure_installed({
--     'tsserver',
--     'pyright',
--     'clangd',
-- })
--
-- -- (Optional) Configure lua language server for neovim
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
--
-- lsp.setup()
