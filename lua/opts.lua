-- vim.o is global vim options
local o = vim.o

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
vim.opt.foldmethod = 'expr'


vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.o.foldtext = ""
vim.o.foldcolumn = "0"
vim.opt.foldnestmax = 4

vim.opt.foldlevel = 99
-- Optional: Start with folds closed if you prefer
vim.opt.foldlevelstart = 3

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

o.expandtab = true
o.smartindent = true

o.clipboard = "unnamedplus"

o.number = true
o.relativenumber = true
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.autoread = true
o.autowrite = true

o.splitright = true
o.splitbelow = true

-- Atleast 8 lines above/ below when scrolling.
o.scrolloff = 8
o.cmdheight = 2

vim.cmd([[
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
]])

