return {
    'nvim-tree/nvim-tree.lua',
    -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require("nvim-tree").setup {
        view = {
          side = 'right',
          width = 80,
        },
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = false,
        },
      }
    end
}

