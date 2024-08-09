
---
--------------------------------------------------EVENTS--------------------------------------------------
--
-- BufAdd: Triggered when a buffer is added.
-- BufDelete: Triggered when a buffer is deleted.
-- BufEnter: Triggered when entering a buffer.
-- BufLeave: Triggered when leaving a buffer.
-- BufNewFile: Triggered when creating a new file.
-- BufRead: Triggered when reading a buffer (before the buffer's contents are read).
-- BufReadPost: Triggered after reading the buffer (after the buffer's contents are read).
-- BufWrite: Triggered when writing to a buffer (before the buffer is written to a file).
-- BufWritePre: Triggered just before writing a buffer to a file.
-- BufWritePost: Triggered just after writing a buffer to a file.
-- BufWinEnter: Triggered when entering a window displaying a buffer.
-- BufWinLeave: Triggered when leaving a window displaying a buffer.
--
-- WinEnter: Triggered when entering a window.
-- WinLeave: Triggered when leaving a window.
-- WinScrolled: Triggered when a window is scrolled.
--
-- TabEnter: Triggered when entering a tab page.
-- TabLeave: Triggered when leaving a tab page.
--
-- InsertEnter: Triggered when entering insert mode.
-- InsertLeave: Triggered when leaving insert mode.
-- TextChanged: Triggered when text in a buffer changes.
-- TextChangedI: Triggered when text changes in insert mode
--
-- FileType: Triggered when the file type is detected.
-- Syntax: Triggered when syntax highlighting is enabled.
--
-- ColorScheme: Triggered when the color scheme changes.
-- CmdlineEnter: Triggered when entering command-line mode.
-- CmdlineLeave: Triggered when leaving command-line mode.
-- ShellCmdPost: Triggered after executing a shell command.
-- QuitPre: Triggered just before exiting Vim.
-- SessionLoadPost: Triggered after a session is loaded.
-- FocusGained: Triggered when Neovim gains focus (useful for GUI clients).
-- FocusLost: Triggered when Neovim loses focus (useful for GUI clients).
--
---------------------------------------------------------------------------------------------------

local otils = vim.api.nvim_create_augroup("otils", { clear = true })

-- Close :Gitsigns blame
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitsigns.blame",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', ':q<CR>', {noremap = true, silent = true})
  end,
  group = otils,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<C-C>', {noremap = false, silent = true})
    vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', '<C-C>', {noremap = false, silent = true})
  end,
  group = otils,
})

----------------------------------------------------------------------------------------------------

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "vim",
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, "n", "q", "<C-C>", { noremap = true, silent = true })
--   end,
--   group = otils,
-- })

local M = {}

M.create_floating_window = function()
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

M.run = function(cmd)
  cmd = 'echo \'' .. cmd .. '\'; echo; echo; ' .. cmd

  local buf, win = M.create_floating_window()

  -- Run the command in the terminal
  vim.fn.termopen(cmd)


  -- Set the buffer to the terminal buffer
  vim.api.nvim_win_set_buf(win, buf)

  -- Optional: Set keybindings to close the floating window
  vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', '<Cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<Cmd>close<CR>', { noremap = true, silent = true })
end

M.find_go_root = function()
    -- Specify the marker files that indicate the root of a Go project
    local root_files = { 'go.mod' }

    -- Find the nearest directory containing any of the root files
    local root_dir = vim.fs.find(root_files, {
        upward = true,
        stop = vim.loop.os_homedir()
    })[1]

    if root_dir then
        -- Extract the directory name from the found file path
        root_dir = vim.fs.dirname(root_dir)
    end

    return root_dir
end

M.tests = function()
    -- Define the query to find method declarations
    local query = [[
      (
        method_declaration
        name: (field_identifier) @method_name
        (#match? @method_name "^Test")
      )
    ]]

    -- Get the parser for the current buffer (0) and parse the syntax tree
    local parser = vim.treesitter.get_parser(0, 'go')
    local tree = parser:parse()[1]

    -- Get the root node of the syntax tree
    local root = tree:root()

    -- Prepare to store the method names
    local method_names = {}

    -- Create a query object and iterate over matches
    local query_object = vim.treesitter.query.parse('go', query)
    for _, captures, _ in query_object:iter_matches(root, 0) do
        for _, node in pairs(captures) do
            local name = vim.treesitter.get_node_text(node, 0)
            table.insert(method_names, name)
        end
    end

    vim.print(method_names)
    return method_names
end

M.run_go_tests = function()

  local tests = M.tests()
  local root = M.find_go_root()

  local cmd = "cd " .. root .. "; "

  local current_file = vim.api.nvim_buf_get_name(0)

  local file_directory = vim.fn.fnamemodify(current_file, ":p:h")

  local t = table.concat(tests, " ")
  cmd = cmd .. 'gotestsum --format testname -- -v ' .. file_directory .. ' -testify.m ' .. t

  M.run(cmd)
end

--------------------------------------------------GO--------------------------------------------------

local go = vim.api.nvim_create_augroup("go", { clear = true })

vim.api.nvim_create_autocmd({'BufEnter'}, {
  pattern = {"*.go"},
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>mt', '', {callback = M.run_go_tests})
  end,
  group = go
})

------------------------------------------------------------------------------------------------------

