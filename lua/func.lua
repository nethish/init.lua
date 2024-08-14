

-- List of custom func

local M = {}

M.create_hover = function(opts)
  local width = opts.width or 10
  local height = opts.height or 10
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- -- Calculate our floating window size
  -- local win_height = math.ceil(height * 0.8 - 4)
  -- local win_width = math.ceil(width * 0.8)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1] + 1, cursor_pos[2] + 6

  vim.print(row, col)
  -- Set some options
  local win_opts = {
    style = "minimal",
    relative = "cursor",
    width = width,
    height = height,
    row = 1,
    col = 0,
    anchor = 'NW',
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, false, win_opts)

  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<Cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>close<CR>', { noremap = true, silent = true })

  local group = 'func'
  local group_id = vim.api.nvim_create_augroup(group, {})
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'WinScrolled', 'WinClosed' }, {
      group = group_id,
      callback = function()
          vim.api.nvim_create_augroup(group, {})
          pcall(vim.api.nvim_win_close, win, true)
        end
    })
  return {
    buf = buf,
    win = win
  }
end

M.create_popup = function()
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

  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<Cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>close<CR>', { noremap = true, silent = true })

  return {
    buf = buf,
    win = win
  }
end

return M
