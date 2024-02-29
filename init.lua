vim.g.mapleader = " "

-- PLUGINS
require("bootstrap")
require("lazy").setup("plugins")
require("lsp")
require("opts")
require("keymap")

TAB = function(tabwidth)
    vim.opt.tabstop = tabwidth
    vim.opt.softtabstop = tabwidth
    vim.opt.shiftwidth = tabwidth
end

vim.api.nvim_create_user_command('CP',
    function()
        require('cp')
        TAB(2)
    end, {}
)

vim.api.nvim_create_user_command('T2',
    function()
        TAB(2)
    end, {}
)

vim.api.nvim_create_user_command('T4',
    function()
        TAB(4)
    end, {}
)

