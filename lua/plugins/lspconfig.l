local M = {}
M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}


local config = function()
	local lspconfig = require('lspconfig')
	lspconfig.pyright.setup({})
	lspconfig.lua_ls.setup({
		on_attach = M.on_attach,
		capabilities = M.capabilities,
		settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand "$VIMRUNTIME/lua"] = true,
							[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
							[vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
				},
			}
		})
	lspconfig.clangd.setup({})
end

return {
  "neovim/nvim-lspconfig",
	-- dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = config
}
