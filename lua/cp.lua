vim.api.nvim_create_autocmd(
    {"BufEnter", "BufWinEnter"},
    {
        pattern = {"*.cpp"},
        callback = function()
            vim.keymap.set('n', '<leader>rr', ':w <bar> !g++ -std=c++14 % -o %:r &> output && ./%:r < input > output && rm ./%:r<CR><CR>')
            vim.keymap.set('n', '<leader>tt', ':!cp ~/repos/CP/templates/template.cpp % <CR><CR> /start_here<CR>')
            vim.cmd "T2"
        end
    }
    -- command = "nnoremap <leader>rr :w <bar> !g++ -std=c++14 % -o %:r &> output && ./%:r < input > output && rm ./%:r<CR><CR>"
)

vim.api.nvim_create_autocmd(
    {"BufEnter", "BufWinEnter"},
    {
        pattern = {"*.py"},
        callback = function()
            vim.keymap.set('n', '<leader>rr', ':w <bar> !python3 % < input > output 2>&1<CR><CR>')
            vim.keymap.set('n', '<leader>tt', ':!cp ~/repos/CP/templates/template.py % <CR><CR> /start_here<CR>')
        end
    }
)

vim.keymap.set('n', '<leader>st', '/start_here<CR>ciw')
vim.keymap.set('n', '<leader>sd', '<C-L><C-L><C-K><C-K>gg"_dGP<C-H><C-H>', {remap=true });
