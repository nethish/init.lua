return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup( {
			ensure_installed = {"lua_ls"}
		})
  end

}
