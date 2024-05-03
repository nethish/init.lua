-- vim.o is global vim options
local o = vim.o

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2

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
