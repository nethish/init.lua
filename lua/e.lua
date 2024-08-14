local ts_utils = require 'nvim-treesitter.ts_utils'

local actions = require("telescope.actions")
local open_with_trouble = require("trouble.sources.telescope").open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require("trouble.sources.telescope").add

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    },
  },
})

-- https://google.com

-- vim.keymap.set('n', '<c-f>', ':lua vim.lsp.buf.format({ async = true })<CR>', { noremap = true, silent = true })
-- vim.keymap.set('v', '<c-f>', ':lua vim.lsp.buf.format(, {silent = true, buffer = 0})<CR>', { noremap = true, silent = true })
--
-- vim.keymap.set('v', '<leader>f', function()
--   local start_pos = vim.fn.getpos("'<")
--   local end_pos = vim.fn.getpos("'>")
--   vim.lsp.buf.format({
--     async = true,
--     range = {
--       ["start"] = {start_pos[2], start_pos[3]},
--       ["end"] = {end_pos[2], end_pos[3]},
--     }
--   })
-- end, {buffer=0})
--
-- local client = vim.lsp.get_active_clients()[1]
-- if client then
--   print(client.server_capabilities.documentRangeFormattingProvider)
-- end

-- local range_formatting = function()
--     vim.print("Range fmt")
--     local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
--     local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
--     vim.lsp.buf.format({
--         range = {
--             ["start"] = { start_row, 0 },
--             ["end"] = { end_row, 0 },
--         },
--         async = true,
--     })
-- end
--
-- vim.keymap.set("v", "<leader>f", range_formatting, { desc = "Range Formatting "})

local function create_floating_window()
    local buf = vim.api.nvim_create_buf(false, true) -- Create a new empty buffer

    -- Window options
    local opts = {
        style = "minimal",
        relative = "editor",
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.8),
        row = math.floor(vim.o.lines * 0.1),
        col = math.floor(vim.o.columns * 0.1),
        border = "single"
    }

    -- Create the window
    local win = vim.api.nvim_open_win(buf, true, opts)

    return buf, win
end

function Ruz(cmd)
  cmd = 'echo \'' .. cmd .. '\'; echo; echo; ' .. cmd

  local buf, win = create_floating_window()

  -- Run the command in the terminal
  vim.fn.termopen(cmd)


  -- Set the buffer to the terminal buffer
  vim.api.nvim_win_set_buf(win, buf)

  -- Optional: Set keybindings to close the floating window
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<Cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>close<CR>', { noremap = true, silent = true })
end




----------------------------- UI Test ----------------------------

local function a()
  local buf, win = create_floating_window() -- Create a new empty buffer


  -- Define a highlight group
  vim.api.nvim_set_hl(0, 'MyHighlightGroup', {
    fg = '#ff0000', -- Text color (red)
    bg = '#000000', -- Background color (black)
    bold = true,    -- Make the text bold
  })

  local options = {
    "option A",
    "option B",
    "option Z"
  }
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, options)
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<Cmd>close<CR>', {})
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>close<CR>', {})

  -- vim.print(buf)
  -- vim.api.nvim_buf_add_highlight(buf, -1, 'MyHighlightGroup', 0, 0, 10)
  -- local k = vim.api.nvim_buf_get_lines(buf, 0, 2, false)
  -- vim.print(k)

end

vim.keymap.set('n', '<leader>aa', a)


