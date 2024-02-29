local keymap = vim.keymap

-- LOCAL FUNCTIONS

-- CONFIG

-- SHORTCUTS
keymap.set('n', '<leader>rn', ':set rnu!<CR>')

keymap.set('n', '<leader>ek', ':edit '..vim.fn.stdpath('config')..'/lua/keymap.lua <CR>')
keymap.set('n', '<leader>ev', ':edit '..vim.fn.stdpath('config')..'/init.lua <CR>')
keymap.set('n', '<leader>sv', ':source '..vim.fn.stdpath('config')..'/init.lua <CR>')
keymap.set('n', '<leader>scc', ':source % <CR>')

keymap.set('n', '<esc>', ':noh <CR>')

-- zz brings the cursor to the middle of the screen. See scrolloff option too. 
-- Then third z is for fold. Need to figure out the reason. 
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

-- Netrw
keymap.set('n', 'E', ':Rex<CR>')
keymap.set('n', '<leader>E', ':Explore<CR>')

-- I dont' know what this does
-- keymap.set("x", "<leader>p", [["_dP]])

keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- Yank the entire file and move the cursor back to where it was using marks
keymap.set("n", "Y", [[mZgg0VG"+y`Z]])

-- Delete into black hole register
keymap.set({"n", "v"}, "<leader>d", [["_d]])
keymap.set('n', 'x', '"_x')

-- Move command to move text to the end of visual selection + 1
keymap.set('v', "J", ":m '>+1<CR>gv=gv")
keymap.set('v', "K", ":m '<-2<CR>gv=gv")

keymap.set('n', '<C-J>', '<C-W>j')
keymap.set('n', '<C-K>', '<C-W>k')
keymap.set('n', '<C-L>', '<C-W>l')
keymap.set('n', '<C-H>', '<C-W>h')

-- TELESCOPE
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', builtin.find_files, {})
keymap.set('n', '<leader>fg', builtin.live_grep, {})
keymap.set('n', '<leader>fb', builtin.buffers, {})
keymap.set('n', '<leader>fh', builtin.help_tags, {})
keymap.set('n', '<leader>fm', builtin.marks, {})
keymap.set('n', '<leader>fch', builtin.command_history, {})
keymap.set('n', '<leader>fr', builtin.registers, {})

-- UNDOTREE
keymap.set('n', '<leader>u', function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end)

-- Adjust heigh of pane
keymap.set('n', '<LEADER>>', '10<C-W>>')
keymap.set('n', '<LEADER><', '10<C-W><')
keymap.set('n', '<LEADER>+', '10<C-W>+')
keymap.set('n', '<LEADER>-', '10<C-W>-')


