return {
   "williamboman/mason.nvim",
   lazy = false,
   opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua",
				"pyright"
      },
    }
}