function CreateFloatingWindowWithText()
  -- Define the content for the buffer
  local content = {
    "This is a floating window.",
    "The cursor will not move.",
    "You can display any text here.",
  }

  -- Create a new buffer for the floating window
  local buf = vim.api.nvim_create_buf(false, true) -- Not listed, modifiable

  -- Set the buffer content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)

  -- Define the size and position of the floating window
  local width = 40
  local height = 10

  -- Get the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1] - 1, cursor_pos[2]

  -- Define floating window options
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    anchor = 'NW',
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, false, opts) -- False to not focus

  -- Set the buffer to be read-only (optional)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  -- Close the floating window when any key is pressed or buffer is left
  vim.api.nvim_create_autocmd('BufLeave', {
    buffer = buf,
    callback = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  -- Set a keymap to manually close the floating window (optional)
  vim.api.nvim_set_keymap('n', '<Esc>', ':lua if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end<CR>', { noremap = true, silent = true })
end


vim.keymap.set('n', '<leader>aa', CreateFloatingWindowWithText)
-----------------------------------------------------------

-- BUFFER APIs
-- local bufnr = vim.api.nvim_get_current_buf()
-- local lines = vim.api.nvim_buf_get_lines(bufnr, start, end, strict_indexing)
-- vim.api.nvim_buf_set_lines(bufnr, start, end, strict_indexing, lines)
-- local name = vim.api.nvim_buf_get_name(bufnr)
-- vim.api.nvim_buf_set_name(bufnr, "new_name")
-- vim.api.nvim_buf_add_highlight(bufnr, ns_id, hl_group, line, col_start, col_end)


-- WINDOW APIs
-- local win = vim.api.nvim_get_current_win()
-- local cursor_pos = vim.api.nvim_win_get_cursor(win)
-- vim.api.nvim_win_set_cursor(win, {row, col})
-- local win_id = vim.api.nvim_open_win(bufnr, enter, config)
-- vim.api.nvim_win_set_option(win, 'wrap', false)

-- TAB PAGE APIs
-- local tabpage = vim.api.nvim_get_current_tabpage()
-- local wins = vim.api.nvim_tabpage_list_wins(tabpage)
-- local win = vim.api.nvim_tabpage_get_win(tabpage)

-- GENERAL
-- vim.api.nvim_command('w')
-- vim.api.nvim_exec([[
--   augroup MyGroup
--     autocmd!
--     autocmd BufWritePost *.py lua vim.lsp.buf.formatting_sync()
--   augroup END
-- ]], false)
-- vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_var('my_var', 42)
-- local my_var = vim.api.nvim_get_var('my_var')
-- local tabstop = vim.api.nvim_get_option('tabstop')
-- vim.api.nvim_set_option('tabstop', 4)


-- TREESITTER
-- Parser
-- local parser = vim.treesitter.get_parser(0, "lua")
-- local trees = parser:parse()
--
-- Tree APIs
-- local root = tree:root()
--
-- Node APIs
-- local node_type = node:type()
-- local parent = node:parent()
-- local child = node:child(0)
-- for child in node:children() do
--   print(child:type())
-- end
-- for named_child in node:named_children() do
--   print(named_child:type())
-- end
-- local start_row, start_col = node:start()
-- local end_row, end_col = node:end_()
-- local text = vim.treesitter.get_node_text(node, 0)

-- Query
-- local query = vim.treesitter.query.get("lua", "highlights")
-- for _, match, _ in query:iter_matches(root, bufnr, 0, -1) do
--   for id, node in pairs(match) do
--     local name = query.captures[id]
--     local node_text = vim.treesitter.get_node_text(node, bufnr)
--     print(name, node_text)
--   end
-- end
-- for id, node, _ in query:iter_captures(root, bufnr, 0, -1) do
--   local name = query.captures[id]
--   local node_text = vim.treesitter.get_node_text(node, bufnr)
--   print(name, node_text)
-- end
-- local text = vim.treesitter.get_node_text(node, 0)
-- vim.treesitter.set_query("lua", "highlights", [[
--   (function_declaration
--     name: (identifier) @function)
-- ]])


-- Highlights and Navigation

-- local hl = vim.treesitter.highlighter.new(parser)
-- local captures = vim.treesitter.get_captures_at_pos(0, row, col)
-- for _, capture in ipairs(captures) do
--   print(capture.capture)
-- end
----------------------------

local function get_node_name(node)
  local name_field = node:field('name')[1]
  return vim.treesitter.get_node_text(name_field, 0)
end


vim.api.nvim_create_user_command('FF', function()
    local node = ts_utils.get_node_at_cursor()

    while node do
        if node:type() == 'method_declaration' then
            break
        end
        node = node:parent()
    end

    if node == nil then
      print "Not inside a function"
      return
    end

    local test_name_node = node:field('name')[1]
    local test_name = vim.treesitter.get_node_text(test_name_node, 0)


    local root = find_go_project_root()
    local cmd = "cd " .. root .. ";"
    cmd = cmd .. 'gotestsum --format testname -- -v ./internal/engine/profile_monitor -testify.m ' .. test_name
    -- vim.print(vim.treesitter.query_get_node_text(test_name_node, 0))
    --

    vim.print(cmd)
    Ruz(cmd)


end, {})



local function create_popup()
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Get the editor's width and height
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- Calculate our floating window size
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)

  -- Calculate starting position
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  -- Set some options
  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, opts)

  return {
    buf = buf,
    win = win
  }
end

-- NVIM treesitter

-- print(vim.print(ts_utils))
--
--:h nvim-treesitter-utils

function a()
  local a = 10
end








-- vim.api.nvim_set_keymap('n', '<leader>ft', ':lua Ruz("while true; do echo 1; sleep 1; done")<CR>', { noremap = true, silent = true })


-- local ts_utils = require('nvim-treesitter.ts_utils')
--
-- vim.api.nvim_create_user_command('HH', function()
--     local node = ts_utils.get_node_at_cursor()
--     while node do
--         if node:type() == 'function_declaration' or node:type() == 'function_definition' then
--             local start_row, start_col, end_row, end_col = node:range()
--             local ns = vim.api.nvim_create_namespace('TSHighlightFunction')
--             vim.highlight.range(0, ns, 'Visual', {start_row, start_col}, {end_row, end_col}, 'v', true)
--             return
--         end
--         node = node:parent()
--     end
--     print "Not inside a function"
-- end, {})
--



return create_popup






--
----------------------
-- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
-- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
-- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
-- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--------------------------------
