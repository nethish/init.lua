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

-- Delete current buffer
vim.api.nvim_set_keymap('n', '<leader>q', ':BufferClose<CR>', { noremap = true, silent = true })

-- Switch to next buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', { noremap = true, silent = true })

-- Switch to previous buffer
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', { noremap = true, silent = true })

-- Switch to last used buffer
vim.api.nvim_set_keymap('n', '<leader><leader>', ':b#<CR>', { noremap = true, silent = true })

-- zz brings the cursor to the middle of the screen. See scrolloff option too. 
-- Then third z is for fold. Need to figure out the reason. 
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

-- I dont' know what this does
-- keymap.set("x", "<leader>p", [["_dP]])

keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- Yank the entire file and move the cursor back to where it was using marks
keymap.set("n", "Y", [[mZgg0VG"+y`Z]])

-- Use X when you don't want to put the content into registers
keymap.set('n', 'x', '"_x')
keymap.set('n', '<leader>x', '"_d')

-- Move command to move text to the end of visual selection + 1
keymap.set('v', "J", ":m '>+1<CR>gv=gv")
keymap.set('v', "K", ":m '<-2<CR>gv=gv")

keymap.set('n', '<C-J>', '<C-W>j')
keymap.set('n', '<C-K>', '<C-W>k')
keymap.set('n', '<C-L>', '<C-W>l')
keymap.set('n', '<C-H>', '<C-W>h')

-- TELESCOPE
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local telescope_wrapper = function(fn)
  return function()
    fn({
      initial_mode = 'normal',
      mappings = {
        n = {
          -- 'q' = telescope_actions.close
        }
      }
    })
  end
end

local function live_grep_from_project_git_root()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")

    return vim.v.shell_error == 0
  end

  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end

  local opts = {}

  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end

  require("telescope.builtin").live_grep(opts)
end

local function find_files_from_project_git_root()
  local function is_git_repo()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    return vim.v.shell_error == 0
  end
  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end
  local opts = {}
  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end
  require("telescope.builtin").find_files(opts)
end

keymap.set('n', '<leader>ff', find_files_from_project_git_root, {})
keymap.set('n', '<leader>fg', live_grep_from_project_git_root, {})
keymap.set('n', '<leader>fj', live_grep_from_project_git_root, {})
keymap.set('n', '<leader>fb', telescope_wrapper(builtin.buffers), {})
keymap.set('n', '<leader>f;', telescope_wrapper(builtin.buffers), {})
keymap.set('n', '<leader>fm', telescope_wrapper(builtin.marks), {})

keymap.set('n', '<leader>fh', function()
  -- Press CTRL-E to edit the command
  builtin.command_history({
    initial_mode = 'normal',
    mappings = {
      n = {
        ['e'] = require('telescope.actions').edit_command_line
      }
    }
  })
end,
{noremap = true})

keymap.set('n', '<leader>rr', telescope_wrapper(builtin.registers), {})
keymap.set('n', '<leader>fo', telescope_wrapper(builtin.oldfiles))
keymap.set('n', '<leader>fw', '<cmd>Telescope grep_string<cr>')

keymap.set('n', '<leader>ft', function()
  require('telescope.builtin').grep_string({search = 'TODO', initial_mode = 'normal'})
end)

-- TELESCOPE GIT
keymap.set('n', '<leader>gc', telescope_wrapper(builtin.git_commits))
keymap.set('n', '<leader>gb', telescope_wrapper(builtin.git_branches))
keymap.set('n', '<leader>gs', telescope_wrapper(builtin.git_status))

-- OIL
keymap.set('n', '<leader>o', '<cmd>Oil --float<cr>')

-- UNDOTREE
keymap.set('n', '<leader>u', function()
  vim.cmd.UndotreeToggle()
  vim.cmd.UndotreeFocus()
end)

-- NVIM TREE
keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {silent = true, noremap = true})

-- Adjust heigh of pane
keymap.set('n', '<LEADER>>', '10<C-W>>')
keymap.set('n', '<LEADER><', '10<C-W><')
keymap.set('n', '<LEADER>+', '10<C-W>+')
keymap.set('n', '<LEADER>-', '10<C-W>-')

-- Todo COMMENTS
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- TROUBLE

-- REFRESH
vim.keymap.set('n', '<leader>L', '<Cmd>luafile %<CR>', {})

-- EXPERIMENT
vim.keymap.set('n', 'E', function()
  vim.cmd('source ~/.config/nvim/lua/e.lua')
  vim.print('Experiment refreshed')
end)


-- TROUBLE
local trouble = require('trouble')
---@type trouble.Window.opts

local trouble_fn = function(mode)
  return function()
    trouble.toggle({
      mode = mode,
      focus = 'true',
      win = {
        type = 'split',
        position = 'right',
        size = {
          width = math.floor(vim.o.columns * 0.4),
        }
      },
      preview = {
        type = 'split',
        position = 'bottom',
        size = {
          height = math.floor(vim.o.lines * 0.5),
        },
        relative = 'win',
      },
      auto_jump = false,
    })
  end
end

vim.keymap.set('n', '<leader>ld', trouble_fn('diagnostics'))
vim.keymap.set('n', '<leader>ll', trouble_fn('lsp'))
vim.keymap.set('n', '<leader>ls', trouble_fn('lsp_document_symbols'))
vim.keymap.set('n', '<leader>li', trouble_fn('lsp_incoming_calls'))
vim.keymap.set('n', '<leader>lo', trouble_fn('lsp_outgoing_calls'))
vim.keymap.set('n', 'gr', trouble_fn('lsp_references'))
vim.keymap.set('n', '<leader>lm', trouble_fn('lsp_implementations')) -- gi Already does this
vim.keymap.set('n', '<leader>lt', trouble_fn('lsp_type_definitions')) -- TODO Should be mapped to g commands
vim.keymap.set('n', '<leader>tt', trouble_fn('todo'))

vim.keymap.set('n', 'K', vim.lsp.buf.hover)

-- TODO: Shit



-- vim.keymap.set('n', '<leader>lf', trouble_fn('lsp_definitions')) -- Already gd does this

-- TELESCOPE LSP

-- keymap.set('n', '<leader>lr', telescope_wrapper(builtin.lsp_references))
-- keymap.set('n', '<leader>ld', telescope_wrapper(builtin.lsp_definitions))
-- keymap.set('n', '<leader>lp', telescope_wrapper(builtin.lsp_implementations))
-- keymap.set('n', '<leader>lt', telescope_wrapper(builtin.lsp_type_definitions))
-- keymap.set('n', '<leader>ls', telescope_wrapper(builtin.lsp_document_symbols))
-- keymap.set('n', '<leader>li', telescope_wrapper(builtin.lsp_incoming_calls))
-- keymap.set('n', '<leader>lo', telescope_wrapper(builtin.lsp_outgoing_calls))

-- The power of g
-- g + ;: Repeat the last f or t command (find or till).
-- g + ,: Repeat the last F or T command (find or till backwards).
-- gf: Go to the file name under the cursor.
-- gF: Go to the file name under the cursor and jump to the line number following the filename.
-- gv: Reselect the last visual selection.
-- gJ: Join lines without space.
-- g;, g,: Go to older/newer position in change list
-- gu, gU: Make lowercase/uppercase
-- ga: Show ASCII value of character under cursor
-- g&: Repeat last ":s" on all lines
-- gx: Execute application for file under cursor
-- :g/pattern/command: Execute command on matching lines
