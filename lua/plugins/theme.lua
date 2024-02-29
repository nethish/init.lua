-- return {
--     "folke/tokyonight.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {},
--     config = function()
--       vim.cmd("colorscheme tokyonight")
--     end
--   }

return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  config = function()
      vim.cmd('colorscheme kanagawa')
  end
}
