return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    -- LSP Support
    -- {'neovim/nvim-lspconfig'},             -- Required
    -- {'williamboman/mason.nvim'},           -- Optional
    -- {'williamboman/mason-lspconfig.nvim'}, -- Optional
    --
    -- -- Autocompletion
    -- {'hrsh7th/nvim-cmp'},     -- Required
    -- {'hrsh7th/cmp-nvim-lsp'}, -- Required
    -- {'L3MON4D3/LuaSnip'},
    -- {'hrsh7th/cmp-buffer'},
    -- {'hrsh7th/cmp-path'},
    -- {'saadparwaiz1/cmp_luasnip'},    -- Required
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lua'},
    {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
    {'hrsh7th/cmp-cmdline'},
  },

}
